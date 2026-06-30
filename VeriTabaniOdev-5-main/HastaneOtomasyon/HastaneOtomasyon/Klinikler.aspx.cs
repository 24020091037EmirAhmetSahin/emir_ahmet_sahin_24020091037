using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HastaneOtomasyon
{
    public partial class Klinikler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa ilk defa yükleniyorsa verileri getir (Butona vs basılmadıysa)
            if (!IsPostBack)
            {
                KlinikleriGetir();
            }
        }

        private void KlinikleriGetir()
        {
            // Web.config içine yazdığımız bağlantı cümlesini çekiyoruz
            string connString = ConfigurationManager.ConnectionStrings["HastaneDBConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Tüm klinikleri çekmek için basit select sorgusu
                string query = "SELECT ID, KlinikAdi, KatNo, Uzmanlik FROM Clinics ORDER BY KlinikAdi ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Gelen veriyi ön taraftaki Repeater'a bağlıyoruz
                    rptKlinikler.DataSource = reader;
                    rptKlinikler.DataBind();
                }
            }
        }
    }
}