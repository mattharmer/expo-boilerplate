import { LinkingOptions } from '@react-navigation/native';

export const linking: LinkingOptions<any> = {
  prefixes: ['expoboilerplate://', 'https://yourapp.com'],
  config: {
    screens: {
      index: '',
      home: 'home',
      'auth/login': 'login',
    },
  },
}; 