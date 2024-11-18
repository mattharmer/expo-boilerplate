import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import { getLocales } from 'expo-localization';
import en from './translations/en.json';
import es from './translations/es.json';
import { InitOptions } from 'i18next';

const resources = {
  en: { translation: en },
  es: { translation: es },
};

const config: InitOptions = {
  lng: getLocales()[0].languageCode || undefined,
  fallbackLng: 'en',
  interpolation: {
    escapeValue: false,
  },
  resources,
};

i18n
  .use(initReactI18next)
  .init(config);

export default i18n; 