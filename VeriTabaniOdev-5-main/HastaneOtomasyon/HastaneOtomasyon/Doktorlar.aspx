<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Doktorlar.aspx.cs" Inherits="HastaneOtomasyon.Doktorlar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doktorlar | EmiraKlinik</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/emira-klinik.css" />
</head>
<body class="emira-klinik">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-ek mb-5 py-3">
            <div class="container">
                <a class="navbar-brand" href="Klinikler.aspx">&#x1F3E5; EmiraKlinik</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="Klinikler.aspx">Klinikler</a>
                    <a class="nav-link" href="HastaGecmisi.aspx">Hasta Geçmişi</a>
                    <a class="nav-link" href="GunlukPlan.aspx">Günlük Plan</a>
                </div>
            </div>
        </nav>

        <div class="container" style="max-width: 800px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="Klinikler.aspx" class="btn btn-outline-secondary btn-sm rounded-pill px-3">&#8592; Geri</a>
                <h3 class="page-title m-0">Mevcut Doktorlar</h3>
                <div style="width: 70px;"></div>
            </div>
            
            <div class="list-group border-0">
                <asp:Repeater ID="rptDoktorlar" runat="server">
                    <ItemTemplate>
                        <div class="card-ek d-flex justify-content-between align-items-center p-4 mb-3">
                            <div>
                                <h5 class="fw-bold mb-1" style="color: var(--ek-primary-dark);"><%# Eval("AdSoyad") %></h5>
                                <small class="text-secondary"><%# Eval("Unvan") %></small>
                            </div>
                            <a href='RandevuOlustur.aspx?docId=<%# Eval("ID") %>' class="btn btn-ek px-4">Randevu Al</a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>
