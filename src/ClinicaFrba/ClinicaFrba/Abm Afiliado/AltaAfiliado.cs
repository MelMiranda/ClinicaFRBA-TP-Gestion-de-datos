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

namespace ClinicaFrba.Abm_Afiliado
{
    public partial class AltaAfiliado : Form
    {
        Interfaz.Interfaz interfaz = new Interfaz.Interfaz();
        String existeElUsuario;

        public AltaAfiliado()
        {
            InitializeComponent();
        }

        private void Box_tipoDoc_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void AltaUsuario_Load(object sender, EventArgs e)
        {
            this.Box_fechaNac.MaxDate = DateTime.Now;
            String getTiposDeDocumento = "select Id_tipo_documento id, Descripcion valor from TRIGGER_EXPLOSION.TipoDocumento";
            interfaz.cargarComboIDValor(this.comboBox1, getTiposDeDocumento);
            String getEstadoCivil = "select Id_estado_civil id, Descripcion valor from TRIGGER_EXPLOSION.EstadoCivil";
            interfaz.cargarComboIDValor(this.comboBox3, getEstadoCivil);
            String getPlanesMedicos = "select Id_plan id, Descripcion valor from TRIGGER_EXPLOSION.PlanMedico";
            interfaz.cargarComboIDValor(this.comboBox4, getPlanesMedicos);
            this.comboBox2.Text = "Seleccione una opción ....";
            this.comboBox2.Items.Add("masculino");
            this.comboBox2.Items.Add("femenino");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String username;
            List<SqlParameter> parametros = new List<SqlParameter>();

            if (textBoxUsername.Text == "") // El administrador desconoce el username
            {
                existeElUsuario = "SELECT * FROM TRIGGER_EXPLOSION.Usuario WHERE Username = '" + Box_documento.Text + "'";
                username = Box_documento.Text;
            }
            else
            {
                existeElUsuario = "SELECT * FROM TRIGGER_EXPLOSION.Usuario WHERE Username = '" + textBoxUsername.Text + "'";
                username = textBoxUsername.Text;
            }

            parametros.Add(new SqlParameter("username", username));
            parametros.Add(new SqlParameter("nombre", Box_nombre.Text));
            parametros.Add(new SqlParameter("apellido", Box_apellido.Text));
            parametros.Add(new SqlParameter("descripcion_tipo_documento", comboBox1.Text));
            parametros.Add(new SqlParameter("numero_documento", Convert.ToInt32(Box_documento.Text)));
            parametros.Add(new SqlParameter("sexo", comboBox2.Text));
            parametros.Add(new SqlParameter("direccion", Box_direccion.Text));
            parametros.Add(new SqlParameter("telefono", Convert.ToInt32(Box_telefono.Text)));
            parametros.Add(new SqlParameter("mail", Box_mail.Text));
            parametros.Add(new SqlParameter("fecha_nacimiento", Box_fechaNac.Value.Date));
            parametros.Add(new SqlParameter("descripcion_estado_civil", comboBox3.Text));
            parametros.Add(new SqlParameter("descripcion_plan_medico", comboBox4.Text));

            Object usuario = ManejadorConexiones.ExecuteScalar(existeElUsuario);
            if (usuario == null) // Aun no existe el usuario
            {
                AltaUsuario altaUsuario = new AltaUsuario(username);
                altaUsuario.ShowDialog();
            }
            else 
            {
            
                ManejadorConexiones.ExecuteQuery("TRIGGER_EXPLOSION.alta_afiliado", parametros);
                MessageBox.Show("Afiliado creado con exito");
                this.Close();
            }
            

        }

        private void Box_documento_TextChanged(object sender, EventArgs e)
        {
            
            
        }
    }
}
