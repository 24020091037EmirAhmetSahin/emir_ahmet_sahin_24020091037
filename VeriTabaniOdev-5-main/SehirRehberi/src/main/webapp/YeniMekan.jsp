<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
  String cityIdParam = request.getParameter("cityId");
  if (cityIdParam == null || cityIdParam.isEmpty()) { response.sendRedirect("index.jsp"); return; }
  int cityId = Integer.parseInt(cityIdParam);
  String mesaj = "";

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String mekanAdi = request.getParameter("mekanAdi");
    String aciklama = request.getParameter("aciklama");
    String tur = request.getParameter("tur");
    Connection conn = null;
    try {
      conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement("INSERT INTO Places (SehirID, MekanAdi, Aciklama, Tur) VALUES (?, ?, ?, ?)");
      pstmt.setInt(1, cityId);
      pstmt.setString(2, mekanAdi);
      pstmt.setString(3, aciklama);
      pstmt.setString(4, tur);
      if (pstmt.executeUpdate() > 0) { response.sendRedirect("SehirDetay.jsp?cityId=" + cityId); return; }
      else { mesaj = "<div class='alert alert-danger rounded-4'>Kayıt başarısız.</div>"; }
    } catch(Exception e) { mesaj = "<div class='alert alert-danger rounded-4'>" + e.getMessage() + "</div>"; }
    finally { if (conn != null) conn.close(); }
  }
%>
<!DOCTYPE html>
<html lang="tr" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <title>Yeni Mekan | EmiraGezi</title>
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

<div class="container">
  <div class="panel-em mx-auto my-5 p-4 p-md-5" style="max-width: 600px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="fw-bold m-0">Yeni Mekan Tanımla</h2>
      <a href="SehirDetay.jsp?cityId=<%= cityId %>" class="btn btn-outline-secondary border-0"><i class="bi bi-x-lg"></i></a>
    </div>

    <%= mesaj %>

    <form action="YeniMekan.jsp?cityId=<%= cityId %>" method="POST">
      <div class="mb-4">
        <label class="form-label fw-semibold">Mekan Adı</label>
        <input type="text" name="mekanAdi" class="form-control" required placeholder="Örn: Galata Kulesi">
      </div>

      <div class="mb-4">
        <label class="form-label fw-semibold">Kategori</label>
        <select name="tur" class="form-select" required>
          <option value="Müze">Müze</option>
          <option value="Park/Doğa">Park / Doğa</option>
          <option value="Restoran/Kafe">Restoran / Kafe</option>
          <option value="Tarihi Eser">Tarihi Eser</option>
          <option value="Eğlence">Eğlence</option>
        </select>
      </div>

      <div class="mb-4">
        <label class="form-label fw-semibold">Açıklama</label>
        <textarea name="aciklama" class="form-control" rows="4" required placeholder="Mekanı anlatın..."></textarea>
      </div>

      <button type="submit" class="btn btn-em w-100 py-2">Kaydet</button>
    </form>
  </div>
</div>
</body>
</html>
