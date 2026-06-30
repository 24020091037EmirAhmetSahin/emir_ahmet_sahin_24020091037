<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GunlukPlan.aspx.cs" Inherits="HastaneOtomasyon.GunlukPlan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Günlük Plan | EmiraKlinik</title>
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
                    <a class="nav-link active" href="GunlukPlan.aspx">Günlük Plan</a>
                </div>
            </div>
        </nav>

        <div class="container" style="max-width: 1000px;">
            <div class="card-ek p-5 mb-5 text-center">
                <h3 class="page-title mb-4">Günlük Randevu Çizelgesi</h3>
                
                <div class="d-flex justify-content-center align-items-center gap-3 flex-wrap">
                    <label class="fw-bold fs-5 text-secondary">Hekim:</label>
                    <asp:DropDownList ID="ddlDoktorlar" runat="server" CssClass="form-select form-select-lg w-auto" AutoPostBack="true" OnSelectedIndexChanged="ddlDoktorlar_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </div>

            <div class="text-center mb-4">
                <asp:Label ID="lblMesaj" runat="server" CssClass="text-warning fw-bold fs-5"></asp:Label>
            </div>

            <div class="card-ek overflow-hidden">
                <asp:GridView ID="gvGunlukPlan" runat="server" AutoGenerateColumns="False" CssClass="table table-ek mb-0 w-100" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="RandevuTarihi" HeaderText="Saat" DataFormatString="{0:HH:mm}" ItemStyle-CssClass="fw-bold" />
                        <asp:BoundField DataField="HastaAdi" HeaderText="Hasta" />
                        <asp:BoundField DataField="TCKimlik" HeaderText="TC No" />
                        <asp:BoundField DataField="KanGrubu" HeaderText="Kan" ItemStyle-CssClass="fw-bold" />
                        <asp:BoundField DataField="Sikayet" HeaderText="Şikayet" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
