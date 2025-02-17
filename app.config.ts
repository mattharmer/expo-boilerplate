import { ExpoConfig, ConfigContext } from 'expo/config';

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: 'ExpoBoilerplate',
  slug: 'expo-boilerplate',
  version: '1.0.0',
  orientation: 'portrait',
  icon: './src/assets/images/icon.png',
  userInterfaceStyle: 'automatic',
  splash: {
    image: './src/assets/images/splash.png',
    resizeMode: 'contain',
    backgroundColor: '#ffffff'
  },
  updates: {
    fallbackToCacheTimeout: 0
  },
  assetBundlePatterns: [
    "**/*"
  ],
  ios: {
    supportsTablet: true,
    bundleIdentifier: 'com.yourcompany.expoboilerplate'
  },
  android: {
    adaptiveIcon: {
      foregroundImage: './src/assets/images/adaptive-icon.png',
      backgroundColor: '#FFFFFF'
    },
    package: 'com.yourcompany.expoboilerplate'
  },
  web: {
    favicon: './src/assets/images/favicon.png',
    bundler: 'metro',
    output: 'static',
    name: 'ExpoBoilerplate',
    themeColor: '#ffffff',
    backgroundColor: '#ffffff',
    startUrl: '/',
    display: 'standalone',
    orientation: 'portrait',
    scope: '/',
    shortName: 'ExpoBoilerplate'
  },
  plugins: [
    'expo-router',
    'expo-localization',
    'expo-font'
  ],
  extra: {
    firebaseApiKey: process.env.FIREBASE_API_KEY,
    firebaseAuthDomain: process.env.FIREBASE_AUTH_DOMAIN,
    firebaseProjectId: process.env.FIREBASE_PROJECT_ID,
    firebaseStorageBucket: process.env.FIREBASE_STORAGE_BUCKET,
    firebaseMessagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
    firebaseAppId: process.env.FIREBASE_APP_ID,
    firebaseMeasurementId: process.env.FIREBASE_MEASUREMENT_ID,
    sentryDsn: process.env.SENTRY_DSN,
    revenueCatApiKey: process.env.REVENUECAT_API_KEY,
    webPushPublicKey: process.env.WEB_PUSH_PUBLIC_KEY,
  }
}); 