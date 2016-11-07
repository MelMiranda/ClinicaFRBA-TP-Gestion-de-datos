﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ClinicaFrba.Estadisticas
{
    public partial class ProfesionalConsultado : Form
    {
        public ProfesionalConsultado()
        {
            InitializeComponent();
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void cboSemestre_SelectedIndexChanged(object sender, EventArgs e)
        {
            Dictionary<int, string> meses = new Dictionary<int, string>();
            if (cboSemestre.Text == "1")
            {

                meses.Add(1, "Enero");
                meses.Add(2, "Febrero");
                meses.Add(3, "Marzo");
                meses.Add(4, "Abril");
                meses.Add(5, "Mayo");
                meses.Add(6, "Junio");

            }
            else
            {
                meses.Add(7, "Julio");
                meses.Add(8, "Agosto");
                meses.Add(9, "Septiembre");
                meses.Add(10, "Octubre");
                meses.Add(11, "Noviembre");
                meses.Add(12, "Diciembre");
            }
            meses.Add(0, "Todos");
            cboMes.DataSource = new BindingSource(meses, null);
            cboMes.DisplayMember = "Value";
            cboMes.ValueMember = "Key";
        }

        private void btn_buscar_Click(object sender, EventArgs e)
        {
            if (cboAño.Text != "" && cboEspecialidad.Text != "" && cboPlan.Text != "" && cboMes.Text != "")
            {
                
                SqlCommand cargar = new SqlCommand("TRIGGER_EXPLOSION.ProfesionalesConsultados", ManejadorConexiones.conectar());
                cargar.CommandType = CommandType.StoredProcedure;
                cargar.Parameters.Add("@Plan", SqlDbType.Decimal).Value = cboPlan.SelectedValue;
                cargar.Parameters.Add("@Especialidad", SqlDbType.Decimal).Value = cboEspecialidad.SelectedValue;
                cargar.Parameters.Add("@Semestre", SqlDbType.Int).Value = int.Parse(cboSemestre.Text);
                cargar.Parameters.Add("@Mes", SqlDbType.Int).Value = cboMes.SelectedValue;
                cargar.Parameters.Add("@Año", SqlDbType.VarChar).Value = cboAño.Text;
                SqlDataAdapter adapter = new SqlDataAdapter(cargar);
                DataTable table = new DataTable();
                adapter.Fill(table);
                dataGridView1.DataSource = table;
                ManejadorConexiones.desconectar();
                
            }
            else
            {
                MessageBox.Show("Complete los criterios de busqueda");

            }
        }

        private void ProfesionalConsultado_Load(object sender, EventArgs e)
        {
            SqlCommand cargar = new SqlCommand("SELECT Descripcion, Id_plan FROM TRIGGER_EXPLOSION.PlanMedico UNION SELECT 'Todos', 0", ManejadorConexiones.conectar());
            SqlDataAdapter adapter = new SqlDataAdapter(cargar);
            DataTable table = new DataTable();
            adapter.Fill(table);
            cboPlan.DataSource = table;
            cboPlan.DisplayMember = "Descripcion";
            cboPlan.ValueMember = "Id_plan";


            cargar = new SqlCommand("SELECT Descripcion, Id_especialidad FROM TRIGGER_EXPLOSION.Especialidad UNION SELECT 'Todas', 0", ManejadorConexiones.conectar());
            adapter = new SqlDataAdapter(cargar);
            table = new DataTable();
            adapter.Fill(table);
            cboEspecialidad.DataSource = table;
            cboEspecialidad.DisplayMember = "Descripcion";
            cboEspecialidad.ValueMember = "Id_especialidad";
        }
    }
}
