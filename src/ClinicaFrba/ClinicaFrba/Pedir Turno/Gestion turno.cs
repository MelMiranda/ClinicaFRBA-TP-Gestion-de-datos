using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ClinicaFrba.Pedir_Turno
{
    public partial class Gestion_turno : Form
    {

        List<Especialidad> especialidades = new List<Especialidad>();

        public Gestion_turno()
        {
            InitializeComponent();
            cargarEspecialidades();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }



        private void cargarEspecialidades()
        {
            especialidades =  Interfaz.Interfaz.getEspecialidades();

            //foreach (Especialidad especialidad in especialidades)
            //{
              //  comboBox_especialidad.Items.Add(especialidad.nombre);
           //}


            comboBox_especialidad.DisplayMember = "nombre";
            comboBox_especialidad.ValueMember = "id";
            comboBox_especialidad.DataSource = especialidades;
            comboBox_especialidad.SelectedIndex = 0;

            comboBox_especialidad.SelectedIndexChanged += new System.EventHandler(EspecialidadesSelectedIndexChanged);

      

        }


        //Funcion llamada cada vez que se selecciona una especialidad
        private void EspecialidadesSelectedIndexChanged(object sender, System.EventArgs e)
        {
            Especialidad selected = (Especialidad)comboBox_especialidad.SelectedItem;
            cargarProfesionalesPorEspecialidad(selected.id);

        }

        private void cargarProfesionalesPorEspecialidad(string especialidad_id)
        {
            List<Profesional> list = Interfaz.Interfaz.getProfesionalesPorEspecialidad(especialidad_id);
            comboBox__profesional.DisplayMember = "apellido";
            comboBox__profesional.ValueMember = "id";
            comboBox__profesional.DataSource = list;
            comboBox__profesional.SelectedIndex = 0;

        }
    }
}
