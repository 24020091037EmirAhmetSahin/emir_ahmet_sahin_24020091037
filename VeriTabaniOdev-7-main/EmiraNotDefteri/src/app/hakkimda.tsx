import { ScrollView, StyleSheet, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AppPalette } from '@/constants/theme';

const INFO_ROWS = [
  { label: 'Geliştirici', value: 'Emira' },
  { label: 'Ders', value: 'Veri Tabanları' },
  { label: 'Ödev', value: 'Ödev 7 — Firebase Firestore' },
  { label: 'Platform', value: 'React Native (Expo)' },
  { label: 'Veritabanı', value: 'Firebase Firestore (NoSQL)' },
];

const FEATURES = [
  'Gerçek zamanlı veri senkronizasyonu (onSnapshot)',
  'Tam CRUD: ekleme, okuma, güncelleme, silme',
  'Çapraz platform: Android, iOS ve Web',
  'Modern mor-pembe temalı arayüz',
];

export default function HakkimdaScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <ScrollView contentContainerStyle={styles.scrollContent} showsVerticalScrollIndicator={false}>
        <View style={styles.hero}>
          <Text style={styles.avatar}>👩‍💻</Text>
          <Text style={styles.name}>Emira</Text>
          <Text style={styles.tagline}>Mobil Not Defteri · Firebase Ödevi</Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Proje Bilgileri</Text>
          {INFO_ROWS.map((row) => (
            <View key={row.label} style={styles.infoRow}>
              <Text style={styles.infoLabel}>{row.label}</Text>
              <Text style={styles.infoValue}>{row.value}</Text>
            </View>
          ))}
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Özellikler</Text>
          {FEATURES.map((feature) => (
            <View key={feature} style={styles.featureRow}>
              <View style={styles.featureDot} />
              <Text style={styles.featureText}>{feature}</Text>
            </View>
          ))}
        </View>

        <View style={styles.footer}>
          <Text style={styles.footerText}>© 2026 Emira · Veri Tabanı Ödev 7</Text>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: AppPalette.background,
  },
  scrollContent: {
    padding: 20,
    paddingBottom: 40,
  },
  hero: {
    alignItems: 'center',
    paddingVertical: 32,
    marginBottom: 8,
  },
  avatar: {
    fontSize: 64,
    marginBottom: 12,
  },
  name: {
    fontSize: 32,
    fontWeight: '800',
    color: AppPalette.text,
    letterSpacing: -0.5,
  },
  tagline: {
    fontSize: 15,
    color: AppPalette.textMuted,
    marginTop: 6,
  },
  section: {
    backgroundColor: AppPalette.surface,
    borderRadius: 20,
    padding: 20,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: AppPalette.border,
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: '700',
    letterSpacing: 1,
    color: AppPalette.primaryLight,
    marginBottom: 16,
    textTransform: 'uppercase',
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: AppPalette.border,
  },
  infoLabel: {
    fontSize: 14,
    color: AppPalette.textMuted,
  },
  infoValue: {
    fontSize: 14,
    fontWeight: '600',
    color: AppPalette.text,
    textAlign: 'right',
    flex: 1,
    marginLeft: 16,
  },
  featureRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: 12,
    paddingVertical: 8,
  },
  featureDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: AppPalette.accent,
    marginTop: 6,
  },
  featureText: {
    flex: 1,
    fontSize: 15,
    color: AppPalette.text,
    lineHeight: 22,
  },
  footer: {
    alignItems: 'center',
    paddingTop: 16,
  },
  footerText: {
    fontSize: 12,
    color: AppPalette.textDim,
  },
});
