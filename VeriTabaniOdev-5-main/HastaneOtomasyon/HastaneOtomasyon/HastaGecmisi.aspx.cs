using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HastaneOtomasyon
{
    public partial class HastaGecmisi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Sayfa ilk yüklendiğinde yapılacak özel bir işlem yok.
        }

        protected void btnAra_Click(object sender, EventArgs e)
        {
            string tcKimlik = txtTCArama.Text.Trim();

            // TC Kimlik boş mu kontrolü
            if (string.IsNullOrEmpty(tcKimlik))
            {
                lblMesaj.Text = "Lütfen bir TC Kimlik Numarası girin!";
                return;
            }

            GeçmişiSorgula(tcKimlik);
        }

        private void GeçmişiSorgula(string tc)
        {
            string connString = ConfigurationManager.ConnectionStrings["HastaneDBConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Hastalar, Randevular, Doktorlar, Klinikler ve Reçeteler tablolarını bağlıyoruz
                string query = @"
                    SELECT 
                        p.AdSoyad AS HastaAdi,
                        a.RandevuTarihi, 
                        c.KlinikAdi,
                        d.AdSoyad AS DoktorAdi, 
                        a.Sikayet, 
                        pr.IlacListesi 
                    FROM Patients p
                    INNER JOIN Appointments a ON p.ID = a.HastaID
                    INNER JOIN Doctors d ON a.DoktorID = d.ID
                    INNER JOIN Clinics c ON d.KlinikID = c.ID
                    LEFT JOIN Prescriptions pr ON a.ID = pr.RandevuID
                    WHERE p.TCKimlik = @TCKimlik 
                    ORDER BY a.RandevuTarihi DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TCKimlik", tc);

                    // GridView'ı doldurmak için SqlDataAdapter ve DataTable kullanıyoruz
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            // Hasta adını ilk satırdan alıp ekrana yazdırıyoruz
                            lblHastaBilgi.Text = "Kayıtlar Listeleniyor: " + dt.Rows[0]["HastaAdi"].ToString();

                            // Veriyi GridView'a bağla
                            gvGecmis.DataSource = dt;
                            gvGecmis.DataBind();

                            lblMesaj.Text = ""; // Hata mesajını temizle
                        }
                        else
                        {
                            // Eğer kayıt yoksa tabloyu boşalt ve uyarı ver
                            gvGecmis.DataSource = null;
                            gvGecmis.DataBind();
                            lblHastaBilgi.Text = "";
                            lblMesaj.Text = "Bu TC Kimlik numarasına ait randevu veya hasta kaydı bulunamadı.";
                        }
                    }
                }
            }
        }
    }
}