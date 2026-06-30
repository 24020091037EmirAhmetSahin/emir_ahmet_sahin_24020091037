using System;
using System.Data.SqlClient;

namespace YemekTarif
{
    public partial class Detay : System.Web.UI.Page
    {
        string baglantiAdresi = "Data Source=.;Initial Catalog=yemek_tarif_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    TarifGetir(Request.QueryString["id"]);
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void TarifGetir(string id)
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiAdresi))
            {
                string sorgu = "SELECT baslik, detay, fotograf_url FROM Tarifler WHERE id = @id";
                SqlCommand cmd = new SqlCommand(sorgu, baglanti);
                cmd.Parameters.AddWithValue("@id", id);

                baglanti.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    litBaslik.Text = dr["baslik"].ToString();
                    litDetay.Text = dr["detay"].ToString();

                    string fotoUrl = dr["fotograf_url"].ToString();
                    if (string.IsNullOrWhiteSpace(fotoUrl))
                    {
                        imgFoto.ImageUrl = "https://images.unsplash.com/photo-1495521821757-a1efb6729352?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80";
                    }
                    else
                    {
                        imgFoto.ImageUrl = fotoUrl;
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }
    }
}