using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;

namespace SepetUygulamaForm
{
    public partial class Form1 : Form
    {
        string connStr = "Server=localhost;Database=emira_sepet_db;User Id=emira;Password=emira123;TrustServerCertificate=True;";
        int seciliSepetId = -1;

        public Form1()
        {
            InitializeComponent();
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            SepetleriGetir();

            txtMusteriAdi.Text = "Müşteri Adı";
            txtMusteriAdi.ForeColor = Color.Gray;
            txtUrunAdi.Text = "Ürün Adı";
            txtUrunAdi.ForeColor = Color.Gray;
        }

        private void txtUrunAdi_Enter(object sender, EventArgs e)
        {
            if (txtUrunAdi.Text == "Ürün Adı")
            {
                txtUrunAdi.Text = "";
                txtUrunAdi.ForeColor = Color.Black;
            }
        }

        private void txtUrunAdi_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUrunAdi.Text))
            {
                txtUrunAdi.Text = "Ürün Adı";
                txtUrunAdi.ForeColor = Color.Gray;
            }
        }

        private void txtMusteriAdi_Enter(object sender, EventArgs e)
        {
            if (txtMusteriAdi.Text == "Müşteri Adı")
            {
                txtMusteriAdi.Text = "";
                txtMusteriAdi.ForeColor = Color.Black;
            }
        }

        private void txtMusteriAdi_Leave(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMusteriAdi.Text))
            {
                txtMusteriAdi.Text = "Müşteri Adı";
                txtMusteriAdi.ForeColor = Color.Gray;
            }
        }

        private void SepetleriGetir()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM sepet ORDER BY id DESC", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgvSepet.DataSource = dt; 
            }
        }

        private void UrunleriGetir(int sepetId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM sepet_urun WHERE sepet_id = @sid", conn);
                da.SelectCommand.Parameters.AddWithValue("@sid", sepetId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dgvUrunler.DataSource = dt; 

                double toplam = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    toplam += Convert.ToDouble(dr["adet"]) * Convert.ToDouble(dr["fiyat"]);
                }
                lblToplam.Text = "Sepet Toplamı: " + toplam.ToString("N2") + " ₺";
            }
        }

        private void btnSepetEkle_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtMusteriAdi.Text) || txtMusteriAdi.Text == "Müşteri Adı")
            {
                MessageBox.Show("Lütfen geçerli bir müşteri adı girin!", "Uyarı", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO sepet (musteri_adi, durum) VALUES (@ad, @durum)", conn);
                cmd.Parameters.AddWithValue("@ad", txtMusteriAdi.Text);
                cmd.Parameters.AddWithValue("@durum", cmbSepetDurum.Text);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            txtMusteriAdi.Text = "Müşteri Adı";
            txtMusteriAdi.ForeColor = Color.Gray;
            SepetleriGetir();
        }

        private void btnSepetSil_Click(object sender, EventArgs e)
        {
            if (seciliSepetId == -1)
            {
                MessageBox.Show("Lütfen silinecek sepeti tablodan seçin.");
                return;
            }

            DialogResult onay = MessageBox.Show("Bu sepeti silmek istediğinize emin misiniz?", "Onay", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (onay == DialogResult.Yes)
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM sepet WHERE id = @id", conn);
                    cmd.Parameters.AddWithValue("@id", seciliSepetId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                seciliSepetId = -1;
                SepetleriGetir();
                dgvUrunler.DataSource = null; 
                lblToplam.Text = "Sepet Toplamı: 0,00 ₺";
            }
        }

        private void btnUrunEkle_Click(object sender, EventArgs e)
        {
            if (seciliSepetId == -1)
            {
                MessageBox.Show("Önce listeden bir sepet seçmelisiniz!", "Uyarı", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO sepet_urun (sepet_id, urun_adi, adet, fiyat) VALUES (@sid, @ad, @adet, @fiyat)", conn);
                cmd.Parameters.AddWithValue("@sid", seciliSepetId);
                cmd.Parameters.AddWithValue("@ad", txtUrunAdi.Text);
                cmd.Parameters.AddWithValue("@adet", numAdet.Value); 
                cmd.Parameters.AddWithValue("@fiyat", Convert.ToDecimal(txtFiyat.Text.Replace(".", ","))); 
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            txtUrunAdi.Clear();
            txtFiyat.Clear();
            numAdet.Value = 1;
            UrunleriGetir(seciliSepetId);
        }

        private void dgvSepet_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                seciliSepetId = Convert.ToInt32(dgvSepet.Rows[e.RowIndex].Cells["id"].Value);
                UrunleriGetir(seciliSepetId);
            }
        }
    }
}