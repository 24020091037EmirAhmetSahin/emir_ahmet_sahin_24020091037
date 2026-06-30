package emirasepet;

/**
 * Sepet Yönetim Sistemi - Ana giriş noktası
 *
 * @author Emira
 */
public class EmiraSepetUygulamasi {

    public static void main(String[] args) {
        VeritabaniYoneticisi.baslat();
        java.awt.EventQueue.invokeLater(() -> new EmiraSepetYonetimi().setVisible(true));
    }
}
