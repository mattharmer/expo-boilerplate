import Constants from 'expo-constants';

export async function subscribeToWebPush() {
  if ('serviceWorker' in navigator && 'PushManager' in window) {
    try {
      const registration = await navigator.serviceWorker.register('/sw.js');
      const subscription = await registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: Constants.expoConfig?.extra?.webPushPublicKey,
      });
      
      // Send subscription to your server
      return subscription;
    } catch (error) {
      console.error('Error subscribing to push notifications:', error);
      return null;
    }
  }
  return null;
} 