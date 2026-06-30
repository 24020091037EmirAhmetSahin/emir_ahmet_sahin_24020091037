<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Veritabanı Bilgileri
    String dbUrl = "jdbc:postgresql://localhost:5432/emira_tarif_db";
    String dbUser = "postgres";
    String dbPass = "6190";

    request.setCharacterEncoding("UTF-8");

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        // --- CREATE (Ekleme) ---
        if(request.getParameter("ekle") != null) {
            String baslik = request.getParameter("baslik");
            String foto = request.getParameter("foto_url");
            String detay = request.getParameter("detay");
            PreparedStatement pst = conn.prepareStatement("INSERT INTO Tarifler (baslik, detay, fotograf_url) VALUES (?, ?, ?)");
            pst.setString(1, baslik); pst.setString(2, detay); pst.setString(3, foto);
            pst.executeUpdate(); pst.close();
            response.sendRedirect("crud.jsp");
            return;
        }

        // --- UPDATE (Güncelleme) ---
        if(request.getParameter("guncelle") != null) {
            String id = request.getParameter("id");
            String baslik = request.getParameter("baslik");
            String foto = request.getParameter("foto_url");
            String detay = request.getParameter("detay");
            PreparedStatement pst = conn.prepareStatement("UPDATE Tarifler SET baslik=?, detay=?, fotograf_url=? WHERE id=?");
            pst.setString(1, baslik); pst.setString(2, detay); pst.setString(3, foto); pst.setInt(4, Integer.parseInt(id));
            pst.executeUpdate(); pst.close();
            response.sendRedirect("crud.jsp");
            return;
        }

        // --- DELETE (Silme) ---
        if(request.getParameter("sil") != null) {
            String id = request.getParameter("sil");
            PreparedStatement pst = conn.prepareStatement("DELETE FROM Tarifler WHERE id=?");
            pst.setInt(1, Integer.parseInt(id));
            pst.executeUpdate(); pst.close();
            response.sendRedirect("crud.jsp");
            return;
        }
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetim Paneli | Emira Mutfak</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
<div class="container">
    <header class="site-header">
        <div class="brand">
            <span class="brand-badge">CRUD İşlemleri</span>
            <h1>Tarif Yönetimi</h1>
            <p>Ekle · Güncelle · Sil · Listele</p>
        </div>
        <a href="index.jsp" class="btn btn-ghost">&larr; Ana Sayfa</a>
    </header>
    <div class="admin-layout">
    <div class="panel">
        <h2>Yeni Tarif Ekle</h2>
        <form method="POST">
            <input type="text" name="baslik" placeholder="Yemek Adı" required>
            <input type="text" name="foto_url" placeholder="Fotoğraf URL">
            <textarea name="detay" rows="6" placeholder="Tarif Detayları" required></textarea>
            <button type="submit" name="ekle" class="btn-submit">Tarifi Kaydet</button>
        </form>
    </div>
    <div class="panel">
        <h2>Kayıtlı Tarifler</h2>
        <div style="overflow-x:auto;">
            <table>
                <tr><th>ID</th><th>Yemek Başlığı</th><th>İşlemler</th></tr>
                <%
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM Tarifler ORDER BY id DESC");
                    while(rs.next()) {
                %>
                <tr>
                    <td><strong>#<%=rs.getString("id")%></strong></td>
                    <td><%=rs.getString("baslik")%></td>
                    <td class="action-links">
                        <button type="button" class="btn-edit"
                                data-id="<%=rs.getString("id")%>"
                                data-baslik="<%=rs.getString("baslik")%>"
                                data-foto="<%=rs.getString("fotograf_url")%>"
                                data-detay="<%=rs.getString("detay")%>"
                                onclick="openModal(this)">Düzenle</button>
                        <a href="?sil=<%=rs.getString("id")%>" class="btn-delete" onclick="return confirm('Emin misin?');">Sil</a>
                    </td>
                </tr>
                <% } rs.close(); stmt.close(); conn.close(); %>
            </table>
        </div>
    </div>
    </div>
    <footer class="site-footer">&copy; 2026 Emira — Veri Tabanı Ödev 4</footer>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>Tarifi Güncelle</h2>
        <form method="POST">
            <input type="hidden" name="id" id="modal_id">
            <input type="text" name="baslik" id="modal_baslik" required>
            <input type="text" name="foto_url" id="modal_foto">
            <textarea name="detay" id="modal_detay" rows="6" required></textarea>
            <button type="submit" name="guncelle" class="btn-submit" style="background:#3498db;">Değişiklikleri Kaydet</button>
        </form>
    </div>
</div>

<script>
    function openModal(btn) {
        document.getElementById('modal_id').value = btn.getAttribute('data-id');
        document.getElementById('modal_baslik').value = btn.getAttribute('data-baslik');
        document.getElementById('modal_foto').value = btn.getAttribute('data-foto');
        document.getElementById('modal_detay').value = btn.getAttribute('data-detay');
        document.getElementById('editModal').style.display = 'flex';
    }
    function closeModal() { document.getElementById('editModal').style.display = 'none'; }
</script>
</body>
</html>
<%
    } catch(Exception e) { out.println("Hata: " + e.getMessage()); }
%>