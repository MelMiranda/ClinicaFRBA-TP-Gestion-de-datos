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

namespace ClinicaFrba.Registro_Llegada
{
    public partial class RegistroDeLlegada : Form

        
    {
        string[] elementos;
        int id_afiliado;
        int id_profesional;


        private void RegistroDeLlegada_Load(object sender, EventArgs e)
        {
            string[] elementos = { Documento.Text, Nombre.Text, Profesional.Text, FechaYHora.Text, Especialidad.Text };
        }



        public RegistroDeLlegada()
        {
            InitializeComponent();
        }


        private void Aceptar_Click(object sender, EventArgs e)
        {

            if(CheckCampos()){

                id_afiliado= getIdAfiliado();
                id_profesional=getIdProfesional();


                string sqlString2 = "UPDATE TRIGGER_EXPLOSION.Turno SET Fecha_y_hora_llegada='" + FechaYHora.Text + "' WHERE Id_turno=(	SELECT  MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada <= '"+FechaYHora.Text+"')";
                try
                { // UPDATE TRIGGER_EXPLOSION.Turno SET Fecha_y_hora_llegada='"+(Fecha.Text + " " + Hora.Text) + "' WHERE Id_turno=(	SELECT  MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada <= '"+(Fecha.Text + " " + Hora.Text) + "')";

                   
                    SqlCommand command2 = new SqlCommand(sqlString2, ManejadorConexiones.conectar());//Agregar este Stored
                    
                    command2.ExecuteNonQuery();

                    MessageBox.Show("CARGA EXITOSA"); RegistroDeLlegada NewRegistro = new RegistroDeLlegada();
                    NewRegistro.Show();
                    this.Dispose(false);

                }
                catch { MessageBox.Show("Ocurrio un error, intentelo de nuevo"); }

                
            }
            else
            {
                MessageBox.Show("CAmpos vacios");
            }
        }

        private void Documento_TextChanged(object sender, EventArgs e)
        {

        }

        private void Nombre_TextChanged(object sender, EventArgs e)
        {

        }

        private void Profesional_TextChanged(object sender, EventArgs e)
        {

        }

        private void FechaYHora_TextChanged(object sender, EventArgs e)
        {

        }

        private void Especialidad_TextChanged(object sender, EventArgs e)
        {

        }

        public  bool CheckCampos()
        {


            if (Documento.Text.Length == 0 || Nombre.Text.Length == 0 || Profesional.Text.Length == 0 || FechaYHora.Text.Length == 0 || Especialidad.Text.Length == 0)
            {
                MessageBox.Show("Campos Vacios");
                return false;
            }
            else
            {
                MessageBox.Show("Campos Llenos");
                return true;
            }
        }


        public int getIdProfesional()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT Id_profesional FROM TRIGGER_EXPLOSION.Profesional WHERE Nombre =" + Nombre.Text+" AND Apellido="+Profesional.Text , ManejadorConexiones.conectar()); //Agregar este Stored



                using (var reader = cmd.ExecuteReader())
                {
                    reader.Read();


                    int a = Convert.ToInt32(reader.GetValue(0));
                    id_afiliado = a;



                }



            }
            catch
            {
                MessageBox.Show("No se encontro el profesional en la base de datos");

            }

            return id_profesional;
        }

        public int getIdAfiliado()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT Id_afiliado FROM TRIGGER_EXPLOSION.Afiliado WHERE Numero_documento =" + Documento.Text, ManejadorConexiones.conectar()); //Agregar este Stored



                using (var reader = cmd.ExecuteReader())
                {
                    reader.Read();


                    int a = Convert.ToInt32(reader.GetValue(0));
                    id_afiliado = a;



                }

                

            }
            catch
            {
                MessageBox.Show("El documento ingresado no corresponde a un afiliado");
                
            }

            return id_afiliado;
        }

        
       
       

      

       
    }
}
