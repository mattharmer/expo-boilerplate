declare module '*.json' {
  const value: any;
  export default value;
}

declare module '@env' {
  export const API_URL: string;
  export const APP_ENV: string;
  // Add other environment variables
} 