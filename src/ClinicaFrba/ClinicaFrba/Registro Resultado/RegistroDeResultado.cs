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


namespace ClinicaFrba.Registro_Resultado
{
    public partial class RegistrarResultado : Form
    {

        int id_profesional = 15;
        int id_afiliado;

        public RegistrarResultado()
        {
            

            InitializeComponent();
            Diagnostico.Visible = false;
            Diagnosticar.Visible = false;
            Sintomas.Visible = false;
        }

        private void Aceptar_Click(object sender, EventArgs e)
        {
            
            if (checkCampos())
            {

                try{
                    SqlCommand cmd = new SqlCommand("SELECT Id_afiliado FROM TRIGGER_EXPLOSION.Afiliado WHERE Numero_documento =" + Documento.Text, ManejadorConexiones.conectar()); //Agregar este Stored

                   

                    using (var reader = cmd.ExecuteReader())
                    {
                        reader.Read();

                      
                            int a = Convert.ToInt32(reader.GetValue(0));
                            id_afiliado = a;
                           

                            
                    }

                    AplicarDiagnostico();
                        
                }catch{
                    MessageBox.Show("El documento ingresado no corresponde a un afiliado");
                    return;
                }
                //Termina conexion - Area text diagnostico


                
            };
        }

        private void Documento_TextChanged_1(object sender, EventArgs e)
        {
            //Docuemtno
        }



        private void Hora_TextChanged(object sender, EventArgs e)
        {
            //hora ocurrida
        }

        private void Fecha_TextChanged(object sender, EventArgs e)
        {
            //fecha ocurrida
        }

        private void Diagnostico_TextChanged(object sender, EventArgs e)
        {
            //Area text diagnostico
        }

        private bool checkCampos()
        {
            if (Documento.Text.Length == 0 || Fecha.Text.Length == 0 || Hora.Text.Length == 0)
            {

                MessageBox.Show("Faltan completar datos para poder realizar el diagnostico");
                return false;

            }
            else
            {
                return true;
            }

        }



        private void Diagnosticar_Click(object sender, EventArgs e)
        {
            string sqlString = "UPDATE TRIGGER_EXPLOSION.ConsultaMedica SET Sintomas='" + Sintomas.Text + "', Diagnostico='" + Sintomas.Text + "', Consulta_realizada=1 WHERE Id_consulta=(	SELECT MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada<= '" + (Fecha.Text + " " + Hora.Text) + "')";
            string sqlString2 ="UPDATE TRIGGER_EXPLOSION.Turno SET Fecha_y_hora_llegada='"+(Fecha.Text + " " + Hora.Text) + "' WHERE Id_turno=(	SELECT  MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada <= '"+(Fecha.Text + " " + Hora.Text) + "')";
            try
            { // UPDATE TRIGGER_EXPLOSION.Turno SET Fecha_y_hora_llegada='"+(Fecha.Text + " " + Hora.Text) + "' WHERE Id_turno=(	SELECT  MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada <= '"+(Fecha.Text + " " + Hora.Text) + "')";

            SqlCommand command = new SqlCommand(sqlString, ManejadorConexiones.conectar());
            SqlCommand command2 = new SqlCommand(sqlString2, ManejadorConexiones.conectar());//Agregar este Stored
            command.ExecuteNonQuery();
            command2.ExecuteNonQuery();

            MessageBox.Show("CARGA EXITOSA"); RegistrarResultado NewForm = new RegistrarResultado();
            NewForm.Show();
            this.Dispose(false);
             
          } catch { MessageBox.Show("Ocurrio un error, intentelo de nuevo"); }
        }

        private void Asistencia_CheckedChanged(object sender, EventArgs e)
        {
            //checkbox
        }


        private void AplicarDiagnostico()
        {
            if(Asistencia.Checked){

                Diagnostico.Visible = true;
                Diagnosticar.Visible = true;
                Sintomas.Visible = true;
                //Diagnostico.Text, Fecha.Text +Hora.Text, Sintomas.Text

      
            }else{

             
                try
                {
                    
                    string query = "UPDATE TRIGGER_EXPLOSION.ConsultaMedica SET Consulta_realizada=0, Fecha_y_hora='" + (string)(Fecha.Text + Hora.Text) + "' WHERE Id_consulta=(	SELECT Id_consulta FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada< '" + (string)(Fecha.Text + Hora.Text) + "')";;

                    SqlCommand cmd = new SqlCommand(query, ManejadorConexiones.conectar()); //Agregar este Stored
                    cmd.ExecuteNonQuery();

                    MessageBox.Show("CARGA EXITOSA"); RegistrarResultado NewForm = new RegistrarResultado();
                    NewForm.Show();
                    this.Dispose(false);


                } catch{
                    MessageBox.Show("Ocurrio un error, intentelo de nuevo");
                    return;
                };
                //catch
            }
           
        }

        private void Sintomas_TextChanged(object sender, EventArgs e)
        {

        }
       








    }
}
