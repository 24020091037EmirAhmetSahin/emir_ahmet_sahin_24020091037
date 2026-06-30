import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import {
  ActivityIndicator,
  Alert,
  FlatList,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { NoteCard } from '@/components/note-card';
import { AppColors, Spacing } from '@/constants/theme';
import { useNotesDatabase } from '@/hooks/use-notes-database';
import type { Note } from '@/types/note';

export default function NotesScreen() {
  const insets = useSafeAreaInsets();
  const { notes, isReady, addNote, updateNote, deleteNote } = useNotesDatabase();
  const [content, setContent] = useState('');
  const [editingId, setEditingId] = useState<number | null>(null);

  const handleSave = async () => {
    const trimmed = content.trim();
    if (!trimmed) {
      Alert.alert('Uyarı', 'Lütfen bir not girin.');
      return;
    }

    if (editingId !== null) {
      await updateNote(editingId, trimmed);
      setEditingId(null);
    } else {
      await addNote(trimmed);
    }

    setContent('');
  };

  const handleEdit = (note: Note) => {
    setEditingId(note.id);
    setContent(note.content);
  };

  const handleDelete = (id: number) => {
    Alert.alert('Notu Sil', 'Bu not kalıcı olarak silinsin mi?', [
      { text: 'Vazgeç', style: 'cancel' },
      {
        text: 'Sil',
        style: 'destructive',
        onPress: () => deleteNote(id),
      },
    ]);
  };

  const handleCancelEdit = () => {
    setEditingId(null);
    setContent('');
  };

  if (!isReady) {
    return (
      <View style={[styles.loading, { paddingTop: insets.top }]}>
        <ActivityIndicator size="large" color={AppColors.accent} />
        <Text style={styles.loadingText}>Notlar yükleniyor...</Text>
      </View>
    );
  }

  return (
    <KeyboardAvoidingView
      style={[styles.container, { paddingTop: insets.top }]}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
      <StatusBar style="light" />

      <View style={styles.header}>
        <Text style={styles.badge}>Emira · VeriTabaniOdev-6</Text>
        <Text style={styles.title}>Günün Notu</Text>
        <Text style={styles.subtitle}>
          {notes.length === 0
            ? 'İlk notunu yazarak başla'
            : `${notes.length} not kayıtlı`}
        </Text>
      </View>

      <View style={styles.formCard}>
        <Text style={styles.formLabel}>
          {editingId !== null ? 'Notu Düzenle' : 'Yeni Not'}
        </Text>
        <TextInput
          style={styles.input}
          placeholder="Bugün aklında ne var?"
          placeholderTextColor={AppColors.textMuted}
          value={content}
          onChangeText={setContent}
          multiline
          textAlignVertical="top"
        />
        <View style={styles.formActions}>
          {editingId !== null && (
            <Pressable
              style={({ pressed }) => [styles.cancelButton, pressed && styles.pressed]}
              onPress={handleCancelEdit}>
              <Text style={styles.cancelText}>İptal</Text>
            </Pressable>
          )}
          <Pressable
            style={({ pressed }) => [styles.saveButton, pressed && styles.pressed]}
            onPress={handleSave}>
            <Text style={styles.saveText}>
              {editingId !== null ? 'Güncelle' : 'Kaydet'}
            </Text>
          </Pressable>
        </View>
      </View>

      <FlatList
        data={notes}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <NoteCard note={item} onEdit={handleEdit} onDelete={handleDelete} />
        )}
        contentContainerStyle={[
          styles.list,
          { paddingBottom: insets.bottom + Spacing.lg },
          notes.length === 0 && styles.emptyList,
        ]}
        ListEmptyComponent={
          <View style={styles.emptyState}>
            <Text style={styles.emptyEmoji}>📝</Text>
            <Text style={styles.emptyTitle}>Henüz not yok</Text>
            <Text style={styles.emptyText}>
              Yukarıdaki alana yazıp Kaydet&apos;e basarak ilk notunu oluştur.
            </Text>
          </View>
        }
        showsVerticalScrollIndicator={false}
      />
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: AppColors.background,
  },
  loading: {
    flex: 1,
    backgroundColor: AppColors.background,
    alignItems: 'center',
    justifyContent: 'center',
    gap: Spacing.md,
  },
  loadingText: {
    color: AppColors.textMuted,
    fontSize: 16,
  },
  header: {
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.md,
    paddingBottom: Spacing.lg,
  },
  badge: {
    alignSelf: 'flex-start',
    backgroundColor: AppColors.surfaceElevated,
    color: AppColors.accentLight,
    fontSize: 12,
    fontWeight: '600',
    paddingHorizontal: Spacing.sm + 4,
    paddingVertical: Spacing.xs + 2,
    borderRadius: 999,
    marginBottom: Spacing.sm,
    overflow: 'hidden',
  },
  title: {
    fontSize: 32,
    fontWeight: '700',
    color: AppColors.text,
    letterSpacing: -0.5,
  },
  subtitle: {
    marginTop: Spacing.xs,
    fontSize: 15,
    color: AppColors.textMuted,
  },
  formCard: {
    marginHorizontal: Spacing.lg,
    marginBottom: Spacing.lg,
    backgroundColor: AppColors.surface,
    borderRadius: 20,
    padding: Spacing.md,
    borderWidth: 1,
    borderColor: AppColors.border,
  },
  formLabel: {
    color: AppColors.textMuted,
    fontSize: 13,
    fontWeight: '600',
    textTransform: 'uppercase',
    letterSpacing: 0.8,
    marginBottom: Spacing.sm,
  },
  input: {
    minHeight: 110,
    backgroundColor: AppColors.inputBg,
    borderRadius: 14,
    padding: Spacing.md,
    color: AppColors.text,
    fontSize: 16,
    lineHeight: 24,
    borderWidth: 1,
    borderColor: AppColors.border,
  },
  formActions: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    gap: Spacing.sm,
    marginTop: Spacing.md,
  },
  saveButton: {
    backgroundColor: AppColors.accent,
    paddingVertical: Spacing.sm + 4,
    paddingHorizontal: Spacing.lg,
    borderRadius: 12,
  },
  saveText: {
    color: '#FFFFFF',
    fontWeight: '700',
    fontSize: 15,
  },
  cancelButton: {
    paddingVertical: Spacing.sm + 4,
    paddingHorizontal: Spacing.lg,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: AppColors.border,
  },
  cancelText: {
    color: AppColors.textMuted,
    fontWeight: '600',
    fontSize: 15,
  },
  list: {
    paddingHorizontal: Spacing.lg,
  },
  emptyList: {
    flexGrow: 1,
  },
  emptyState: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: Spacing.xl,
    paddingHorizontal: Spacing.lg,
  },
  emptyEmoji: {
    fontSize: 48,
    marginBottom: Spacing.md,
  },
  emptyTitle: {
    color: AppColors.text,
    fontSize: 20,
    fontWeight: '700',
    marginBottom: Spacing.sm,
  },
  emptyText: {
    color: AppColors.textMuted,
    fontSize: 15,
    textAlign: 'center',
    lineHeight: 22,
  },
  pressed: {
    opacity: 0.85,
  },
});
