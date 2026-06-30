<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RandevuOlustur.aspx.cs" Inherits="HastaneOtomasyon.RandevuOlustur" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Randevu | EmiraKlinik</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/emira-klinik.css" />
</head>
<body class="emira-klinik">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-ek mb-5 py-3">
            <div class="container">
                <a class="navbar-brand" href="Klinikler.aspx">&#x1F3E5; EmiraKlinik</a>
            </div>
        </nav>

        <div class="container" style="max-width: 650px;">
            <div class="card-ek p-5 mb-5">
                <div class="text-center mb-4">
                    <h3 class="page-title">Yeni Randevu Formu</h3>
                    <p class="text-secondary">Lütfen hasta bilgilerini eksiksiz giriniz.</p>
                </div>
                
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">TC Kimlik No</label>
                        <asp:TextBox ID="txtTC" runat="server" CssClass="form-control" MaxLength="11" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Ad Soyad</label>
                        <asp:TextBox ID="txtAdSoyad" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Telefon</label>
                        <asp:TextBox ID="txtTelefon" runat="server" CssClass="form-control" MaxLength="15"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Kan Grubu</label>
                        <asp:DropDownList ID="ddlKanGrubu" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Bilinmiyor" Value="Bilinmiyor"></asp:ListItem>
                            <asp:ListItem Text="A+" Value="A+"></asp:ListItem>
                            <asp:ListItem Text="A-" Value="A-"></asp:ListItem>
                            <asp:ListItem Text="B+" Value="B+"></asp:ListItem>
                            <asp:ListItem Text="B-" Value="B-"></asp:ListItem>
                            <asp:ListItem Text="AB+" Value="AB+"></asp:ListItem>
                            <asp:ListItem Text="AB-" Value="AB-"></asp:ListItem>
                            <asp:ListItem Text="0+" Value="0+"></asp:ListItem>
                            <asp:ListItem Text="0-" Value="0-"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Randevu Tarihi ve Saati</label>
                    <asp:TextBox ID="txtTarih" runat="server" TextMode="DateTimeLocal" CssClass="form-control" required="true"></asp:TextBox>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Şikayetiniz</label>
                    <asp:TextBox ID="txtSikayet" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" required="true"></asp:TextBox>
                </div>

                <div class="d-grid mt-4">
                    <asp:Button ID="btnKaydet" runat="server" Text="Randevuyu Onayla" CssClass="btn btn-ek py-3 fs-5" OnClick="btnKaydet_Click" />
                </div>
                
                <div class="text-center mt-4">
                    <asp:Label ID="lblMesaj" runat="server" CssClass="fw-bold"></asp:Label>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
