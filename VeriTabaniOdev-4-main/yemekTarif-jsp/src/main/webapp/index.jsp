<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emira Mutfak | Tarif Portalı</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
<div class="container">
    <header class="site-header">
        <div class="brand">
            <span class="brand-badge">Emira'nın Tarif Defteri</span>
            <h1>Lezzetli Tarifler</h1>
            <p>Veri Tabanı Ödevi — JSP & PostgreSQL</p>
        </div>
        <a href="crud.jsp" class="btn btn-primary">Yönetim Paneli</a>
    </header>
    <div class="grid">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/emira_tarif_db", "postgres", "6190");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM Tarifler ORDER BY id DESC");

                while (rs.next()) {
                    String id = rs.getString("id");
                    String baslik = rs.getString("baslik");
                    String detay = rs.getString("detay");
                    String foto = rs.getString("fotograf_url");

                    if (foto == null || foto.trim().isEmpty()) {
                        foto = "https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=800&q=80";
                    }

                    String kisaDetay = detay.length() > 100 ? detay.substring(0, 100) + "..." : detay;
        %>
        <article class="card">
            <div class="card-img-wrap">
                <img src="<%=foto%>" alt="Yemek">
                <span class="card-tag">Tarif</span>
            </div>
            <div class="card-body">
                <h2><%=baslik%></h2>
                <p><%=kisaDetay%></p>
                <a href="detay.jsp?id=<%=id%>" class="btn btn-detail">Tarifi Oku</a>
            </div>
        </article>
        <%
                }
            } catch (Exception e) {
                out.println("<p class='empty-state'>Hata: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("Bağlantı kapatılırken hata: " + e.getMessage());
                }
            }
        %>
    </div>
    <footer class="site-footer">&copy; 2026 Emira — Veri Tabanı Ödev 4</footer>
</div>
</body>
</html>
