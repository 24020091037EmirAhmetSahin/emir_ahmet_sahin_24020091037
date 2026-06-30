import * as SQLite from 'expo-sqlite';
import { useCallback, useEffect, useState } from 'react';

import type { Note } from '@/types/note';

const DATABASE_NAME = 'EmiraNotes.db';

export function useNotesDatabase() {
  const [db, setDb] = useState<SQLite.SQLiteDatabase | null>(null);
  const [notes, setNotes] = useState<Note[]>([]);
  const [isReady, setIsReady] = useState(false);

  const loadNotes = useCallback(async (database: SQLite.SQLiteDatabase) => {
    const rows = await database.getAllAsync<Note>(
      'SELECT id, content FROM Notes ORDER BY id DESC',
    );
    setNotes(rows);
  }, []);

  useEffect(() => {
    let isMounted = true;

    async function setupDatabase() {
      const database = await SQLite.openDatabaseAsync(DATABASE_NAME);

      await database.execAsync(`
        CREATE TABLE IF NOT EXISTS Notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content TEXT NOT NULL
        );
      `);

      if (!isMounted) return;

      setDb(database);
      await loadNotes(database);
      setIsReady(true);
    }

    setupDatabase();

    return () => {
      isMounted = false;
    };
  }, [loadNotes]);

  const addNote = useCallback(
    async (content: string) => {
      if (!db) return;
      await db.runAsync('INSERT INTO Notes (content) VALUES (?)', content);
      await loadNotes(db);
    },
    [db, loadNotes],
  );

  const updateNote = useCallback(
    async (id: number, content: string) => {
      if (!db) return;
      await db.runAsync('UPDATE Notes SET content = ? WHERE id = ?', content, id);
      await loadNotes(db);
    },
    [db, loadNotes],
  );

  const deleteNote = useCallback(
    async (id: number) => {
      if (!db) return;
      await db.runAsync('DELETE FROM Notes WHERE id = ?', id);
      await loadNotes(db);
    },
    [db, loadNotes],
  );

  return {
    notes,
    isReady,
    addNote,
    updateNote,
    deleteNote,
  };
}
