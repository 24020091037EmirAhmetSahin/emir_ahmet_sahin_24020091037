namespace SepetUygulamaForm
{
    partial class Form1
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer üretilen kod

        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.label1 = new System.Windows.Forms.Label();
            this.txtMusteriAdi = new System.Windows.Forms.TextBox();
            this.cmbSepetDurum = new System.Windows.Forms.ComboBox();
            this.btnSepetEkle = new System.Windows.Forms.Button();
            this.btnSepetSil = new System.Windows.Forms.Button();
            this.dgvSepet = new System.Windows.Forms.DataGridView();
            this.label2 = new System.Windows.Forms.Label();
            this.txtUrunAdi = new System.Windows.Forms.TextBox();
            this.numAdet = new System.Windows.Forms.NumericUpDown();
            this.btnUrunEkle = new System.Windows.Forms.Button();
            this.dgvUrunler = new System.Windows.Forms.DataGridView();
            this.lblToplam = new System.Windows.Forms.Label();
            this.txtFiyat = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSepet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numAdet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvUrunler)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 16.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(23)))), ((int)(((byte)(42)))));
            this.label1.Location = new System.Drawing.Point(25, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(350, 38);
            this.label1.TabIndex = 0;
            this.label1.Text = "Emira Sepet Yönetimi | C#";
            // 
            // txtMusteriAdi
            // 
            this.txtMusteriAdi.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.txtMusteriAdi.Location = new System.Drawing.Point(32, 75);
            this.txtMusteriAdi.Name = "txtMusteriAdi";
            this.txtMusteriAdi.Size = new System.Drawing.Size(200, 31);
            this.txtMusteriAdi.TabIndex = 1;
            this.txtMusteriAdi.Text = "Müşteri Adı";
            this.txtMusteriAdi.Enter += new System.EventHandler(this.txtMusteriAdi_Enter);
            this.txtMusteriAdi.Leave += new System.EventHandler(this.txtMusteriAdi_Leave);
            // 
            // cmbSepetDurum
            // 
            this.cmbSepetDurum.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbSepetDurum.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.cmbSepetDurum.FormattingEnabled = true;
            this.cmbSepetDurum.Items.AddRange(new object[] {
            "aktif",
            "tamamlandi",
            "iptal"});
            this.cmbSepetDurum.Location = new System.Drawing.Point(250, 75);
            this.cmbSepetDurum.Name = "cmbSepetDurum";
            this.cmbSepetDurum.Size = new System.Drawing.Size(150, 33);
            this.cmbSepetDurum.TabIndex = 2;
            // 
            // btnSepetEkle
            // 
            this.btnSepetEkle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(79)))), ((int)(((byte)(70)))), ((int)(((byte)(229)))));
            this.btnSepetEkle.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnSepetEkle.FlatAppearance.BorderSize = 0;
            this.btnSepetEkle.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSepetEkle.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.btnSepetEkle.ForeColor = System.Drawing.Color.White;
            this.btnSepetEkle.Location = new System.Drawing.Point(420, 72);
            this.btnSepetEkle.Name = "btnSepetEkle";
            this.btnSepetEkle.Size = new System.Drawing.Size(160, 38);
            this.btnSepetEkle.TabIndex = 3;
            this.btnSepetEkle.Text = "➕ Sepet Oluştur";
            this.btnSepetEkle.UseVisualStyleBackColor = false;
            this.btnSepetEkle.Click += new System.EventHandler(this.btnSepetEkle_Click);
            // 
            // btnSepetSil
            // 
            this.btnSepetSil.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(220)))), ((int)(((byte)(38)))), ((int)(((byte)(38)))));
            this.btnSepetSil.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnSepetSil.FlatAppearance.BorderSize = 0;
            this.btnSepetSil.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSepetSil.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.btnSepetSil.ForeColor = System.Drawing.Color.White;
            this.btnSepetSil.Location = new System.Drawing.Point(595, 72);
            this.btnSepetSil.Name = "btnSepetSil";
            this.btnSepetSil.Size = new System.Drawing.Size(160, 38);
            this.btnSepetSil.TabIndex = 4;
            this.btnSepetSil.Text = "🗑️ Seçiliyi Sil";
            this.btnSepetSil.UseVisualStyleBackColor = false;
            this.btnSepetSil.Click += new System.EventHandler(this.btnSepetSil_Click);
            // 
            // dgvSepet
            // 
            this.dgvSepet.AllowUserToAddRows = false;
            this.dgvSepet.AllowUserToDeleteRows = false;
            this.dgvSepet.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvSepet.BackgroundColor = System.Drawing.Color.White;
            this.dgvSepet.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(245)))), ((int)(((byte)(249)))));
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(30)))), ((int)(((byte)(41)))), ((int)(((byte)(59)))));
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvSepet.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvSepet.ColumnHeadersHeight = 35;
            this.dgvSepet.Location = new System.Drawing.Point(32, 125);
            this.dgvSepet.Name = "dgvSepet";
            this.dgvSepet.ReadOnly = true;
            this.dgvSepet.RowHeadersVisible = false;
            this.dgvSepet.RowHeadersWidth = 51;
            this.dgvSepet.RowTemplate.DefaultCellStyle.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.dgvSepet.RowTemplate.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(79)))), ((int)(((byte)(70)))), ((int)(((byte)(229)))));
            this.dgvSepet.RowTemplate.Height = 30;
            this.dgvSepet.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvSepet.Size = new System.Drawing.Size(775, 200);
            this.dgvSepet.TabIndex = 5;
            this.dgvSepet.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSepet_CellClick);
            this.dgvSepet.AllowUserToAddRows = false;
            this.dgvSepet.AllowUserToDeleteRows = false;
            this.dgvSepet.AllowUserToResizeColumns = false;
            this.dgvSepet.AllowUserToResizeRows = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.label2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(15)))), ((int)(((byte)(23)))), ((int)(((byte)(42)))));
            this.label2.Location = new System.Drawing.Point(26, 345);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(306, 31);
            this.label2.TabIndex = 6;
            this.label2.Text = "📦 Ürün Ekle ve Sepet Detayı";
            // 
            // txtUrunAdi
            // 
            this.txtUrunAdi.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.txtUrunAdi.Location = new System.Drawing.Point(32, 395);
            this.txtUrunAdi.Name = "txtUrunAdi";
            this.txtUrunAdi.Size = new System.Drawing.Size(180, 31);
            this.txtUrunAdi.TabIndex = 7;
            this.txtUrunAdi.Text = "Ürün Adı";
            this.txtUrunAdi.Enter += new System.EventHandler(this.txtUrunAdi_Enter);
            this.txtUrunAdi.Leave += new System.EventHandler(this.txtUrunAdi_Leave);
            // 
            // numAdet
            // 
            this.numAdet.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.numAdet.Location = new System.Drawing.Point(230, 395);
            this.numAdet.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numAdet.Name = "numAdet";
            this.numAdet.Size = new System.Drawing.Size(80, 31);
            this.numAdet.TabIndex = 8;
            this.numAdet.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // txtFiyat
            // 
            this.txtFiyat.Font = new System.Drawing.Font("Segoe UI", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.txtFiyat.Location = new System.Drawing.Point(330, 395);
            this.txtFiyat.Name = "txtFiyat";
            this.txtFiyat.Size = new System.Drawing.Size(120, 31);
            this.txtFiyat.TabIndex = 12;
            this.txtFiyat.Text = "0,00";
            // 
            // btnUrunEkle
            // 
            this.btnUrunEkle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(16)))), ((int)(((byte)(185)))), ((int)(((byte)(129)))));
            this.btnUrunEkle.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnUrunEkle.FlatAppearance.BorderSize = 0;
            this.btnUrunEkle.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnUrunEkle.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.btnUrunEkle.ForeColor = System.Drawing.Color.White;
            this.btnUrunEkle.Location = new System.Drawing.Point(470, 392);
            this.btnUrunEkle.Name = "btnUrunEkle";
            this.btnUrunEkle.Size = new System.Drawing.Size(180, 38);
            this.btnUrunEkle.TabIndex = 9;
            this.btnUrunEkle.Text = "➕ Ürünü Sepete Ekle";
            this.btnUrunEkle.UseVisualStyleBackColor = false;
            this.btnUrunEkle.Click += new System.EventHandler(this.btnUrunEkle_Click);
            // 
            // dgvUrunler
            // 
            this.dgvUrunler.AllowUserToAddRows = false;
            this.dgvUrunler.AllowUserToDeleteRows = false;
            this.dgvUrunler.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvUrunler.BackgroundColor = System.Drawing.Color.White;
            this.dgvUrunler.BorderStyle = System.Windows.Forms.BorderStyle.None;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(241)))), ((int)(((byte)(245)))), ((int)(((byte)(249)))));
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(30)))), ((int)(((byte)(41)))), ((int)(((byte)(59)))));
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvUrunler.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgvUrunler.ColumnHeadersHeight = 35;
            this.dgvUrunler.Location = new System.Drawing.Point(32, 445);
            this.dgvUrunler.Name = "dgvUrunler";
            this.dgvUrunler.ReadOnly = true;
            this.dgvUrunler.RowHeadersVisible = false;
            this.dgvUrunler.RowHeadersWidth = 51;
            this.dgvUrunler.RowTemplate.DefaultCellStyle.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.dgvUrunler.RowTemplate.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(16)))), ((int)(((byte)(185)))), ((int)(((byte)(129)))));
            this.dgvUrunler.RowTemplate.Height = 30;
            this.dgvUrunler.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvUrunler.Size = new System.Drawing.Size(775, 170);
            this.dgvUrunler.TabIndex = 10;
            this.dgvUrunler.AllowUserToAddRows = false;
            this.dgvUrunler.AllowUserToDeleteRows = false;
            this.dgvUrunler.AllowUserToResizeColumns = false;
            this.dgvUrunler.AllowUserToResizeRows = false;
            // 
            // lblToplam
            // 
            this.lblToplam.Font = new System.Drawing.Font("Segoe UI", 16.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lblToplam.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(16)))), ((int)(((byte)(185)))), ((int)(((byte)(129)))));
            this.lblToplam.Location = new System.Drawing.Point(32, 630);
            this.lblToplam.Name = "lblToplam";
            
            this.lblToplam.Size = new System.Drawing.Size(775, 40);
            this.lblToplam.TabIndex = 11;
            this.lblToplam.Text = "Sepet Toplamı: 0,00 ₺";
            this.lblToplam.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            //
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(248)))), ((int)(((byte)(250)))), ((int)(((byte)(252)))));
            this.ClientSize = new System.Drawing.Size(850, 700);
            this.Controls.Add(this.txtFiyat);
            this.Controls.Add(this.lblToplam);
            this.Controls.Add(this.dgvUrunler);
            this.Controls.Add(this.btnUrunEkle);
            this.Controls.Add(this.numAdet);
            this.Controls.Add(this.txtUrunAdi);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgvSepet);
            this.Controls.Add(this.btnSepetSil);
            this.Controls.Add(this.btnSepetEkle);
            this.Controls.Add(this.cmbSepetDurum);
            this.Controls.Add(this.txtMusteriAdi);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Emira Sepet Yönetimi | C#";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvSepet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numAdet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvUrunler)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtMusteriAdi;
        private System.Windows.Forms.ComboBox cmbSepetDurum;
        private System.Windows.Forms.Button btnSepetEkle;
        private System.Windows.Forms.Button btnSepetSil;
        private System.Windows.Forms.DataGridView dgvSepet;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtUrunAdi;
        private System.Windows.Forms.NumericUpDown numAdet;
        private System.Windows.Forms.Button btnUrunEkle;
        private System.Windows.Forms.DataGridView dgvUrunler;
        private System.Windows.Forms.Label lblToplam;
        private System.Windows.Forms.TextBox txtFiyat;
    }
}