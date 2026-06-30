import { useState, useEffect } from 'react';
import { SafeAreaView } from 'react-native-safe-area-context';
import {
  StyleSheet,
  Text,
  View,
  TextInput,
  TouchableOpacity,
  FlatList,
  KeyboardAvoidingView,
  Platform,
  Alert,
} from 'react-native';
import {
  collection,
  addDoc,
  onSnapshot,
  doc,
  updateDoc,
  deleteDoc,
  query,
  orderBy,
  serverTimestamp,
} from 'firebase/firestore';
import { db } from '../emiraFirebaseConfig';
import { AppPalette } from '@/constants/theme';

type Note = {
  id: string;
  message: string;
  createdAt?: { seconds: number };
};

export default function App() {
  const [notes, setNotes] = useState<Note[]>([]);
  const [inputText, setInputText] = useState('');
  const [editingId, setEditingId] = useState<string | null>(null);
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    const q = query(collection(db, 'messages'), orderBy('createdAt', 'desc'));

    const unsubscribe = onSnapshot(
      q,
      (querySnapshot) => {
        const messagesArray: Note[] = [];
        querySnapshot.forEach((snapshotDoc) => {
          messagesArray.push({ id: snapshotDoc.id, ...snapshotDoc.data() } as Note);
        });
        setNotes(messagesArray);
      },
      (error) => {
        console.error('Veri çekme hatası:', error);
      },
    );

    return () => unsubscribe();
  }, []);

  const handleSave = async () => {
    if (inputText.trim() === '' || isSaving) return;

    setIsSaving(true);
    try {
      if (editingId) {
        const noteRef = doc(db, 'messages', editingId);
        await updateDoc(noteRef, { message: inputText.trim() });
        setEditingId(null);
      } else {
        await addDoc(collection(db, 'messages'), {
          message: inputText.trim(),
          createdAt: serverTimestamp(),
        });
      }
      setInputText('');
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Bilinmeyen hata';
      Alert.alert('Hata', 'İşlem sırasında bir hata oluştu: ' + message);
    } finally {
      setIsSaving(false);
    }
  };

  const deleteNote = (id: string) => {
    Alert.alert('Notu Sil', 'Bu notu silmek istediğine emin misin?', [
      { text: 'Vazgeç', style: 'cancel' },
      {
        text: 'Sil',
        style: 'destructive',
        onPress: async () => {
          try {
            await deleteDoc(doc(db, 'messages', id));
          } catch (error) {
            const message = error instanceof Error ? error.message : 'Bilinmeyen hata';
            Alert.alert('Hata', 'Silme işlemi başarısız: ' + message);
          }
        },
      },
    ]);
  };

  const editNote = (item: Note) => {
    setInputText(item.message);
    setEditingId(item.id);
  };

  const cancelEdit = () => {
    setInputText('');
    setEditingId(null);
  };

  const formatDate = (item: Note) => {
    if (!item.createdAt?.seconds) return 'Az önce';
    return new Date(item.createdAt.seconds * 1000).toLocaleString('tr-TR', {
      day: '2-digit',
      month: 'short',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const renderItem = ({ item, index }: { item: Note; index: number }) => (
    <View style={[styles.card, index === 0 && styles.cardFirst]}>
      <View style={styles.cardAccent} />
      <View style={styles.cardBody}>
        <Text style={styles.messageText}>{item.message}</Text>
        <View style={styles.cardFooter}>
          <Text style={styles.dateText}>{formatDate(item)}</Text>
          <View style={styles.actionRow}>
            <TouchableOpacity onPress={() => editNote(item)} style={styles.editButton}>
              <Text style={styles.editButtonText}>Düzenle</Text>
            </TouchableOpacity>
            <TouchableOpacity onPress={() => deleteNote(item.id)} style={styles.deleteButton}>
              <Text style={styles.deleteButtonText}>Sil</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </View>
  );

  const renderEmpty = () => (
    <View style={styles.emptyState}>
      <Text style={styles.emptyIcon}>✨</Text>
      <Text style={styles.emptyTitle}>Henüz not yok</Text>
      <Text style={styles.emptySubtitle}>İlk notunu yaz ve Firebase'e anında kaydet</Text>
    </View>
  );

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        style={styles.keyboardView}>
        <View style={styles.header}>
          <View style={styles.headerGlow} />
          <Text style={styles.headerBadge}>EMIRA · VERİ TABANI ÖDEV 7</Text>
          <Text style={styles.headerTitle}>Not Defterim</Text>
          <Text style={styles.headerSubtitle}>Firebase Firestore ile gerçek zamanlı senkronizasyon</Text>
          <View style={styles.statsRow}>
            <View style={styles.statChip}>
              <Text style={styles.statValue}>{notes.length}</Text>
              <Text style={styles.statLabel}>Not</Text>
            </View>
            <View style={[styles.statChip, styles.statChipLive]}>
              <View style={styles.liveDot} />
              <Text style={styles.statLabelLive}>Canlı</Text>
            </View>
          </View>
        </View>

        <View style={styles.inputContainer}>
          {editingId && (
            <View style={styles.editBanner}>
              <Text style={styles.editBannerText}>Düzenleme modu</Text>
              <TouchableOpacity onPress={cancelEdit}>
                <Text style={styles.cancelText}>İptal</Text>
              </TouchableOpacity>
            </View>
          )}
          <TextInput
            style={styles.input}
            placeholder="Bugün aklına gelen bir şey yaz..."
            placeholderTextColor={AppPalette.textDim}
            value={inputText}
            onChangeText={setInputText}
            multiline
          />
          <TouchableOpacity
            style={[styles.saveButton, isSaving && styles.saveButtonDisabled]}
            onPress={handleSave}
            disabled={isSaving}>
            <Text style={styles.saveButtonText}>
              {isSaving ? 'Kaydediliyor...' : editingId ? 'Güncelle' : 'Not Ekle'}
            </Text>
          </TouchableOpacity>
        </View>

        <FlatList
          data={notes}
          keyExtractor={(item) => item.id}
          renderItem={renderItem}
          contentContainerStyle={styles.listContainer}
          showsVerticalScrollIndicator={false}
          ListEmptyComponent={renderEmpty}
        />
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: AppPalette.background,
  },
  keyboardView: {
    flex: 1,
  },
  header: {
    paddingHorizontal: 20,
    paddingTop: 12,
    paddingBottom: 20,
    backgroundColor: AppPalette.surface,
    borderBottomWidth: 1,
    borderBottomColor: AppPalette.border,
    overflow: 'hidden',
  },
  headerGlow: {
    position: 'absolute',
    top: -40,
    right: -30,
    width: 160,
    height: 160,
    borderRadius: 80,
    backgroundColor: AppPalette.primary,
    opacity: 0.15,
  },
  headerBadge: {
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 1.5,
    color: AppPalette.primaryLight,
    marginBottom: 8,
  },
  headerTitle: {
    fontSize: 32,
    fontWeight: '800',
    color: AppPalette.text,
    letterSpacing: -0.5,
  },
  headerSubtitle: {
    fontSize: 14,
    color: AppPalette.textMuted,
    marginTop: 6,
    lineHeight: 20,
  },
  statsRow: {
    flexDirection: 'row',
    gap: 10,
    marginTop: 16,
  },
  statChip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    backgroundColor: AppPalette.surfaceElevated,
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: AppPalette.border,
  },
  statChipLive: {
    backgroundColor: 'rgba(52, 211, 153, 0.1)',
    borderColor: 'rgba(52, 211, 153, 0.3)',
  },
  statValue: {
    fontSize: 16,
    fontWeight: '700',
    color: AppPalette.primaryLight,
  },
  statLabel: {
    fontSize: 13,
    color: AppPalette.textMuted,
  },
  liveDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: AppPalette.success,
  },
  statLabelLive: {
    fontSize: 13,
    fontWeight: '600',
    color: AppPalette.success,
  },
  inputContainer: {
    marginHorizontal: 20,
    marginTop: 16,
    marginBottom: 12,
    backgroundColor: AppPalette.surface,
    borderRadius: 20,
    padding: 16,
    borderWidth: 1,
    borderColor: AppPalette.border,
  },
  editBanner: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: 'rgba(139, 92, 246, 0.15)',
    borderRadius: 10,
    paddingHorizontal: 12,
    paddingVertical: 8,
    marginBottom: 12,
  },
  editBannerText: {
    color: AppPalette.primaryLight,
    fontSize: 13,
    fontWeight: '600',
  },
  cancelText: {
    color: AppPalette.accent,
    fontSize: 13,
    fontWeight: '600',
  },
  input: {
    color: AppPalette.text,
    fontSize: 16,
    minHeight: 72,
    textAlignVertical: 'top',
    marginBottom: 14,
    lineHeight: 24,
  },
  saveButton: {
    backgroundColor: AppPalette.primary,
    borderRadius: 14,
    paddingVertical: 14,
    alignItems: 'center',
  },
  saveButtonDisabled: {
    opacity: 0.6,
  },
  saveButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '700',
  },
  listContainer: {
    paddingHorizontal: 20,
    paddingBottom: 40,
    flexGrow: 1,
  },
  card: {
    flexDirection: 'row',
    backgroundColor: AppPalette.surface,
    borderRadius: 16,
    marginBottom: 12,
    borderWidth: 1,
    borderColor: AppPalette.border,
    overflow: 'hidden',
  },
  cardFirst: {
    borderColor: 'rgba(139, 92, 246, 0.4)',
  },
  cardAccent: {
    width: 4,
    backgroundColor: AppPalette.primary,
  },
  cardBody: {
    flex: 1,
    padding: 16,
  },
  messageText: {
    color: AppPalette.text,
    fontSize: 16,
    lineHeight: 24,
    marginBottom: 12,
  },
  cardFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  dateText: {
    color: AppPalette.textDim,
    fontSize: 12,
  },
  actionRow: {
    flexDirection: 'row',
    gap: 8,
  },
  editButton: {
    backgroundColor: AppPalette.surfaceElevated,
    paddingHorizontal: 14,
    paddingVertical: 7,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: AppPalette.border,
  },
  editButtonText: {
    color: AppPalette.textMuted,
    fontSize: 13,
    fontWeight: '600',
  },
  deleteButton: {
    backgroundColor: 'rgba(248, 113, 113, 0.15)',
    paddingHorizontal: 14,
    paddingVertical: 7,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: 'rgba(248, 113, 113, 0.3)',
  },
  deleteButtonText: {
    color: AppPalette.danger,
    fontSize: 13,
    fontWeight: '600',
  },
  emptyState: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 60,
    paddingHorizontal: 32,
  },
  emptyIcon: {
    fontSize: 48,
    marginBottom: 16,
  },
  emptyTitle: {
    fontSize: 20,
    fontWeight: '700',
    color: AppPalette.text,
    marginBottom: 8,
  },
  emptySubtitle: {
    fontSize: 14,
    color: AppPalette.textMuted,
    textAlign: 'center',
    lineHeight: 22,
  },
});
