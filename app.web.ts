import { Platform } from 'react-native';

// Web-specific configuration
if (Platform.OS === 'web') {
  // Add web-specific polyfills and settings
  if (typeof window !== 'undefined') {
    // @ts-ignore
    window._frameTimestamp = null;
  }
}

export { default } from './app.config'; 