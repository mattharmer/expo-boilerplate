import { format, formatDistance } from 'date-fns';
import { getLocales } from 'expo-localization';

export const formatDate = (date: Date): string => {
  const locale = getLocales()[0].languageCode;
  return format(date, 'PP', { locale });
};

export const formatRelativeTime = (date: Date): string => {
  const locale = getLocales()[0].languageCode;
  return formatDistance(date, new Date(), { addSuffix: true, locale });
}; 