using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ClinicaFrba.Clases;
using System.Data.SqlClient;


namespace ClinicaFrba.Compra_Bono
{
    public partial class CompraBono : Form
    {
        Int32 precioBono;
        Int32 cantBonos;
        Int32 precioTotal;


        public CompraBono()
        {
            InitializeComponent();
        }

        private void textBoxNroAfiliado_TextChanged(object sender, EventArgs e)
        {

        }

        private void CompraBono_Load(object sender, EventArgs e)
        {
            String query;
            if (Repositorio.getUserActual().rolActual == "Afiliado")
            {

                query = "SELECT Id_afiliado FROM TRIGGER_EXPLOSION.Afiliado WHERE Id_usuario = " + Repositorio.getUserActual().Id_usuario;
                String id_afiliado = ManejadorConexiones.ExecuteScalar(query).ToString();
                textBoxNroAfiliado.Text = id_afiliado;
                this.textBoxNroAfiliado.ReadOnly = true;
            }

            textBoxPrecio.ReadOnly = true;
            
            
        }

        private void textBoxNroAfiliado_Leave(object sender, EventArgs e)
        {
            String query = "select Precio_bono_consulta from TRIGGER_EXPLOSION.Afiliado a JOIN TRIGGER_EXPLOSION.PlanMedico p ON (a.Plan_id = p.Id_plan) where Id_afiliado = " + textBoxNroAfiliado.Text;
            precioBono = Convert.ToInt32(ManejadorConexiones.ExecuteScalar(query));

        }

        private void textBoxCantBonos_TextChanged(object sender, EventArgs e)
        {
            if (textBoxCantBonos.Text != "")
            {
                cantBonos = Convert.ToInt32(textBoxCantBonos.Text);
                precioTotal = precioBono * cantBonos;
                textBoxPrecio.Text = Convert.ToString(precioTotal);
            }
            else
            {
                textBoxPrecio.Text = "";
            }
        }

        private void btn_cancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_comprar_Click(object sender, EventArgs e)
        {
            List<SqlParameter> parametros = new List<SqlParameter>();
            parametros.Add(new SqlParameter("id_afiliado", Convert.ToInt32(textBoxNroAfiliado.Text)));
            parametros.Add(new SqlParameter("cantidad", cantBonos));
            parametros.Add(new SqlParameter("precioTotal", precioTotal));
            ManejadorConexiones.ExecuteQuery("TRIGGER_EXPLOSION.comprarBonos", parametros);
            MessageBox.Show("Se compraron " + cantBonos + " bonos satisfactoriamente");
            this.Close();
        }
    }
}
