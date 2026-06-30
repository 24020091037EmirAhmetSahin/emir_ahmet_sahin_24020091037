<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Klinikler.aspx.cs" Inherits="HastaneOtomasyon.Klinikler" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Klinikler | EmiraKlinik</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/emira-klinik.css" />
</head>
<body class="emira-klinik">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-ek mb-5 py-3">
            <div class="container">
                <a class="navbar-brand" href="Klinikler.aspx">&#x1F3E5; EmiraKlinik</a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link active" href="Klinikler.aspx">Klinikler</a>
                    <a class="nav-link" href="HastaGecmisi.aspx">Hasta Geçmişi</a>
                    <a class="nav-link" href="GunlukPlan.aspx">Günlük Plan</a>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="row mb-5 text-center">
                <div class="col">
                    <h2 class="page-title">Poliklinikler</h2>
                    <p class="text-secondary">Randevu almak istediğiniz birimi seçiniz.</p>
                </div>
            </div>
            
            <div class="row g-4">
                <asp:Repeater ID="rptKlinikler" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4">
                            <a href='Doktorlar.aspx?clinicId=<%# Eval("ID") %>' class="text-decoration-none">
                                <div class="card-ek h-100 p-4 text-center">
                                    <h4 class="fw-bold mb-3" style="color: var(--ek-primary-dark);"><%# Eval("KlinikAdi") %></h4>
                                    <span class="badge rounded-pill px-3 py-2" style="background: rgba(13,148,136,0.12); color: var(--ek-primary);">Kat: <%# Eval("KatNo") %></span>
                                    <p class="text-secondary mt-3 mb-0">Uzmanlık: <strong><%# Eval("Uzmanlik") %></strong></p>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
</body>
</html>
