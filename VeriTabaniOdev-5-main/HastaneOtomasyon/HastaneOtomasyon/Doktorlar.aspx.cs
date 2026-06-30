using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HastaneOtomasyon
{
    public partial class Doktorlar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // URL'den clinicId parametresi gelmiş mi kontrol et
                if (Request.QueryString["clinicId"] != null)
                {
                    int clinicId;
                    // Gelen parametrenin sayı olup olmadığını kontrol ediyoruz (güvenlik için)
                    if (int.TryParse(Request.QueryString["clinicId"], out clinicId))
                    {
                        DoktorlariGetir(clinicId);
                    }
                }
                else
                {
                    // Parametre yoksa veya birisi sayfaya direkt girmeye çalıştıysa geri yolla
                    Response.Redirect("Klinikler.aspx");
                }
            }
        }

        private void DoktorlariGetir(int clinicId)
        {
            string connString = ConfigurationManager.ConnectionStrings["HastaneDBConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // HOCANIN İSTEDİĞİ PARAMETRELİ SORGU YAPISI: @KlinikID
                string query = "SELECT ID, AdSoyad, Unvan FROM Doctors WHERE KlinikID = @KlinikID ORDER BY AdSoyad ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Parametreyi SQL'e güvenli bir şekilde ekliyoruz
                    cmd.Parameters.AddWithValue("@KlinikID", clinicId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    rptDoktorlar.DataSource = reader;
                    rptDoktorlar.DataBind();
                }
            }
        }
    }
}