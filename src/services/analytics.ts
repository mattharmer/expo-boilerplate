import analytics from '@react-native-firebase/analytics';

export class Analytics {
  static async logEvent(name: string, params?: Record<string, any>) {
    try {
      await analytics().logEvent(name, params);
    } catch (error) {
      console.error('Analytics error:', error);
    }
  }

  static async setUserProperties(properties: Record<string, any>) {
    try {
      Object.entries(properties).forEach(async ([key, value]) => {
        await analytics().setUserProperty(key, value);
      });
    } catch (error) {
      console.error('Analytics error:', error);
    }
  }
} 