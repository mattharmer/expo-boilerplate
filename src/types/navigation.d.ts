export type RootStackParamList = {
  index: undefined;
  home: undefined;
  'auth/login': undefined;
  'auth/register': undefined;
  'settings': undefined;
  'profile': { userId: string };
};

declare global {
  namespace ReactNavigation {
    interface RootParamList extends RootStackParamList {}
  }
} 