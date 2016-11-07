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



namespace ClinicaFrba.Registrar_Agenta_Medico
{
      

    public partial class RegistrarAgenda : Form
    {
        public int user_id=5553;
        //variable que debee ser accedida globalmente;
        public int retorno;

        

        public RegistrarAgenda()
        {
            InitializeComponent();
        }

        private void RegistrarAgenda_Load(object sender, System.EventArgs e)
        {
            try
            {
                //comboBox1.Items.Clear();
                SqlCommand cmd = new SqlCommand("SELECT Descripcion FROM TRIGGER_EXPLOSION.Especialidad ", ManejadorConexiones.conectar());
                cmd.ExecuteNonQuery();
                DataTable data = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(data);

                foreach (DataRow dr in data.Rows)
                {
                    comboBox1.Items.Add(dr["Descripcion"]).ToString();
                    //comboBox1.Text = comboBox1.SelectedItem.ToString();
                    //Arreglar 
                }


            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
        }


        private void label1_Click(object sender, EventArgs e)
        {
             
        }

    

        public int  getProfesionalId() {


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
                Console.WriteLine("No es un numero de profesional valido");
                reader.Close();
            }

           

            return 1;
        }


        private void Aceptar_Click_1(object sender, EventArgs e){

 
            int id_profesional = getProfesionalId();

           // getDisponibilidad();
            

            if(checkCampos()){

                if (CheckExistencia(id_profesional))
                {
                    try
                    {
                        AgregarDataEnAgenda(id_profesional);
                        MessageBox.Show("Carga Existosa");
                    }
                    catch
                    {
                        MessageBox.Show("Error en la carga. Intente nuevamente");
                    };
                    //termina if pos
                }
                else {
                    MessageBox.Show("No hay disponibilidad en el horario especificado");
                }

               

                
            }           

       
        
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                comboBox1.Items.Clear();
                SqlCommand cmd = new SqlCommand("SELECT Descripcion FROM TRIGGER_EXPLOSION.Especialidad ", ManejadorConexiones.conectar());
                cmd.ExecuteNonQuery();
                DataTable data = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(data);

                foreach (DataRow dr in data.Rows)
                {
                    comboBox1.Items.Add(dr["Descripcion"]).ToString();
                }


            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
        }



       

     
        private bool checkCampos() {

            if (FechaInit.Text.Length == 0 || FechaFin.Text.Length == 0 || comboBox1.Text.Length == 0 || horaInit.Text.Length == 0 || horaFin.Text.Length==0)
            {
                MessageBox.Show("Los campos no pueden estar vacios");
                return false;
                

                }else{
                    return true;
                }

          //   FechaInit.Text,FechaFin.Text,comboBox1.Text, horaInit.Text,horaFin.Text 
       
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void RegistrarAgenda_Load_1(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void horaInit_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void horaFin_TextChanged(object sender, EventArgs e)
        {

        }

        private void FechaInit_TextChanged(object sender, EventArgs e)
        {

        }

        private void FechaFin_TextChanged(object sender, EventArgs e)
        {

        }

        private void AgregarDataEnAgenda(int id) { 

                 using (SqlConnection sqlConnection = ManejadorConexiones.conectar())
            {
                string query = "INSERT INTO TRIGGER_EXPLOSION.Agenda (Id_profesional, Fecha_inicio,Fecha_fin, Especialidad)VALUES (" + id + ", '" + FechaInit.Text+" "+horaInit.Text+ "','" + FechaFin.Text +" "+horaFin.Text+"', '" + comboBox1.GetItemText(this.comboBox1.SelectedItem)+ "')";

                SqlCommand cmd = new SqlCommand(query, ManejadorConexiones.conectar()); //Agregar este Stored
               
           

                //(EndDate - StartDate).TotalDays
                  //dateValue.ToString("dddd", new CultureInfo("es-ES"))
                cmd.ExecuteNonQuery();


                //@id_profesional, @fecha_init, @fecha_fin, @especialidad

        }
        }

        private bool CheckExistencia(int id) {


            using (SqlConnection sqlConnection = ManejadorConexiones.conectar())
            {
                string query = "SELECT Id_agenda FROM TRIGGER_EXPLOSION.Agenda WHERE Id_profesional="+id+" AND ( '" + FechaInit.Text + " " + horaInit.Text + "'<= Fecha_inicio AND '" + FechaFin.Text + " " + horaFin.Text + "'>= Fecha_fin OR '" + FechaInit.Text + " " + horaInit.Text + "'>= Fecha_inicio AND '" + FechaFin.Text + " " + horaFin.Text + "'<= Fecha_fin )";


                SqlCommand cmd = new SqlCommand(query, ManejadorConexiones.conectar()); //Agregar este Stored
                cmd.ExecuteNonQuery();

                using (var reader = cmd.ExecuteReader())
                {
                    reader.Read();

                    if (reader.HasRows) { 
                        return false; 
                         }else { return true; }
                }
            }


            
        }

}
}

   