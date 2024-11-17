import Purchases, { PurchasesConfiguration } from 'react-native-purchases';
import Constants from 'expo-constants';

export async function initializePurchases() {
  const configuration = new PurchasesConfiguration(
    Constants.expoConfig?.extra?.revenueCatApiKey ?? ''
  );
  Purchases.configure(configuration);
}

export async function getOfferings() {
  try {
    const offerings = await Purchases.getOfferings();
    return offerings.current;
  } catch (error) {
    console.error('Error fetching offerings:', error);
    return null;
  }
} 