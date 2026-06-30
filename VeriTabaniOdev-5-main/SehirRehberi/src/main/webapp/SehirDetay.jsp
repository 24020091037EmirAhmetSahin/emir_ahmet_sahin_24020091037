<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String cityIdParam = request.getParameter("cityId");
  if (cityIdParam == null || cityIdParam.isEmpty()) { response.sendRedirect("index.jsp"); return; }
  int cityId = Integer.parseInt(cityIdParam);
  String sehirAdi = "";
%>
<!DOCTYPE html>
<html lang="tr" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <title>Şehir Detayı | EmiraGezi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/emira-gezi.css">
</head>
<body class="emira-gezi">

<nav class="navbar navbar-expand-lg navbar-em sticky-top py-3">
  <div class="container">
    <a class="navbar-brand" href="index.jsp"><i class="bi bi-compass-fill me-2"></i>EmiraGezi</a>
    <a href="index.jsp" class="btn btn-outline-secondary rounded-pill px-4 fw-bold"><i class="bi bi-arrow-left me-2"></i>Geri</a>
  </div>
</nav>

<div class="container pb-5">
  <%
    Connection conn = null;
    try {
      conn = DBConnection.getConnection();
      PreparedStatement pstmtCity = conn.prepareStatement("SELECT SehirAdi FROM Cities WHERE ID = ?");
      pstmtCity.setInt(1, cityId);
      ResultSet rsCity = pstmtCity.executeQuery();
      if (rsCity.next()) sehirAdi = rsCity.getString("SehirAdi");
  %>

  <div class="d-flex justify-content-between align-items-end py-4 flex-wrap gap-3">
    <div>
      <span class="text-uppercase fw-bold small" style="color: var(--em-accent);"><i class="bi bi-geo me-1"></i>Lokasyon</span>
      <h1 class="fw-bold mt-1" style="font-size: 2.5rem;"><%= sehirAdi %></h1>
    </div>
    <a href="YeniMekan.jsp?cityId=<%= cityId %>" class="btn btn-em"><i class="bi bi-plus-lg me-2"></i>Yeni Mekan Ekle</a>
  </div>

  <div class="row mt-2">
    <div class="col-lg-8">
      <h3 class="section-title mb-4">Gezilecek Yerler</h3>
      <%
        PreparedStatement pstmtPlaces = conn.prepareStatement("SELECT * FROM Places WHERE SehirID = ?");
        pstmtPlaces.setInt(1, cityId);
        ResultSet rsPlaces = pstmtPlaces.executeQuery();
        boolean mekanVar = false;
        while(rsPlaces.next()) {
          mekanVar = true;
      %>
      <div class="panel-em d-flex justify-content-between align-items-center mb-3">
        <div>
          <h5 class="fw-bold mb-2"><%= rsPlaces.getString("MekanAdi") %></h5>
          <span class="badge-region"><%= rsPlaces.getString("Tur") %></span>
        </div>
        <a href="MekanDetay.jsp?placeId=<%= rsPlaces.getInt("ID") %>" class="btn btn-em rounded-pill px-4">İncele</a>
      </div>
      <%
        }
        if (!mekanVar) out.print("<div class='panel-em text-center py-4 text-secondary'><i class='bi bi-inbox fs-1 d-block mb-2'></i>Bu şehre ait mekan bulunamadı.</div>");
      %>
    </div>

    <div class="col-lg-4 mt-5 mt-lg-0">
      <h3 class="section-title mb-4">Yerel Rehberler</h3>
      <%
        String sqlGuides = "SELECT g.RehberAdi, g.UzmanlikAlani, g.Iletisim FROM Guides g INNER JOIN City_Guide_Match cgm ON g.ID = cgm.RehberID WHERE cgm.SehirID = ?";
        PreparedStatement pstmtGuides = conn.prepareStatement(sqlGuides);
        pstmtGuides.setInt(1, cityId);
        ResultSet rsGuides = pstmtGuides.executeQuery();
        boolean rehberVar = false;
        while(rsGuides.next()) {
          rehberVar = true;
      %>
      <div class="panel-em d-flex gap-3 align-items-center mb-3">
        <div class="rounded-3 d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; background: rgba(90,143,123,0.15); color: var(--em-accent);">
          <i class="bi bi-person-fill fs-4"></i>
        </div>
        <div>
          <h6 class="fw-bold mb-1"><%= rsGuides.getString("RehberAdi") %></h6>
          <div class="text-secondary small"><i class="bi bi-bookmark-star me-1"></i><%= rsGuides.getString("UzmanlikAlani") %></div>
          <div class="small fw-semibold mt-1" style="color: var(--em-primary);"><i class="bi bi-telephone me-1"></i><%= rsGuides.getString("Iletisim") %></div>
        </div>
      </div>
      <%
        }
        if (!rehberVar) out.print("<div class='panel-em text-center py-4 text-secondary'>Rehber bulunamadı.</div>");
      %>
    </div>
  </div>

  <%
    } catch(Exception e) { out.print("<div class='alert alert-danger'>" + e.getMessage() + "</div>"); }
    finally { if (conn != null) conn.close(); }
  %>
</div>
</body>
</html>
