<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="tr" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EmiraGezi | Şehir Rehberi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/emira-gezi.css">
</head>
<body class="emira-gezi">

<nav class="navbar navbar-expand-lg navbar-em sticky-top py-3">
    <div class="container">
        <a class="navbar-brand" href="index.jsp"><i class="bi bi-compass-fill me-2"></i>EmiraGezi</a>
        <div class="navbar-nav ms-auto gap-3">
            <a class="nav-link active" href="index.jsp">Keşfet</a>
            <a class="nav-link" href="Arama.jsp">Arama & Filtre</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="text-center py-5">
        <h1 class="hero-title">Sıradaki Maceranı Seç</h1>
        <p class="text-secondary fs-5">Türkiye'nin şehirlerini, mekanlarını ve yerel rehberlerini keşfet.</p>
    </div>

    <div class="row g-4 pb-5">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = DBConnection.getConnection();
                if (conn != null) {
                    String sql = "SELECT * FROM Cities ORDER BY SehirAdi ASC";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    while(rs.next()) {
                        int id = rs.getInt("ID");
                        String sehirAdi = rs.getString("SehirAdi");
                        String bolge = rs.getString("Bolge");
                        int nufus = rs.getInt("Nufus");
        %>
        <div class="col-md-4">
            <a href="SehirDetay.jsp?cityId=<%= id %>" class="city-card h-100">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <h3 class="city-title"><%= sehirAdi %></h3>
                    <i class="bi bi-arrow-right-circle fs-4" style="color: var(--em-primary);"></i>
                </div>
                <span class="badge-region"><i class="bi bi-map me-1"></i><%= bolge %></span>
                <p class="text-secondary mt-4 mb-0"><i class="bi bi-people me-2"></i>Nüfus: <strong><%= String.format("%,d", nufus) %></strong></p>
            </a>
        </div>
        <%
                    }
                } else {
                    out.println("<div class='col-12'><div class='alert alert-danger rounded-4'>Veritabanı bağlantı hatası. PostgreSQL çalışıyor mu?</div></div>");
                }
            } catch(Exception e) {
                out.println("<div class='col-12'><div class='alert alert-danger rounded-4'>" + e.getMessage() + "</div></div>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</div>
<footer class="text-center text-secondary py-4 border-top" style="border-color: var(--border) !important;">
    <small>EmiraGezi &mdash; Emira | Veritabanı Ödevi</small>
</footer>
</body>
</html>
