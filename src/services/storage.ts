import * as SecureStore from 'expo-secure-store';

export async function setSecureItem(key: string, value: string): Promise<void> {
  await SecureStore.setItemAsync(key, value);
}

export async function getSecureItem(key: string): Promise<string | null> {
  return await SecureStore.getItemAsync(key);
} 