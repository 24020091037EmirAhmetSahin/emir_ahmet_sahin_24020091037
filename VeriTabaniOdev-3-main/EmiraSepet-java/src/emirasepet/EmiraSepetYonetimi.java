package emirasepet;

import java.awt.*;
import java.sql.*;
import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;

/**
 * Emira Sepet Yönetim Paneli
 *
 * @author Emira
 */
public class EmiraSepetYonetimi extends JFrame {

    private static final Color BG = new Color(15, 23, 42);
    private static final Color CARD = new Color(30, 41, 59);
    private static final Color BORDER = new Color(51, 65, 85);
    private static final Color ACCENT = new Color(20, 184, 166);
    private static final Color ACCENT_HOVER = new Color(13, 148, 136);
    private static final Color DANGER = new Color(244, 63, 94);
    private static final Color DANGER_HOVER = new Color(225, 29, 72);
    private static final Color TEXT = new Color(241, 245, 249);
    private static final Color MUTED = new Color(148, 163, 184);
    private static final Color INPUT_BG = new Color(15, 23, 42);

    private int seciliSepetId = -1;

    private JTextField txtMusteriAdi, txtUrunAdi, txtFiyat;
    private JComboBox<String> cmbDurum;
    private JSpinner spnAdet;
    private JButton btnSepetEkle, btnUrunEkle, btnSepetSil, btnUrunSil;
    private JTable tblSepet, tblUrunler;
    private JLabel lblToplam, lblAltBaslik;

    public EmiraSepetYonetimi() {
        initComponents();
        sepetleriYukle();

        tblSepet.getSelectionModel().addListSelectionListener(e -> {
            if (!e.getValueIsAdjusting() && tblSepet.getSelectedRow() != -1) {
                seciliSepetId = (int) tblSepet.getValueAt(tblSepet.getSelectedRow(), 0);
                urunleriYukle(seciliSepetId);
            }
        });
    }

