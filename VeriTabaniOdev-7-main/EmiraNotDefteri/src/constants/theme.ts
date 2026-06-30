import '@/global.css';

import { Platform } from 'react-native';

export const AppPalette = {
  background: '#0B1120',
  surface: '#151D2E',
  surfaceElevated: '#1C2640',
  border: '#2A3655',
  primary: '#8B5CF6',
  primaryLight: '#A78BFA',
  accent: '#F472B6',
  success: '#34D399',
  danger: '#F87171',
  warning: '#FBBF24',
  text: '#F1F5F9',
  textMuted: '#94A3B8',
  textDim: '#64748B',
  inputBg: '#111827',
  headerGradientStart: '#4C1D95',
  headerGradientEnd: '#831843',
} as const;

export const Colors = {
  light: {
    text: '#0F172A',
    background: '#F8FAFC',
    backgroundElement: '#E2E8F0',
    backgroundSelected: '#CBD5E1',
    textSecondary: '#64748B',
  },
  dark: {
    text: AppPalette.text,
    background: AppPalette.background,
    backgroundElement: AppPalette.surface,
    backgroundSelected: AppPalette.surfaceElevated,
    textSecondary: AppPalette.textMuted,
  },
} as const;

export type ThemeColor = keyof typeof Colors.light & keyof typeof Colors.dark;

export const Fonts = Platform.select({
  ios: {
    sans: 'system-ui',
    serif: 'ui-serif',
    rounded: 'ui-rounded',
    mono: 'ui-monospace',
  },
  default: {
    sans: 'normal',
    serif: 'serif',
    rounded: 'normal',
    mono: 'monospace',
  },
  web: {
    sans: 'var(--font-display)',
    serif: 'var(--font-serif)',
    rounded: 'var(--font-rounded)',
    mono: 'var(--font-mono)',
  },
});

export const Spacing = {
  half: 2,
  one: 4,
  two: 8,
  three: 16,
  four: 24,
  five: 32,
  six: 64,
} as const;

export const BottomTabInset = Platform.select({ ios: 50, android: 80 }) ?? 0;
export const MaxContentWidth = 800;
