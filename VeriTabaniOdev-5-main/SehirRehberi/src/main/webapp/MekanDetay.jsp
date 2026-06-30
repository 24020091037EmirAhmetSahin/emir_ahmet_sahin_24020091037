<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String placeIdParam = request.getParameter("placeId");
  if (placeIdParam == null || placeIdParam.isEmpty()) { response.sendRedirect("index.jsp"); return; }
  int placeId = Integer.parseInt(placeIdParam);
  String mekanAdi = "", aciklama = "", tur = "";
  int sehirId = 0;
%>
<!DOCTYPE html>
<html lang="tr" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <title>Mekan Detayı | EmiraGezi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/emira-gezi.css">
</head>
<body class="emira-gezi">

<nav class="navbar navbar-expand-lg navbar-em sticky-top py-3">
  <div class="container">
    <a class="navbar-brand" href="index.jsp"><i class="bi bi-compass-fill me-2"></i>EmiraGezi</a>
  </div>
</nav>

<div class="container pb-5">
  <%
    Connection conn = null;
    try {
      conn = DBConnection.getConnection();
      PreparedStatement pstmtPlace = conn.prepareStatement("SELECT * FROM Places WHERE ID = ?");
      pstmtPlace.setInt(1, placeId);
      ResultSet rsPlace = pstmtPlace.executeQuery();
      if (rsPlace.next()) {
        mekanAdi = rsPlace.getString("MekanAdi");
        aciklama = rsPlace.getString("Aciklama");
        tur = rsPlace.getString("Tur");
        sehirId = rsPlace.getInt("SehirID");
      }
  %>

  <div class="mt-4">
    <a href="SehirDetay.jsp?cityId=<%= sehirId %>" class="btn btn-outline-secondary rounded-pill px-4"><i class="bi bi-arrow-left me-2"></i>Şehre Dön</a>
  </div>

  <div class="panel-em mt-4 p-4 p-md-5">
    <span class="badge-region mb-3 d-inline-block"><i class="bi bi-tag-fill me-2"></i><%= tur %></span>
    <h1 class="fw-bold mb-4" style="font-size: 2.5rem;"><%= mekanAdi %></h1>
    <p class="fs-5 text-secondary lh-lg m-0" style="max-width: 800px;"><%= aciklama %></p>
  </div>

  <div class="d-flex align-items-center my-4">
    <i class="bi bi-calendar-event-fill fs-3 me-3" style="color: var(--em-primary);"></i>
    <h3 class="section-title m-0">Yaklaşan Etkinlikler</h3>
  </div>

  <div class="row g-4">
    <%
      PreparedStatement pstmtEvents = conn.prepareStatement("SELECT * FROM Events WHERE MekanID = ? ORDER BY Tarih ASC");
      pstmtEvents.setInt(1, placeId);
      ResultSet rsEvents = pstmtEvents.executeQuery();
      boolean etkinlikVar = false;
      while(rsEvents.next()) {
        etkinlikVar = true;
        double ucret = rsEvents.getDouble("Ucret");
    %>
    <div class="col-md-6">
      <div class="panel-em d-flex justify-content-between align-items-center h-100">
        <div>
          <h5 class="fw-bold mb-2"><%= rsEvents.getString("EtkinlikAdi") %></h5>
          <div class="text-secondary"><i class="bi bi-clock me-2"></i><%= rsEvents.getDate("Tarih") %></div>
        </div>
        <div class="price-tag">
          <%= (ucret == 0) ? "Ücretsiz" : String.format("%.2f ₺", ucret) %>
        </div>
      </div>
    </div>
    <%
      }
      if (!etkinlikVar) out.print("<div class='col-12'><div class='panel-em text-center py-4 text-secondary'><i class='bi bi-calendar-x fs-1 d-block mb-2'></i>Planlanmış etkinlik yok.</div></div>");
    %>
  </div>

  <%
    } catch(Exception e) { out.print("<div class='alert alert-danger'>" + e.getMessage() + "</div>"); }
    finally { if (conn != null) conn.close(); }
  %>
</div>
</body>
</html>
