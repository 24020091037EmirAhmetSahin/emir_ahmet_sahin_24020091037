<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Crud.aspx.cs" Inherits="YemekTarif.Crud" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetim Paneli | Emira Mutfak</title>
    <link rel="stylesheet" href="assets/emira-stil.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <header class="site-header">
                <div class="brand">
                    <span class="brand-badge">CRUD İşlemleri</span>
                    <h1>Tarif Yönetimi</h1>
                    <p>Ekle · Güncelle · Sil · Listele</p>
                </div>
                <a href="Default.aspx" class="btn btn-ghost">&larr; Ana Sayfa</a>
            </header>

            <div class="admin-layout">
            <div class="panel">
                <h2>Yeni Tarif Ekle</h2>
                <asp:TextBox ID="txtBaslik" runat="server" placeholder="Yemek Adı" required="true"></asp:TextBox>
                <asp:TextBox ID="txtFotoUrl" runat="server" placeholder="Fotoğraf URL"></asp:TextBox>
                <asp:TextBox ID="txtDetay" runat="server" TextMode="MultiLine" Rows="6" placeholder="Tarif Detayları" required="true"></asp:TextBox>
                <asp:Button ID="btnEkle" runat="server" Text="Tarifi Kaydet" CssClass="btn-submit" OnClick="btnEkle_Click" />
            </div>

            <!-- KAYITLI TARİFLER PANeli -->
            <div class="panel">
                <h2>Kayıtlı Tarifler</h2>
                <div style="overflow-x:auto;">
                    <table>
                        <tr>
                            <th width="5%">ID</th>
                            <th width="65%">Yemek Başlığı</th>
                            <th width="30%">İşlemler</th>
                        </tr>
                        <asp:Repeater ID="rptTarifler" runat="server" OnItemCommand="rptTarifler_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><strong>#<%# Eval("id") %></strong></td>
                                    <td><%# Eval("baslik") %></td>
                                    <td class="action-links">
                                        <button type="button" class="btn-edit" 
                                            data-id='<%# Eval("id") %>' 
                                            data-baslik='<%# Eval("baslik") %>' 
                                            data-foto='<%# Eval("fotograf_url") %>' 
                                            data-detay='<%# Eval("detay") %>' 
                                            onclick="openModal(this)">Düzenle</button>
                                        
                                        <asp:LinkButton ID="btnSil" runat="server" CssClass="btn-delete btn-action" CommandName="Sil" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Silmek istediğine emin misin?');">Sil</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
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
                <asp:HiddenField ID="hdnModalId" runat="server" ClientIDMode="Static" />
                <asp:TextBox ID="txtModalBaslik" runat="server" ClientIDMode="Static" required="true"></asp:TextBox>
                <asp:TextBox ID="txtModalFoto" runat="server" ClientIDMode="Static"></asp:TextBox>
                <asp:TextBox ID="txtModalDetay" runat="server" TextMode="MultiLine" Rows="6" ClientIDMode="Static" required="true"></asp:TextBox>
                <asp:Button ID="btnGuncelle" runat="server" Text="Değişiklikleri Kaydet" CssClass="btn-submit" Style="background: #3498db;" OnClick="btnGuncelle_Click" />
            </div>
        </div>
    </form>

    <script>
        function openModal(button) {
            document.getElementById('hdnModalId').value = button.getAttribute('data-id');
            document.getElementById('txtModalBaslik').value = button.getAttribute('data-baslik');
            document.getElementById('txtModalFoto').value = button.getAttribute('data-foto');
            document.getElementById('txtModalDetay').value = button.getAttribute('data-detay');

            document.getElementById('editModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        window.onclick = function (event) {
            var modal = document.getElementById('editModal');
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>