<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarif Detayı | Emira Mutfak</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
<div class="container">
    <div class="nav-top">
        <a href="index.jsp" class="btn btn-ghost">&larr; Ana Sayfaya Dön</a>
    </div>
    <div class="detail-panel">
        <%
            String tarifId = request.getParameter("id");
            if(tarifId != null) {
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/emira_tarif_db", "postgres", "6190");
                    PreparedStatement pst = conn.prepareStatement("SELECT * FROM Tarifler WHERE id = ?");
                    pst.setInt(1, Integer.parseInt(tarifId));
                    ResultSet rs = pst.executeQuery();

                    if(rs.next()) {
                        String baslik = rs.getString("baslik");
                        String detay = rs.getString("detay");
                        String foto = rs.getString("fotograf_url");
                        if(foto == null || foto.trim().isEmpty()) foto = "https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=800&q=80";
        %>
        <div class="img-container">
            <img src="<%=foto%>" alt="Fotoğraf">
        </div>
        <h2><%=baslik%></h2>
        <hr class="detail-divider" />
        <div class="detay-metni"><%=detay%></div>
        <%
                    }
                    rs.close(); pst.close(); conn.close();
                } catch(Exception e) { out.println("Hata oluştu."); }
            }
        %>
    </div>
    <footer class="site-footer">&copy; 2026 Emira — Veri Tabanı Ödev 4</footer>
</div>
</body>
</html>
