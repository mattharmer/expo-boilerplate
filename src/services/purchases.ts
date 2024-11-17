import Purchases, { PurchasesConfiguration } from 'react-native-purchases';
import Constants from 'expo-constants';

const configuration: PurchasesConfiguration = {
  apiKey: Constants.expoConfig?.extra?.revenueCatApiKey || '',
};

export function initializePurchases() {
  Purchases.configure(configuration);
}

export async function getCurrentOfferings() {
  try {
    const offerings = await Purchases.getOfferings();
    return offerings.current;
  } catch (error) {
    console.error('Error fetching offerings:', error);
    return null;
  }
} 