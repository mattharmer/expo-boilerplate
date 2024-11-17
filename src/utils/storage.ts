import AsyncStorage from '@react-native-async-storage/async-storage';

export async function setItem(key: string, value: any): Promise<void> {
  try {
    await AsyncStorage.setItem(key, JSON.stringify(value));
  } catch (error) {
    console.error('Error saving data', error);
  }
}

export async function getItem<T>(key: string): Promise<T | null> {
  try {
    const value = await AsyncStorage.getItem(key);
    return value ? JSON.parse(value) : null;
  } catch (error) {
    console.error('Error reading data', error);
    return null;
  }
} 