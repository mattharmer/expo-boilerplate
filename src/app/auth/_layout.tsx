import { Stack } from 'expo-router';
import { useTheme } from '@react-navigation/native';
import type { Theme } from '@react-navigation/native';

export default function AuthLayout() {
  const theme = useTheme();
  
  return {
    backgroundColor: theme.colors.background,
    headerTintColor: theme.colors.text,
    headerTitleStyle: {
      color: theme.colors.text,
    }
  };
} 