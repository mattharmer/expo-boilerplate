import analytics from '@react-native-firebase/analytics';
import * as Sentry from '@sentry/react-native';

export const Analytics = {
  logEvent: async (name: string, params?: Record<string, any>) => {
    try {
      await analytics().logEvent(name, params);
    } catch (error) {
      Sentry.captureException(error);
    }
  },

  setUserProperties: async (properties: Record<string, any>) => {
    try {
      Object.entries(properties).forEach(([key, value]) => {
        analytics().setUserProperty(key, value);
      });
    } catch (error) {
      Sentry.captureException(error);
    }
  },
}; 