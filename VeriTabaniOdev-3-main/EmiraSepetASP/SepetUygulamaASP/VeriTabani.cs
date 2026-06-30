using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SepetUygulamaASP
{
    public class VeriTabani
    {
        // Web.config'deki bağlantı adını okur
        private static string BaglantiYolu = ConfigurationManager.ConnectionStrings["VTBaglanti"].ConnectionString;

        public static DataTable VeriGetir(string sql, SqlParameter[] parametreler = null)
        {
            using (SqlConnection conn = new SqlConnection(BaglantiYolu))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                if (parametreler != null) da.SelectCommand.Parameters.AddRange(parametreler);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public static void KomutCalistir(string sql, SqlParameter[] parametreler = null)
        {
            using (SqlConnection conn = new SqlConnection(BaglantiYolu))
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                if (parametreler != null) cmd.Parameters.AddRange(parametreler);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}