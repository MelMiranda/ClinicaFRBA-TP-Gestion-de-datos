using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicaFrba
{
    class Profesional 
    {
        private String matricula;
        private List<Especialidad> especialidades;
        private Agenda agenda;
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string id { get; set; }


        public Profesional(string id, string nombre, string apellido)
        {
            this.id = id;
            this.nombre = nombre;
            this.apellido = apellido;

        }
    

    }


}
