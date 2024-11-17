import AsyncStorage from '@react-native-async-storage/async-storage';
import { Analytics } from '../services/analytics';

export const PrivacyManager = {
  async setConsent(consents: {
    analytics: boolean;
    marketing: boolean;
    necessary: boolean;
  }) {
    await AsyncStorage.setItem('privacy_consents', JSON.stringify(consents));
    
    if (!consents.analytics) {
      // Disable analytics
      Analytics.setUserProperties({ analytics_enabled: false });
    }
  },

  async getConsents() {
    const consents = await AsyncStorage.getItem('privacy_consents');
    return consents ? JSON.parse(consents) : null;
  },

  async deleteUserData() {
    // Implement data deletion logic here
    await AsyncStorage.clear();
    // Additional cleanup as needed
  },
}; 