    private void sepetleriYukle() {
        DefaultTableModel model = (DefaultTableModel) tblSepet.getModel();
        model.setRowCount(0);
        String sql = "SELECT * FROM sepet ORDER BY id DESC";

        try (Connection conn = VeritabaniYoneticisi.baglantiAl();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getString("musteri_adi"),
                    rs.getString("durum").toUpperCase()
                });
            }
        } catch (SQLException e) {
            msg("Sepet yükleme hatası: " + e.getMessage());
        }
    }

    private void urunleriYukle(int sepetId) {
        DefaultTableModel model = (DefaultTableModel) tblUrunler.getModel();
        model.setRowCount(0);
        double toplam = 0;
        String sql = "SELECT * FROM sepet_urun WHERE sepet_id = ?";

        try (Connection conn = VeritabaniYoneticisi.baglantiAl();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, sepetId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                double araToplam = rs.getInt("adet") * rs.getDouble("fiyat");
                toplam += araToplam;
                model.addRow(new Object[]{
                    rs.getInt("id"),
                    rs.getString("urun_adi"),
                    rs.getInt("adet"),
                    String.format("%,.2f ₺", rs.getDouble("fiyat")),
                    String.format("%,.2f ₺", araToplam)
                });
            }
            lblToplam.setText(String.format("%,.2f ₺", toplam));
            lblAltBaslik.setText("Sepet #" + sepetId + " — ürün detayları");
        } catch (SQLException e) {
            msg("Ürün yükleme hatası: " + e.getMessage());
        }
    }

    private void sepetEkle() {
        if (txtMusteriAdi.getText().trim().isEmpty()) {
            msg("Lütfen müşteri adı giriniz!");
            return;
        }
        String sql = "INSERT INTO sepet (musteri_adi, durum) VALUES (?, ?)";
        try (Connection conn = VeritabaniYoneticisi.baglantiAl();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, txtMusteriAdi.getText().trim());
            pstmt.setString(2, cmbDurum.getSelectedItem().toString().toLowerCase());
            pstmt.executeUpdate();
            txtMusteriAdi.setText("");
            sepetleriYukle();
        } catch (SQLException e) {
            msg(e.getMessage());
        }
    }

    private void urunEkle() {
        if (seciliSepetId == -1) {
            msg("Lütfen listeden ürün eklemek istediğiniz sepeti seçin!");
            return;
        }
        if (txtUrunAdi.getText().trim().isEmpty() || txtFiyat.getText().trim().isEmpty()) {
            msg("Lütfen ürün adını ve fiyatını eksiksiz girin!");
            return;
        }
        String sql = "INSERT INTO sepet_urun (sepet_id, urun_adi, adet, fiyat) VALUES (?, ?, ?, ?)";
        try (Connection conn = VeritabaniYoneticisi.baglantiAl();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, seciliSepetId);
            pstmt.setString(2, txtUrunAdi.getText().trim());
            pstmt.setInt(3, (int) spnAdet.getValue());
            pstmt.setDouble(4, Double.parseDouble(txtFiyat.getText().replace(",", ".").trim()));
            pstmt.executeUpdate();
            txtUrunAdi.setText("");
            txtFiyat.setText("");
            spnAdet.setValue(1);
            urunleriYukle(seciliSepetId);
        } catch (NumberFormatException ex) {
            msg("Lütfen fiyata sadece rakam giriniz! (Örn: 15.50)");
        } catch (Exception e) {
            msg("Giriş hatası: " + e.getMessage());
        }
    }

    private void silSecili(String tablo, JTable tabloObj) {
        int row = tabloObj.getSelectedRow();
        if (row == -1) {
            msg("Lütfen silmek için listeden bir satır seçin!");
            return;
        }
        int id = (int) tabloObj.getValueAt(row, 0);
        int onay = JOptionPane.showConfirmDialog(this,
                "Bu kaydı kalıcı olarak silmek istediğinize emin misiniz?",
                "Kayıt Silme", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
        if (onay != JOptionPane.YES_OPTION) {
            return;
        }

        try (Connection conn = VeritabaniYoneticisi.baglantiAl();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM " + tablo + " WHERE id = ?")) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            if ("sepet".equals(tablo)) {
                seciliSepetId = -1;
                sepetleriYukle();
                ((DefaultTableModel) tblUrunler.getModel()).setRowCount(0);
                lblToplam.setText("0,00 ₺");
                lblAltBaslik.setText("Sepet seçin — ürün detayları burada görünür");
            } else {
                urunleriYukle(seciliSepetId);
            }
        } catch (SQLException e) {
            msg(e.getMessage());
        }
    }

    private void msg(String s) {
        JOptionPane.showMessageDialog(this, s, "Emira Sepet", JOptionPane.INFORMATION_MESSAGE);
    }

    private JButton olusturButon(String text, Color bg, Color hover) {
        JButton btn = new JButton(text);
        btn.setFont(new Font("Segoe UI", Font.BOLD, 13));
        btn.setForeground(Color.WHITE);
        btn.setBackground(bg);
        btn.setFocusPainted(false);
        btn.setBorder(new EmptyBorder(10, 18, 10, 18));
        btn.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
        btn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent e) { btn.setBackground(hover); }
            public void mouseExited(java.awt.event.MouseEvent e) { btn.setBackground(bg); }
        });
        return btn;
    }

    private void stilTablo(JTable tablo) {
        tablo.setRowHeight(34);
        tablo.setFont(new Font("Segoe UI", Font.PLAIN, 13));
        tablo.setBackground(CARD);
        tablo.setForeground(TEXT);
        tablo.setGridColor(BORDER);
        tablo.setSelectionBackground(ACCENT);
        tablo.setSelectionForeground(Color.WHITE);
        tablo.setShowVerticalLines(false);

        JTableHeader header = tablo.getTableHeader();
        header.setFont(new Font("Segoe UI", Font.BOLD, 12));
        header.setBackground(INPUT_BG);
        header.setForeground(MUTED);
        header.setBorder(new LineBorder(BORDER));
        header.setReorderingAllowed(false);
    }

    private JTextField olusturInput() {
        JTextField field = new JTextField();
        field.setFont(new Font("Segoe UI", Font.PLAIN, 14));
        field.setBackground(INPUT_BG);
        field.setForeground(TEXT);
        field.setCaretColor(TEXT);
        field.setBorder(BorderFactory.createCompoundBorder(
                new LineBorder(BORDER, 1, true),
                new EmptyBorder(8, 12, 8, 12)));
        return field;
    }

    private JLabel olusturEtiket(String text) {
        JLabel lbl = new JLabel(text);
        lbl.setFont(new Font("Segoe UI", Font.BOLD, 13));
        lbl.setForeground(MUTED);
        return lbl;
    }

    private JPanel olusturKart(String baslik) {
        JPanel panel = new JPanel(null);
        panel.setBackground(CARD);
        panel.setBorder(BorderFactory.createCompoundBorder(
                new LineBorder(BORDER, 1, true),
                new EmptyBorder(18, 18, 18, 18)));

        JLabel lbl = new JLabel(baslik);
        lbl.setFont(new Font("Segoe UI", Font.BOLD, 16));
        lbl.setForeground(TEXT);
        lbl.setBounds(18, 12, 400, 28);
        panel.add(lbl);
        return panel;
    }

    private void initComponents() {
        setTitle("Emira Sepet Yönetimi | Java");
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        getContentPane().setBackground(BG);
        getContentPane().setLayout(null);

        JPanel header = new JPanel(null);
        header.setBackground(new Color(13, 148, 136));
        header.setBounds(0, 0, 900, 72);

        JLabel lblBaslik = new JLabel("Emira Sepet Yönetimi | Java");
        lblBaslik.setFont(new Font("Segoe UI", Font.BOLD, 24));
        lblBaslik.setForeground(Color.WHITE);
        lblBaslik.setBounds(24, 12, 400, 34);

        JLabel lblAciklama = new JLabel("Java · Veritabanı Yönetim Sistemleri · Emira");
        lblAciklama.setFont(new Font("Segoe UI", Font.PLAIN, 13));
        lblAciklama.setForeground(new Color(204, 251, 241));
        lblAciklama.setBounds(26, 44, 400, 20);

        header.add(lblBaslik);
        header.add(lblAciklama);
        getContentPane().add(header);

        JPanel pnlSepet = olusturKart("Sepet İşlemleri");
        pnlSepet.setBounds(24, 92, 852, 270);

        JLabel lblMusteri = olusturEtiket("Müşteri Adı");
        lblMusteri.setBounds(18, 52, 100, 24);
        txtMusteriAdi = olusturInput();
        txtMusteriAdi.setBounds(18, 78, 210, 38);

        JLabel lblDurum = olusturEtiket("Durum");
        lblDurum.setBounds(246, 52, 60, 24);
        cmbDurum = new JComboBox<>(new String[]{"aktif", "tamamlandi", "iptal"});
        cmbDurum.setFont(new Font("Segoe UI", Font.PLAIN, 14));
        cmbDurum.setBackground(INPUT_BG);
        cmbDurum.setForeground(TEXT);
        cmbDurum.setBounds(246, 78, 140, 38);

        btnSepetEkle = olusturButon("Sepet Oluştur", ACCENT, ACCENT_HOVER);
        btnSepetEkle.setBounds(406, 78, 150, 38);
        btnSepetSil = olusturButon("Sepeti Sil", DANGER, DANGER_HOVER);
        btnSepetSil.setBounds(568, 78, 130, 38);

        tblSepet = new JTable();
        tblSepet.setModel(new DefaultTableModel(new Object[][]{}, new String[]{"Sepet ID", "Müşteri", "Durum"}) {
            @Override
            public boolean isCellEditable(int row, int column) { return false; }
        });
        stilTablo(tblSepet);
        JScrollPane scrollSepet = new JScrollPane(tblSepet);
        scrollSepet.setBorder(new LineBorder(BORDER));
        scrollSepet.getViewport().setBackground(CARD);
        scrollSepet.setBounds(18, 130, 816, 120);

        pnlSepet.add(lblMusteri);
        pnlSepet.add(txtMusteriAdi);
        pnlSepet.add(lblDurum);
        pnlSepet.add(cmbDurum);
        pnlSepet.add(btnSepetEkle);
        pnlSepet.add(btnSepetSil);
        pnlSepet.add(scrollSepet);
        getContentPane().add(pnlSepet);

        JPanel pnlUrun = olusturKart("Ürün Yönetimi");
        pnlUrun.setBounds(24, 378, 852, 340);

        lblAltBaslik = new JLabel("Sepet seçin — ürün detayları burada görünür");
        lblAltBaslik.setFont(new Font("Segoe UI", Font.PLAIN, 12));
        lblAltBaslik.setForeground(MUTED);
        lblAltBaslik.setBounds(18, 40, 500, 20);
        pnlUrun.add(lblAltBaslik);

        JLabel lblUrun = olusturEtiket("Ürün Adı");
        lblUrun.setBounds(18, 68, 80, 24);
        txtUrunAdi = olusturInput();
        txtUrunAdi.setBounds(18, 94, 180, 38);

        JLabel lblAdet = olusturEtiket("Adet");
        lblAdet.setBounds(214, 68, 50, 24);
        spnAdet = new JSpinner(new SpinnerNumberModel(1, 1, 100, 1));
        spnAdet.setFont(new Font("Segoe UI", Font.PLAIN, 14));
        spnAdet.setBounds(214, 94, 70, 38);

        JLabel lblFiyat = olusturEtiket("Birim Fiyat");
        lblFiyat.setBounds(300, 68, 90, 24);
        txtFiyat = olusturInput();
        txtFiyat.setBounds(300, 94, 110, 38);

        btnUrunEkle = olusturButon("Ürün Ekle", ACCENT, ACCENT_HOVER);
        btnUrunEkle.setBounds(428, 94, 120, 38);
        btnUrunSil = olusturButon("Ürün Sil", DANGER, DANGER_HOVER);
        btnUrunSil.setBounds(558, 94, 110, 38);

        tblUrunler = new JTable();
        tblUrunler.setModel(new DefaultTableModel(new Object[][]{}, new String[]{"ID", "Ürün", "Adet", "Fiyat", "Ara Toplam"}) {
            @Override
            public boolean isCellEditable(int row, int column) { return false; }
        });
        stilTablo(tblUrunler);
        JScrollPane scrollUrun = new JScrollPane(tblUrunler);
        scrollUrun.setBorder(new LineBorder(BORDER));
        scrollUrun.getViewport().setBackground(CARD);
        scrollUrun.setBounds(18, 148, 816, 140);

        JLabel lblToplamBaslik = new JLabel("Genel Toplam");
        lblToplamBaslik.setFont(new Font("Segoe UI", Font.BOLD, 14));
        lblToplamBaslik.setForeground(MUTED);
        lblToplamBaslik.setBounds(18, 300, 120, 24);

        lblToplam = new JLabel("0,00 ₺");
        lblToplam.setFont(new Font("Segoe UI", Font.BOLD, 28));
        lblToplam.setForeground(ACCENT);
        lblToplam.setHorizontalAlignment(SwingConstants.RIGHT);
        lblToplam.setBounds(500, 292, 334, 36);

        pnlUrun.add(lblUrun);
        pnlUrun.add(txtUrunAdi);
        pnlUrun.add(lblAdet);
        pnlUrun.add(spnAdet);
        pnlUrun.add(lblFiyat);
        pnlUrun.add(txtFiyat);
        pnlUrun.add(btnUrunEkle);
        pnlUrun.add(btnUrunSil);
        pnlUrun.add(scrollUrun);
        pnlUrun.add(lblToplamBaslik);
        pnlUrun.add(lblToplam);
        getContentPane().add(pnlUrun);

        setSize(900, 760);
        setLocationRelativeTo(null);
        setResizable(false);

        btnSepetEkle.addActionListener(e -> sepetEkle());
        btnUrunEkle.addActionListener(e -> urunEkle());
        btnSepetSil.addActionListener(e -> silSecili("sepet", tblSepet));
        btnUrunSil.addActionListener(e -> silSecili("sepet_urun", tblUrunler));
    }
}
