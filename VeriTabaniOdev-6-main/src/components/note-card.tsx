import { Pressable, StyleSheet, Text, View } from 'react-native';

import { AppColors, Spacing } from '@/constants/theme';
import type { Note } from '@/types/note';

type NoteCardProps = {
  note: Note;
  onEdit: (note: Note) => void;
  onDelete: (id: number) => void;
};

export function NoteCard({ note, onEdit, onDelete }: NoteCardProps) {
  return (
    <View style={styles.card}>
      <View style={styles.accentBar} />
      <View style={styles.content}>
        <Text style={styles.noteText}>{note.content}</Text>
        <View style={styles.actions}>
          <Pressable
            style={({ pressed }) => [styles.editButton, pressed && styles.pressed]}
            onPress={() => onEdit(note)}>
            <Text style={styles.editText}>Düzenle</Text>
          </Pressable>
          <Pressable
            style={({ pressed }) => [styles.deleteButton, pressed && styles.pressed]}
            onPress={() => onDelete(note.id)}>
            <Text style={styles.deleteText}>Sil</Text>
          </Pressable>
        </View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  card: {
    flexDirection: 'row',
    backgroundColor: AppColors.surface,
    borderRadius: 16,
    marginBottom: Spacing.md,
    borderWidth: 1,
    borderColor: AppColors.border,
    overflow: 'hidden',
  },
  accentBar: {
    width: 4,
    backgroundColor: AppColors.accent,
  },
  content: {
    flex: 1,
    padding: Spacing.md,
  },
  noteText: {
    color: AppColors.text,
    fontSize: 16,
    lineHeight: 24,
    marginBottom: Spacing.md,
  },
  actions: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    gap: Spacing.sm,
  },
  editButton: {
    backgroundColor: AppColors.surfaceElevated,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: AppColors.border,
  },
  editText: {
    color: AppColors.accentLight,
    fontWeight: '600',
    fontSize: 14,
  },
  deleteButton: {
    backgroundColor: AppColors.dangerMuted,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: 10,
  },
  deleteText: {
    color: AppColors.danger,
    fontWeight: '600',
    fontSize: 14,
  },
  pressed: {
    opacity: 0.75,
  },
});
