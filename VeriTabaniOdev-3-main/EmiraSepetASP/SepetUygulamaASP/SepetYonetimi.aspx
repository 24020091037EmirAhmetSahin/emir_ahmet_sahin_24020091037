<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SepetYonetimi.aspx.cs" Inherits="SepetUygulamaASP.SepetYonetimi" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="UTF-8">
    <title>Emira Sepet Yönetimi | ASP.NET</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #f0f2f5; margin: 0; padding: 40px; color: #333; }
        .container { display: flex; gap: 30px; max-width: 1200px; margin: auto; }
        .panel { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); flex: 1; }
        h2 { border-bottom: 2px solid #4f46e5; padding-bottom: 12px; font-size: 1.4rem; color: #1e293b; margin-top: 0; }
        .form-group { background: #f8fafc; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #e2e8f0; display: flex; gap: 10px; }
        input[type="text"], select { padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; outline: none; transition: 0.3s; }
        input[type="text"]:focus { border-color: #4f46e5; box-shadow: 0 0 0 2px rgba(79, 70, 229, 0.1); }
        .btn { padding: 10px 20px; background: #4f46e5; color: white; border: none; cursor: pointer; border-radius: 6px; font-weight: 600; transition: 0.3s; }
        .btn:hover { background: #4338ca; }
        .btn-success { background: #10b981; }
        .btn-success:hover { background: #059669; }
        .grid-view { width: 100%; border-collapse: collapse; margin-top: 10px; border-radius: 8px; overflow: hidden; }
        .grid-view th { background: #f1f5f9; color: #64748b; padding: 12px; text-align: left; font-size: 0.85rem; text-transform: uppercase; }
        .grid-view td { padding: 12px; border-bottom: 1px solid #f1f5f9; font-size: 0.95rem; }
        .grid-view tr:hover { background: #f8fafc; }
        .total-label { display: block; text-align: right; margin-top: 20px; font-size: 1.3rem; font-weight: bold; color: #10b981; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="text-align:center;font-family:'Segoe UI',sans-serif;color:#0f766e;margin-bottom:24px;">Emira Sepet Yönetimi | ASP.NET</h1>
        <div class="container">
            <div class="panel">
                <h2>🛍️ Mevcut Sepetler</h2>
                <div class="form-group">
                    <asp:TextBox ID="txtMusteriAdi" runat="server" placeholder="Müşteri Adı" CssClass="input-text"></asp:TextBox>
                    <asp:DropDownList ID="ddlDurum" runat="server">
                        <asp:ListItem Text="Aktif" Value="aktif"></asp:ListItem>
                        <asp:ListItem Text="Tamamlandı" Value="tamamlandi"></asp:ListItem>
                        <asp:ListItem Text="İptal" Value="iptal"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnSepetEkle" runat="server" Text="Oluştur" CssClass="btn" OnClick="btnSepetEkle_Click" />
                </div> 

                <asp:GridView ID="gvSepetler" runat="server" AutoGenerateColumns="False" DataKeyNames="id" 
                    OnSelectedIndexChanged="gvSepetler_SelectedIndexChanged" OnRowDeleting="gvSepetler_RowDeleting" 
                    CssClass="grid-view" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="ID" ItemStyle-Width="40px" />
                        <asp:BoundField DataField="musteri_adi" HeaderText="Müşteri" />
                        <asp:TemplateField HeaderText="Durum">
                            <ItemTemplate>
                                <strong><%# Eval("durum").ToString().ToUpper() %></strong>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowSelectButton="True" SelectText="Detayları Gör" ControlStyle-ForeColor="#4f46e5" />
                        <asp:CommandField ShowDeleteButton="True" DeleteText="Kaldır" ControlStyle-ForeColor="#ef4444" />
                    </Columns>
                </asp:GridView>
            </div>

            <asp:Panel ID="pnlUrunler" runat="server" CssClass="panel" Visible="false">
                <h2>🛒 Sepet #<asp:Label ID="lblSeciliSepetId" runat="server"></asp:Label> Detayı</h2>
                <div class="form-group">
                    <asp:TextBox ID="txtUrunAdi" runat="server" placeholder="Ürün Adı"></asp:TextBox>
                    <asp:TextBox ID="txtAdet" runat="server" Text="1" Width="40px" type="number"></asp:TextBox>
                    <asp:TextBox ID="txtFiyat" runat="server" placeholder="Fiyat (₺)" Width="80px"></asp:TextBox>
                    <asp:Button ID="btnUrunEkle" runat="server" Text="Sepete At" CssClass="btn btn-success" OnClick="btnUrunEkle_Click" />
                </div>

                <asp:GridView ID="gvUrunler" runat="server" AutoGenerateColumns="False" DataKeyNames="id" 
                    OnRowDeleting="gvUrunler_RowDeleting" CssClass="grid-view" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="urun_adi" HeaderText="Ürün" />
                        <asp:BoundField DataField="adet" HeaderText="Adet" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="fiyat" HeaderText="Birim Fiyat" DataFormatString="{0:N2} ₺" />
                        <asp:TemplateField HeaderText="Ara Toplam">
                            <ItemTemplate>
                                <%# String.Format("{0:N2} ₺", Convert.ToDouble(Eval("adet")) * Convert.ToDouble(Eval("fiyat"))) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" DeleteText="✖" ControlStyle-ForeColor="#ef4444" />
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblGenelToplam" runat="server" CssClass="total-label" Text="Toplam: 0.00 ₺"></asp:Label>
            </asp:Panel>
        </div>
    </form>
</body>
</html>