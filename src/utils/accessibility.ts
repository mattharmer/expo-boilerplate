import { AccessibilityInfo, Platform } from 'react-native';

export const announceForAccessibility = (message: string): void => {
  if (Platform.OS === 'ios' || Platform.OS === 'android') {
    AccessibilityInfo.announceForAccessibility(message);
  }
};

export const isScreenReaderEnabled = async (): Promise<boolean> => {
  return await AccessibilityInfo.isScreenReaderEnabled();
}; 