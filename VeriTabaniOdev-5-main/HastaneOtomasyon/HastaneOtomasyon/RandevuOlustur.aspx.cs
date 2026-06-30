using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HastaneOtomasyon
{
    public partial class RandevuOlustur : System.Web.UI.Page
    {
        // Sayfa seviyesinde doktor ID'sini tutmak için
        int seciliDoktorID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["docId"] != null)
            {
                int.TryParse(Request.QueryString["docId"], out seciliDoktorID);
            }
            else
            {
                Response.Redirect("Klinikler.aspx");
            }
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["HastaneDBConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // VERİ TUTARLILIĞI İÇİN TRANSACTION BAŞLATIYORUZ
                // Ya tüm işlemler başarılı olur, ya da hepsi geri alınır (Rollback)
                SqlTransaction islem = conn.BeginTransaction();

                try
                {
                    int hastaId = 0;

                    // 1. ADIM: HASTA SİSTEMDE VAR MI KONTROL ET
                    string checkQuery = "SELECT ID FROM Patients WHERE TCKimlik = @TC";
                    using (SqlCommand cmdCheck = new SqlCommand(checkQuery, conn, islem))
                    {
                        cmdCheck.Parameters.AddWithValue("@TC", txtTC.Text.Trim());
                        object result = cmdCheck.ExecuteScalar();

                        if (result != null)
                        {
                            // Hasta varsa ID'sini al
                            hastaId = Convert.ToInt32(result);
                        }
                        else
                        {
                            // 2. ADIM: HASTA YOKSA YENİ HASTA OLARAK EKLE
                            // SCOPE_IDENTITY() bize az önce eklenen hastanın ID'sini döndürür
                            string insertPatientQuery = @"INSERT INTO Patients (TCKimlik, AdSoyad, Telefon, KanGrubu) 
                                                          VALUES (@TC, @Ad, @Tel, @Kan); 
                                                          SELECT CAST(SCOPE_IDENTITY() AS int);";

                            using (SqlCommand cmdInsertP = new SqlCommand(insertPatientQuery, conn, islem))
                            {
                                cmdInsertP.Parameters.AddWithValue("@TC", txtTC.Text.Trim());
                                cmdInsertP.Parameters.AddWithValue("@Ad", txtAdSoyad.Text.Trim());
                                cmdInsertP.Parameters.AddWithValue("@Tel", txtTelefon.Text.Trim());
                                cmdInsertP.Parameters.AddWithValue("@Kan", ddlKanGrubu.SelectedValue);

                                hastaId = (int)cmdInsertP.ExecuteScalar();
                            }
                        }
                    }

                    // 3. ADIM: RANDEVUYU OLUŞTUR (HastaID elimizde hazır)
                    string insertAppQuery = @"INSERT INTO Appointments (HastaID, DoktorID, RandevuTarihi, Sikayet) 
                                              VALUES (@HastaID, @DoktorID, @Tarih, @Sikayet)";

                    using (SqlCommand cmdApp = new SqlCommand(insertAppQuery, conn, islem))
                    {
                        cmdApp.Parameters.AddWithValue("@HastaID", hastaId);
                        cmdApp.Parameters.AddWithValue("@DoktorID", seciliDoktorID);
                        cmdApp.Parameters.AddWithValue("@Tarih", Convert.ToDateTime(txtTarih.Text));
                        cmdApp.Parameters.AddWithValue("@Sikayet", txtSikayet.Text.Trim());

                        cmdApp.ExecuteNonQuery();
                    }

                    // Her şey sorunsuz çalıştıysa işlemi veritabanına kalıcı olarak işle
                    islem.Commit();

                    lblMesaj.Text = "Randevunuz başarıyla oluşturuldu!";
                    lblMesaj.CssClass = "mesaj basarili";

                    // Formu temizle
                    txtTC.Text = ""; txtAdSoyad.Text = ""; txtTelefon.Text = ""; txtSikayet.Text = ""; txtTarih.Text = "";
                }
                catch (Exception ex)
                {
                    // Hata olursa tüm işlemleri geri al (Tutarlılık koruması)
                    islem.Rollback();

                    lblMesaj.Text = "Randevu oluşturulurken bir hata oluştu: " + ex.Message;
                    lblMesaj.CssClass = "mesaj hatali";
                }
            }
        }
    }
}