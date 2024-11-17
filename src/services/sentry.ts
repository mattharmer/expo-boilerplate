import * as Sentry from '@sentry/react-native';
import Constants from 'expo-constants';

export function initializeSentry() {
  Sentry.init({
    dsn: Constants.expoConfig?.extra?.sentryDsn,
    enableAutoSessionTracking: true,
    debug: __DEV__,
    environment: __DEV__ ? 'development' : 'production',
  });
} 