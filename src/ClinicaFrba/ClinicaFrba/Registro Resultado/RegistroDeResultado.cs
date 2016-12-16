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
using System.Globalization;


namespace ClinicaFrba.Registro_Resultado
{
    public partial class RegistrarResultado : Form
    {

        int user_id = Convert.ToInt32(Interfaz.Interfaz.usuario.Id_usuario);
        int id_profesional;
        int id_afiliado;
        Int64 id_consulta;

        public RegistrarResultado()
        {
            

            InitializeComponent();
            Diagnostico.Visible = false;
            Diagnosticar.Visible = false;
            Sintomas.Visible = false;
        }

        private void Aceptar_Click(object sender, EventArgs e)
        {
            id_profesional = getProfesionalId();


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

                    if (getIdConsulta()) {
                        AplicarDiagnostico();
                    };

                    
                        
                }catch{
                    MessageBox.Show("El documento ingresado no corresponde a un afiliado");
                    return;
                }
                //Termina conexion - Area text diagnostico


                
            };
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

                try
                {
                    string format = "yyyy-MM-dd";
                    string format2 = "HH:mm";
                    var provider = new CultureInfo("es-AR");
                    DateTime.ParseExact(Fecha.Text, format, provider);
                    
                    DateTime.ParseExact(Hora.Text, format2, provider);
                   

                    return true;
                }
                catch (Exception e)
                {
                    MessageBox.Show("Datos ingresados incorrectamente");
                    return false;
                }
                 
            }

        }



        private void Diagnosticar_Click(object sender, EventArgs e)
        {
            string sqlString = "UPDATE TRIGGER_EXPLOSION.ConsultaMedica SET Sintomas='" + Sintomas.Text + "', Diagnostico='" + Diagnostico.Text + "', Consulta_realizada=1 WHERE Id_consulta=" + id_consulta;
            
            //string sqlString2 ="UPDATE TRIGGER_EXPLOSION.Turno SET Fecha_y_hora_llegada='"+(Fecha.Text + " " + Hora.Text) + "' WHERE Id_turno=(	SELECT  MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada <= '"+(Fecha.Text + " " + Hora.Text) + "')";
           
            try
            { 
                
                // UPDATE TRIGGER_EXPLOSION.Turno SET Fecha_y_hora_llegada='"+(Fecha.Text + " " + Hora.Text) + "' WHERE Id_turno=(	SELECT  MAX(Id_consulta) FROM TRIGGER_EXPLOSION.ConsultaMedica, TRIGGER_EXPLOSION.Turno WHERE ConsultaMedica.Id_consulta = Turno.Id_turno AND Id_profesional =" + id_profesional + " AND Id_afiliado=" + id_afiliado + " AND Fecha_programada <= '"+(Fecha.Text + " " + Hora.Text) + "')";
                ManejadorConexiones.desconectar();
            SqlCommand command = new SqlCommand(sqlString, ManejadorConexiones.conectar());
          
                // SqlCommand command2 = new SqlCommand(sqlString2, ManejadorConexiones.conectar());//Agregar este Stored
           
                command.ExecuteNonQuery();
                ManejadorConexiones.desconectar();
          
                // command2.ExecuteNonQuery();

            MessageBox.Show("CARGA EXITOSA"); 
            this.Close();
             
          } catch { MessageBox.Show("Ocurrio un error, intentelo de nuevo"); }
        }

        private void Asistencia_CheckedChanged(object sender, EventArgs e)
        {
            //checkbox
        }


        private void AplicarDiagnostico()
        {
           // ManejadorConexiones.desconectar();
           // id_consulta = Convert.ToInt64(ManejadorConexiones.ExecuteScalar("select TOP 1 id_turno from TRIGGER_EXPLOSION.Turno WHERE id_afiliado = " + id_afiliado + " AND id_profesional = " + id_profesional + " ORDER BY fecha_programada ASC"));
           // Int32 total_consultas = Convert.ToInt32(ManejadorConexiones.ExecuteScalar("select COUNT(*) FROM TRIGGER_EXPLOSION.ConsultaMedica WHERE id_consulta = " + id_consulta));

           // if (total_consultas == 0)
           // {
           //     MessageBox.Show("El paciente aún no ha dado el presente en administracion. Por favor que se acerque por allí primero");
           //     this.Close();
           //     return;

           // }
           // ManejadorConexiones.conectar();

            if(Asistencia.Checked){

                Diagnostico.Visible = true;
                Diagnosticar.Visible = true;
                Sintomas.Visible = true;
                //Diagnostico.Text, Fecha.Text +Hora.Text, Sintomas.Text

      
            }else{

             
                try
                {
                    
                    string query5 = "UPDATE TRIGGER_EXPLOSION.ConsultaMedica SET Consulta_realizada=1, Fecha_y_hora='" + (string)(Fecha.Text +" "+ Hora.Text) + "' WHERE Id_consulta="+id_consulta;
                    SqlCommand cmd5 = new SqlCommand(query5, ManejadorConexiones.conectar()); //Agregar este Stored
                    cmd5.ExecuteNonQuery();

                    MessageBox.Show("CARGA EXITOSA"); 
                    this.Close();


                } catch{
                    MessageBox.Show("Ocurrio un error, intentelo de nuevo");
                    return;
                }
                //catch
           }
           
       }


        public int getProfesionalId()
        {


            string sqlQuery = "SELECT Id_profesional FROM TRIGGER_EXPLOSION.Profesional  WHERE Id_usuario =" + user_id;


            SqlCommand sqlCommand = new SqlCommand(sqlQuery, ManejadorConexiones.conectar());

            SqlDataReader reader = sqlCommand.ExecuteReader();


            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    var a = reader.GetValue(0);


                    reader.Close();
                    return Convert.ToInt32(a);

                }
            }
            else
            {
                MessageBox.Show("No es un numero de profesional válido");
                reader.Close();
            }


            return 1;
        }

        private void RegistrarResultado_Load(object sender, EventArgs e)
        {

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

        private void Sintomas_TextChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }


        public bool getIdConsulta() {

            string query = "select Id_turno from TRIGGER_EXPLOSION.Turno where Id_profesional=" + id_profesional + " and Id_afiliado=" + id_afiliado + " and Cancelado=0 and '" + Fecha.Text + "'=FORMAT(Fecha_programada,'yyyy-MM-dd') and  '" + Hora.Text + "'=FORMAT(Fecha_programada,'hh:mm')";

            SqlCommand sqlCommand = new SqlCommand(query, ManejadorConexiones.conectar());

            SqlDataReader reader = sqlCommand.ExecuteReader();


            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    id_consulta = Convert.ToInt32(reader.GetValue(0));
                    
                }

                reader.Close();
               
            }
            else
            {
                MessageBox.Show("El turno no existe en nuestra base de datos o ha sido cancelada");

                reader.Close();
                return false;
            }

            
            string query2 = " select * from TRIGGER_EXPLOSION.ConsultaMedica where Id_consulta="+id_consulta;

            SqlCommand newComand = new SqlCommand(query2, ManejadorConexiones.conectar());

            SqlDataReader reader3 = newComand.ExecuteReader();

            if (reader3.HasRows)
            {
                reader3.Close();
                return true;

            }
            else
            {
                reader3.Close();
                MessageBox.Show("La consulta no se ha generado, primero debe el afiliado registrar su llegada en administracion");

                return false;
            }

            
        }


    }
}
