using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using ClinicaFrba.Clases;

namespace ClinicaFrba.Cancelar_Turno
{
    public partial class AfiliadoCancelarTurno : Form
    {
        Int32 Id_turno = -1;
        Interfaz.Interfaz interfaz = new Interfaz.Interfaz();

        public AfiliadoCancelarTurno()
        {
            InitializeComponent();
        }

        private void AfiliadoCancelarTurno_Load(object sender, EventArgs e)
        {
            List<SqlParameter> parametros = new List<SqlParameter>();
            parametros.Add(new SqlParameter("username", Repositorio.getUserActual().getUserId()));
            Interfaz.Interfaz.cargarGrillaSP(dataGridTurnos, "TRIGGER_EXPLOSION.turnos_dia_siguiente", parametros);
            
            if (dataGridTurnos.RowCount <= 0)
            {
                MessageBox.Show("No tiene turnos programados. Recuerde no puede cancelar turnos el mismo dia de la consulta");
                this.Close();
            }

           
            interfaz.cargarComboIDValor(comboBox1, "select t.Id_tipo_cancelacion id, t.Descripcion valor from TRIGGER_EXPLOSION.TipoCancelacion t");

        }

        private void buttonCancelarTurno_Click(object sender, EventArgs e)
        {
            if (Id_turno == -1) 
            {
                MessageBox.Show("Por favor, seleccione del listado el turno que desea cancelar");
            }
            else
            {
                List<SqlParameter> parametros = new List<SqlParameter>();
                parametros.Add(new SqlParameter("id_turno", Id_turno));
                parametros.Add(new SqlParameter("motivo_cancelacion", richTextMotivo.Text));
                parametros.Add(new SqlParameter("id_tipo_cancelacion", comboBox1.SelectedIndex));
                ManejadorConexiones.ExecuteQuery("TRIGGER_EXPLOSION.cancelar_turno", parametros);
                MessageBox.Show("Turno cancelado satisfactoriamente");
                this.Close();
            }
        }

        private void dataGridTurnos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int FilaSeleccionada = e.RowIndex;
            Id_turno = Convert.ToInt32(dataGridTurnos.Rows[FilaSeleccionada].Cells["Turno"].Value.ToString());
        }
    }
}
