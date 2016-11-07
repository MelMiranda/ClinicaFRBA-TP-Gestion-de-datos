namespace ClinicaFrba.Registro_Llegada
{
    partial class RegistroDeLlegada
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.Aceptar = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.Documento = new System.Windows.Forms.TextBox();
            this.Hora = new System.Windows.Forms.Label();
            this.Nombre = new System.Windows.Forms.TextBox();
            this.FechaYHora = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.Profesional = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.Especialidad = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(36, 71);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(62, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Documento";
            // 
            // Aceptar
            // 
            this.Aceptar.Location = new System.Drawing.Point(328, 160);
            this.Aceptar.Name = "Aceptar";
            this.Aceptar.Size = new System.Drawing.Size(75, 23);
            this.Aceptar.TabIndex = 1;
            this.Aceptar.Text = "Aceptar";
            this.Aceptar.UseVisualStyleBackColor = true;
            this.Aceptar.Click += new System.EventHandler(this.Aceptar_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(36, 107);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(44, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Nombre";
            // 
            // Documento
            // 
            this.Documento.Location = new System.Drawing.Point(123, 71);
            this.Documento.Name = "Documento";
            this.Documento.Size = new System.Drawing.Size(100, 20);
            this.Documento.TabIndex = 3;
            this.Documento.TextChanged += new System.EventHandler(this.Documento_TextChanged);
            // 
            // Hora
            // 
            this.Hora.AutoSize = true;
            this.Hora.Location = new System.Drawing.Point(36, 217);
            this.Hora.Name = "Hora";
            this.Hora.Size = new System.Drawing.Size(71, 13);
            this.Hora.TabIndex = 5;
            this.Hora.Text = "Fecha y Hora";
            // 
            // Nombre
            // 
            this.Nombre.Location = new System.Drawing.Point(123, 116);
            this.Nombre.Name = "Nombre";
            this.Nombre.Size = new System.Drawing.Size(100, 20);
            this.Nombre.TabIndex = 4;
            this.Nombre.TextChanged += new System.EventHandler(this.Nombre_TextChanged);
            // 
            // FechaYHora
            // 
            this.FechaYHora.Location = new System.Drawing.Point(123, 210);
            this.FechaYHora.Name = "FechaYHora";
            this.FechaYHora.Size = new System.Drawing.Size(100, 20);
            this.FechaYHora.TabIndex = 6;
            this.FechaYHora.TextChanged += new System.EventHandler(this.FechaYHora_TextChanged);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.SystemColors.ButtonFace;
            this.label3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.label3.Location = new System.Drawing.Point(181, 21);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(125, 15);
            this.label3.TabIndex = 7;
            this.label3.Text = "Ingreso llegada paciente";
            // 
            // Profesional
            // 
            this.Profesional.Location = new System.Drawing.Point(123, 163);
            this.Profesional.Name = "Profesional";
            this.Profesional.Size = new System.Drawing.Size(100, 20);
            this.Profesional.TabIndex = 8;
            this.Profesional.TextChanged += new System.EventHandler(this.Profesional_TextChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(36, 170);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(59, 13);
            this.label4.TabIndex = 9;
            this.label4.Text = "Profesional";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(36, 123);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(59, 13);
            this.label5.TabIndex = 10;
            this.label5.Text = "Profesional";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(36, 157);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(44, 13);
            this.label6.TabIndex = 11;
            this.label6.Text = "Apellido";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(286, 71);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(67, 13);
            this.label7.TabIndex = 12;
            this.label7.Text = "Especialidad";
            // 
            // Especialidad
            // 
            this.Especialidad.Location = new System.Drawing.Point(365, 68);
            this.Especialidad.Name = "Especialidad";
            this.Especialidad.Size = new System.Drawing.Size(100, 20);
            this.Especialidad.TabIndex = 13;
            this.Especialidad.TextChanged += new System.EventHandler(this.Especialidad_TextChanged);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(286, 84);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(53, 13);
            this.label8.TabIndex = 14;
            this.label8.Text = "(opcional)";
            // 
            // RegistroDeLlegada
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(497, 310);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.Especialidad);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.Profesional);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.FechaYHora);
            this.Controls.Add(this.Hora);
            this.Controls.Add(this.Nombre);
            this.Controls.Add(this.Documento);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.Aceptar);
            this.Controls.Add(this.label1);
            this.Name = "RegistroDeLlegada";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.RegistroDeLlegada_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button Aceptar;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox Documento;
        private System.Windows.Forms.Label Hora;
        private System.Windows.Forms.TextBox Nombre;
        private System.Windows.Forms.TextBox FechaYHora;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox Profesional;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox Especialidad;
        private System.Windows.Forms.Label label8;
    }
}