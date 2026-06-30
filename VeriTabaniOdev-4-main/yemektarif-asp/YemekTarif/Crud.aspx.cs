using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace YemekTarif
{
    public partial class Crud : System.Web.UI.Page
    {
        string baglantiAdresi = "Data Source=.;Initial Catalog=yemek_tarif_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TabloyuDoldur();
            }
        }

        private void TabloyuDoldur()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiAdresi))
            {
                string sorgu = "SELECT * FROM Tarifler ORDER BY id DESC";
                SqlCommand komut = new SqlCommand(sorgu, baglanti);
                SqlDataAdapter da = new SqlDataAdapter(komut);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptTarifler.DataSource = dt;
                rptTarifler.DataBind();
            }
        }

        protected void btnEkle_Click(object sender, EventArgs e)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiAdresi))
            {
                string sorgu = "INSERT INTO Tarifler (baslik, detay, fotograf_url) VALUES (@baslik, @detay, @foto)";
                SqlCommand cmd = new SqlCommand(sorgu, baglanti);
                cmd.Parameters.AddWithValue("@baslik", txtBaslik.Text);
                cmd.Parameters.AddWithValue("@detay", txtDetay.Text);
                cmd.Parameters.AddWithValue("@foto", string.IsNullOrWhiteSpace(txtFotoUrl.Text) ? (object)DBNull.Value : txtFotoUrl.Text);

                baglanti.Open();
                cmd.ExecuteNonQuery();
            }

            txtBaslik.Text = "";
            txtDetay.Text = "";
            txtFotoUrl.Text = "";
            TabloyuDoldur(); // Tabloyu yenile
        }

        protected void btnGuncelle_Click(object sender, EventArgs e)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiAdresi))
            {
                string sorgu = "UPDATE Tarifler SET baslik = @baslik, detay = @detay, fotograf_url = @foto WHERE id = @id";
                SqlCommand cmd = new SqlCommand(sorgu, baglanti);
                cmd.Parameters.AddWithValue("@id", hdnModalId.Value);
                cmd.Parameters.AddWithValue("@baslik", txtModalBaslik.Text);
                cmd.Parameters.AddWithValue("@detay", txtModalDetay.Text);
                cmd.Parameters.AddWithValue("@foto", string.IsNullOrWhiteSpace(txtModalFoto.Text) ? (object)DBNull.Value : txtModalFoto.Text);

                baglanti.Open();
                cmd.ExecuteNonQuery();
            }

            TabloyuDoldur(); 
        }

        
        protected void rptTarifler_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Sil")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection baglanti = new SqlConnection(baglantiAdresi))
                {
                    string sorgu = "DELETE FROM Tarifler WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(sorgu, baglanti);
                    cmd.Parameters.AddWithValue("@id", id);

                    baglanti.Open();
                    cmd.ExecuteNonQuery();
                }

                TabloyuDoldur(); 
            }
        }
    }
}