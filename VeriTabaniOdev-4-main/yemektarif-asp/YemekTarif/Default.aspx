<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="YemekTarif.Default" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emira Mutfak | Tarif Portalı</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <header class="site-header">
                <div class="brand">
                    <span class="brand-badge">Emira'nın Tarif Defteri</span>
                    <h1>Lezzetli Tarifler</h1>
                    <p>Veri Tabanı Ödevi — ASP.NET & MSSQL</p>
                </div>
                <a href="Crud.aspx" class="btn btn-primary">Yönetim Paneli</a>
            </header>

            <div class="grid">
                <asp:Repeater ID="rptTarifler" runat="server">
                    <ItemTemplate>
                        <article class="card">
                            <div class="card-img-wrap">
                                <img src='<%# string.IsNullOrWhiteSpace(Eval("fotograf_url").ToString()) ? "https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=800&q=80" : Eval("fotograf_url") %>' alt="Yemek">
                                <span class="card-tag">Tarif</span>
                            </div>
                            <div class="card-body">
                                <h2><%# Eval("baslik") %></h2>
                                <p><%# KisaDetayGetir(Eval("detay").ToString()) %></p>
                                <a href='Detay.aspx?id=<%# Eval("id") %>' class="btn btn-detail">Tarifi Oku</a>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <footer class="site-footer">&copy; 2026 Emira — Veri Tabanı Ödev 4</footer>
        </div>
    </form>
</body>
</html>
