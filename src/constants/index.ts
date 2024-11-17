import { Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');

export const SCREEN = {
  WIDTH: width,
  HEIGHT: height,
};

export const APP_CONSTANTS = {
  API_URL: process.env.API_URL || 'https://api.yourapp.com',
  APP_ENV: process.env.APP_ENV || 'development',
  STORAGE_KEYS: {
    AUTH_TOKEN: 'auth_token',
    USER_DATA: 'user_data',
    THEME: 'theme',
    LANGUAGE: 'language',
  },
}; 