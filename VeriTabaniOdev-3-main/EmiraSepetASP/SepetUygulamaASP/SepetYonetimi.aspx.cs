using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SepetUygulamaASP
{
    public partial class SepetYonetimi : System.Web.UI.Page
    {
        string connStr = "Server=localhost;Database=emira_sepet_db;User Id=emira;Password=emira123;TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SepetleriGetir();
            }
        }

        void SepetleriGetir()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM sepet ORDER BY id DESC", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSepetler.DataSource = dt;
                gvSepetler.DataBind();
            }
        }

        protected void btnSepetEkle_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtMusteriAdi.Text)) return;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO sepet (musteri_adi, durum) VALUES (@ad, @durum)", conn);
                cmd.Parameters.AddWithValue("@ad", txtMusteriAdi.Text);
                cmd.Parameters.AddWithValue("@durum", ddlDurum.SelectedValue);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            txtMusteriAdi.Text = "";
            SepetleriGetir();
        }

        protected void gvSepetler_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = gvSepetler.SelectedDataKey.Value.ToString();
            lblSeciliSepetId.Text = id;
            pnlUrunler.Visible = true;
            UrunleriGetir(id);
        }

        void UrunleriGetir(string sepetId)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM sepet_urun WHERE sepet_id = @id", conn);
                cmd.Parameters.AddWithValue("@id", sepetId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUrunler.DataSource = dt; 
                gvUrunler.DataBind();

                double toplam = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    toplam += Convert.ToDouble(dr["adet"]) * Convert.ToDouble(dr["fiyat"]);
                }
                lblGenelToplam.Text = "Genel Toplam: " + toplam.ToString("N2") + " ₺";
            }
        }

        protected void btnUrunEkle_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO sepet_urun (sepet_id, urun_adi, adet, fiyat) VALUES (@sid, @ad, @adet, @fiyat)", conn);
                cmd.Parameters.AddWithValue("@sid", lblSeciliSepetId.Text);
                cmd.Parameters.AddWithValue("@ad", txtUrunAdi.Text);
                cmd.Parameters.AddWithValue("@adet", txtAdet.Text);
                cmd.Parameters.AddWithValue("@fiyat", txtFiyat.Text.Replace(",", ".")); 
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            txtUrunAdi.Text = ""; txtFiyat.Text = "";
            UrunleriGetir(lblSeciliSepetId.Text);
        }

        protected void gvSepetler_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvSepetler.DataKeys[e.RowIndex].Value.ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM sepet WHERE id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            pnlUrunler.Visible = false;
            SepetleriGetir();
        }

        protected void gvUrunler_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = gvUrunler.DataKeys[e.RowIndex].Value.ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM sepet_urun WHERE id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            UrunleriGetir(lblSeciliSepetId.Text);
        }
    }

}