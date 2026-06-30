using System;
using System.Data;
using System.Data.SqlClient;

namespace YemekTarif
{
    public partial class Default : System.Web.UI.Page
    {
        string baglantiAdresi = "Data Source=.;Initial Catalog=yemek_tarif_db;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TarifleriGetir();
            }
        }

        private void TarifleriGetir()
        {
            using (SqlConnection baglanti = new SqlConnection(baglantiAdresi))
            {
                string sorgu = "SELECT id, baslik, detay, fotograf_url FROM Tarifler ORDER BY olusturulma_tarihi DESC";
                SqlCommand komut = new SqlCommand(sorgu, baglanti);
                SqlDataAdapter da = new SqlDataAdapter(komut);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptTarifler.DataSource = dt;
                rptTarifler.DataBind();
            }
        }

        protected string KisaDetayGetir(string detay)
        {
            if (string.IsNullOrEmpty(detay)) return "";
            return detay.Length > 100 ? detay.Substring(0, 100) + "..." : detay;
        }
    }
}