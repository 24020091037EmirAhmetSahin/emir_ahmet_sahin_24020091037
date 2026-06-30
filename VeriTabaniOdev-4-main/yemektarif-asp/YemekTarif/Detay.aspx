<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detay.aspx.cs" Inherits="YemekTarif.Detay" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarif Detayı | Emira Mutfak</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="nav-top">
                <a href="Default.aspx" class="btn btn-ghost">&larr; Ana Sayfaya Dön</a>
            </div>

            <div class="detail-panel">
                <div class="img-container">
                    <asp:Image ID="imgFoto" runat="server" />
                </div>
                <h2><asp:Literal ID="litBaslik" runat="server"></asp:Literal></h2>
                <hr class="detail-divider" />
                <div class="detay-metni">
                    <asp:Literal ID="litDetay" runat="server"></asp:Literal>
                </div>
            </div>

            <footer class="site-footer">&copy; 2026 Emira — Veri Tabanı Ödev 4</footer>
        </div>
    </form>
</body>
</html>
