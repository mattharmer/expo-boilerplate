import { Stack } from 'expo-router';
import { useFonts } from 'expo-font';
import { useEffect } from 'react';
import * as Linking from 'expo-linking';
import { ThemeProvider } from '../context/ThemeContext';
import { AuthProvider } from '../context/AuthContext';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import '../i18n/config';

const prefix = Linking.createURL('/');

const handleDeepLink = (event: { url: string }) => {
  console.log('Deep link handled:', event.url);
  // Add your deep linking logic here
};

export default function Layout() {
  const [loaded] = useFonts({
    // Add your custom fonts here
  });

  useEffect(() => {
    // Configure deep linking
    const linking = {
      prefixes: [prefix, 'expoboilerplate://'],
      config: {
        screens: {
          index: '',
          home: 'home',
          'auth/login': 'login',
          // Add other screens here
        },
      },
    };

    const subscription = Linking.addEventListener('url', handleDeepLink);
    return () => {
      subscription.remove();
    };
  }, []);

  if (!loaded) return null;

  return (
    <SafeAreaProvider>
      <ThemeProvider>
        <AuthProvider>
          <Stack screenOptions={{ headerShown: false }} />
        </AuthProvider>
      </ThemeProvider>
    </SafeAreaProvider>
  );
} 