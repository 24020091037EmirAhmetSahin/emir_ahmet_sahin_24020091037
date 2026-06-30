<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
  String aramaKelimesi = request.getParameter("q");
  String seciliBolge = request.getParameter("bolge");
  String seciliTur = request.getParameter("tur");
%>
<!DOCTYPE html>
<html lang="tr" data-bs-theme="dark">
<head>
  <meta charset="UTF-8">
  <title>Arama | EmiraGezi</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="css/emira-gezi.css">
</head>
<body class="emira-gezi">

<nav class="navbar navbar-expand-lg navbar-em sticky-top py-3">
  <div class="container">
    <a class="navbar-brand" href="index.jsp"><i class="bi bi-compass-fill me-2"></i>EmiraGezi</a>
    <div class="navbar-nav ms-auto gap-3">
      <a class="nav-link" href="index.jsp">Keşfet</a>
      <a class="nav-link active" href="Arama.jsp">Arama & Filtre</a>
    </div>
  </div>
</nav>

<div class="container pb-5">
  <div class="panel-em my-4 p-4">
    <h3 class="section-title mb-4"><i class="bi bi-search me-2" style="color: var(--em-primary);"></i>Mekan Arama</h3>
    <form action="Arama.jsp" method="GET" class="row g-3">
      <div class="col-md-5">
        <input type="text" name="q" class="form-control" placeholder="Mekan adı ara..." value="<%= (aramaKelimesi != null) ? aramaKelimesi : "" %>">
      </div>
      <div class="col-md-3">
        <select name="bolge" class="form-select">
          <option value="">Tüm Bölgeler</option>
          <option value="Marmara" <%= ("Marmara".equals(seciliBolge)) ? "selected" : "" %>>Marmara</option>
          <option value="Ege" <%= ("Ege".equals(seciliBolge)) ? "selected" : "" %>>Ege</option>
          <option value="Akdeniz" <%= ("Akdeniz".equals(seciliBolge)) ? "selected" : "" %>>Akdeniz</option>
          <option value="İç Anadolu" <%= ("İç Anadolu".equals(seciliBolge)) ? "selected" : "" %>>İç Anadolu</option>
          <option value="Karadeniz" <%= ("Karadeniz".equals(seciliBolge)) ? "selected" : "" %>>Karadeniz</option>
        </select>
      </div>
      <div class="col-md-2">
        <select name="tur" class="form-select">
          <option value="">Tüm Kategoriler</option>
          <option value="Müze" <%= ("Müze".equals(seciliTur)) ? "selected" : "" %>>Müze</option>
          <option value="Park/Doğa" <%= ("Park/Doğa".equals(seciliTur)) ? "selected" : "" %>>Park / Doğa</option>
          <option value="Restoran/Kafe" <%= ("Restoran/Kafe".equals(seciliTur)) ? "selected" : "" %>>Restoran / Kafe</option>
          <option value="Tarihi Eser" <%= ("Tarihi Eser".equals(seciliTur)) ? "selected" : "" %>>Tarihi Eser</option>
        </select>
      </div>
      <div class="col-md-2">
        <button type="submit" class="btn btn-em w-100">Ara</button>
      </div>
    </form>
  </div>

  <div class="row g-4">
    <%
      Connection conn = null;
      try {
        conn = DBConnection.getConnection();
        StringBuilder sql = new StringBuilder("SELECT p.ID, p.MekanAdi, p.Tur, p.Aciklama, c.SehirAdi, c.Bolge FROM Places p INNER JOIN Cities c ON p.SehirID = c.ID WHERE 1=1");
        List<Object> param = new ArrayList<>();

        if (aramaKelimesi != null && !aramaKelimesi.trim().isEmpty()) { sql.append(" AND p.MekanAdi ILIKE ?"); param.add("%" + aramaKelimesi.trim() + "%"); }
        if (seciliBolge != null && !seciliBolge.isEmpty()) { sql.append(" AND c.Bolge = ?"); param.add(seciliBolge); }
        if (seciliTur != null && !seciliTur.isEmpty()) { sql.append(" AND p.Tur = ?"); param.add(seciliTur); }

        sql.append(" ORDER BY p.MekanAdi ASC");
        PreparedStatement pstmt = conn.prepareStatement(sql.toString());
        for (int i = 0; i < param.size(); i++) { pstmt.setObject(i + 1, param.get(i)); }

        ResultSet rs = pstmt.executeQuery();
        boolean sonucVar = false;
        while(rs.next()) {
          sonucVar = true;
    %>
    <div class="col-md-6">
      <div class="panel-em h-100 d-flex flex-column">
        <div class="d-flex justify-content-between align-items-start mb-3">
          <div>
            <h4 class="fw-bold mb-1"><%= rs.getString("MekanAdi") %></h4>
            <div class="text-secondary small"><i class="bi bi-geo-alt me-1"></i><%= rs.getString("SehirAdi") %>, <%= rs.getString("Bolge") %></div>
          </div>
          <span class="badge-region"><%= rs.getString("Tur") %></span>
        </div>
        <p class="text-secondary flex-grow-1">
          <%= rs.getString("Aciklama").length() > 100 ? rs.getString("Aciklama").substring(0, 100) + "..." : rs.getString("Aciklama") %>
        </p>
        <a href="MekanDetay.jsp?placeId=<%= rs.getInt("ID") %>" class="btn btn-outline-secondary rounded-pill align-self-start mt-3 px-4">İncele</a>
      </div>
    </div>
    <%
        }
        if (!sonucVar) out.println("<div class='col-12'><div class='panel-em text-center py-5 text-secondary'><i class='bi bi-search fs-1 d-block mb-3'></i>Sonuç bulunamadı.</div></div>");
      } catch(Exception e) { out.println("<div class='alert alert-danger'>" + e.getMessage() + "</div>"); }
      finally { if (conn != null) conn.close(); }
    %>
  </div>
</div>
</body>
</html>
