using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HastaneOtomasyon
{
    public partial class GunlukPlan : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["HastaneDBConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DoktorlariDoldur();
            }
        }

        private void DoktorlariDoldur()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Doktorların yanına çalıştıkları kliniği de yazdıralım ki hoca rahat seçsin
                string query = @"SELECT d.ID, (d.AdSoyad + ' (' + c.KlinikAdi + ')') AS DoktorBilgi 
                                 FROM Doctors d
                                 INNER JOIN Clinics c ON d.KlinikID = c.ID 
                                 ORDER BY d.AdSoyad ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlDoktorlar.DataSource = reader;
                    ddlDoktorlar.DataTextField = "DoktorBilgi"; // Ekranda görünecek yazı
                    ddlDoktorlar.DataValueField = "ID";         // Arkada tutulacak asıl veri (DoktorID)
                    ddlDoktorlar.DataBind();

                    // İlk sıraya boş bir seçenek ekleyelim
                    ddlDoktorlar.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Lütfen Bir Doktor Seçin", "0"));
                }
            }
        }

        protected void ddlDoktorlar_SelectedIndexChanged(object sender, EventArgs e)
        {
            int seciliDoktorID = Convert.ToInt32(ddlDoktorlar.SelectedValue);

            if (seciliDoktorID > 0)
            {
                GunlukRandevulariGetir(seciliDoktorID);
            }
            else
            {
                // "Lütfen seçin" kısmına geri dönülürse tabloyu temizle
                gvGunlukPlan.DataSource = null;
                gvGunlukPlan.DataBind();
                lblMesaj.Text = "";
            }
        }

        private void GunlukRandevulariGetir(int doktorId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // CAST(a.RandevuTarihi AS DATE) = CAST(GETDATE() AS DATE) 
                // Bu kod sadece BUGÜNÜN tarihine sahip randevuları saat bağımsız eşleştirir.
                string query = @"
                    SELECT 
                        a.RandevuTarihi, 
                        p.AdSoyad AS HastaAdi, 
                        p.TCKimlik, 
                        p.KanGrubu, 
                        a.Sikayet 
                    FROM Appointments a
                    INNER JOIN Patients p ON a.HastaID = p.ID
                    WHERE a.DoktorID = @DoktorID 
                    AND CAST(a.RandevuTarihi AS DATE) = CAST(GETDATE() AS DATE)
                    ORDER BY a.RandevuTarihi ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@DoktorID", doktorId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            gvGunlukPlan.DataSource = dt;
                            gvGunlukPlan.DataBind();
                            lblMesaj.Text = "";
                        }
                        else
                        {
                            gvGunlukPlan.DataSource = null;
                            gvGunlukPlan.DataBind();
                            lblMesaj.Text = "Seçili doktorun bugüne ait randevusu bulunmamaktadır.";
                        }
                    }
                }
            }
        }
    }
}