import { Stack } from 'expo-router';
import { useAuth } from '../../context/AuthContext';
import { Redirect } from 'expo-router';

export default function AuthenticatedLayout() {
  const { isAuthenticated } = useAuth();

  // Redirect to login if not authenticated
  if (!isAuthenticated) {
    return <Redirect href="/auth/login" />;
  }

  return (
    <Stack
      screenOptions={{
        headerShown: false,
      }}
    />
  );
} 