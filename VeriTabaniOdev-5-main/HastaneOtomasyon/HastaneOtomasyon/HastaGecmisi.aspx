<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HastaGecmisi.aspx.cs" Inherits="HastaneOtomasyon.HastaGecmisi" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hasta Geçmişi | EmiraKlinik</title>
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
                    <a class="nav-link active" href="HastaGecmisi.aspx">Hasta Geçmişi</a>
                    <a class="nav-link" href="GunlukPlan.aspx">Günlük Plan</a>
                </div>
            </div>
        </nav>

        <div class="container" style="max-width: 1000px;">
            <div class="card-ek p-5 mb-5 text-center">
                <h3 class="page-title mb-4">Hasta Dosyası Sorgulama</h3>
                <div class="d-flex justify-content-center">
                    <div class="input-group input-group-lg" style="max-width: 500px;">
                        <asp:TextBox ID="txtTCArama" runat="server" CssClass="form-control" placeholder="TC Kimlik No" MaxLength="11"></asp:TextBox>
                        <asp:Button ID="btnAra" runat="server" Text="Sorgula" CssClass="btn btn-ek px-4" OnClick="btnAra_Click" />
                    </div>
                </div>
            </div>

            <div class="text-center mb-4">
                <asp:Label ID="lblMesaj" runat="server" CssClass="text-danger fw-bold fs-5"></asp:Label>
                <asp:Label ID="lblHastaBilgi" runat="server" CssClass="fw-bold fs-4" style="color: var(--ek-primary);"></asp:Label>
            </div>

            <div class="card-ek overflow-hidden">
                <asp:GridView ID="gvGecmis" runat="server" AutoGenerateColumns="False" CssClass="table table-ek mb-0 w-100" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="RandevuTarihi" HeaderText="Tarih" DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                        <asp:BoundField DataField="KlinikAdi" HeaderText="Birim" />
                        <asp:BoundField DataField="DoktorAdi" HeaderText="Doktor" />
                        <asp:BoundField DataField="Sikayet" HeaderText="Şikayet" />
                        <asp:BoundField DataField="IlacListesi" HeaderText="Reçete" NullDisplayText="Yok" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
