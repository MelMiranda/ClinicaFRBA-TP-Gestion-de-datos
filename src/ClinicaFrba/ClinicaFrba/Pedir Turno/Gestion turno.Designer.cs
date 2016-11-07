namespace ClinicaFrba.Pedir_Turno
{
    partial class Gestion_turno
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
            this.label2 = new System.Windows.Forms.Label();
            this.comboBox_especialidad = new System.Windows.Forms.ComboBox();
            this.comboBox__profesional = new System.Windows.Forms.ComboBox();
            this.grilla_turnosDisp = new System.Windows.Forms.DataGridView();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.grilla_turnosDisp)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(49, 41);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(67, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Especialidad";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(51, 80);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(59, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Profesional";
            // 
            // comboBox_especialidad
            // 
            this.comboBox_especialidad.FormattingEnabled = true;
            this.comboBox_especialidad.Location = new System.Drawing.Point(159, 41);
            this.comboBox_especialidad.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.comboBox_especialidad.Name = "comboBox_especialidad";
            this.comboBox_especialidad.Size = new System.Drawing.Size(201, 21);
            this.comboBox_especialidad.TabIndex = 2;
            // 
            // comboBox__profesional
            // 
            this.comboBox__profesional.FormattingEnabled = true;
            this.comboBox__profesional.Location = new System.Drawing.Point(159, 80);
            this.comboBox__profesional.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.comboBox__profesional.Name = "comboBox__profesional";
            this.comboBox__profesional.Size = new System.Drawing.Size(201, 21);
            this.comboBox__profesional.TabIndex = 3;
            // 
            // grilla_turnosDisp
            // 
            this.grilla_turnosDisp.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grilla_turnosDisp.Location = new System.Drawing.Point(36, 142);
            this.grilla_turnosDisp.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.grilla_turnosDisp.Name = "grilla_turnosDisp";
            this.grilla_turnosDisp.RowTemplate.Height = 24;
            this.grilla_turnosDisp.Size = new System.Drawing.Size(324, 193);
            this.grilla_turnosDisp.TabIndex = 4;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(110, 360);
            this.button1.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(106, 26);
            this.button1.TabIndex = 5;
            this.button1.Text = "Confirmar turno";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(235, 360);
            this.button2.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(69, 26);
            this.button2.TabIndex = 6;
            this.button2.Text = "Cancelar";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // Gestion_turno
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(456, 404);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.grilla_turnosDisp);
            this.Controls.Add(this.comboBox__profesional);
            this.Controls.Add(this.comboBox_especialidad);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "Gestion_turno";
            this.Text = "Pedir turno";
            ((System.ComponentModel.ISupportInitialize)(this.grilla_turnosDisp)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox comboBox_especialidad;
        private System.Windows.Forms.ComboBox comboBox__profesional;
        private System.Windows.Forms.DataGridView grilla_turnosDisp;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
    }
}