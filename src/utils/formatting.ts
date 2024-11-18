import { format, formatDistance } from 'date-fns';
import { Locale } from 'date-fns';
import { getLocales } from 'expo-localization';

// Helper to convert string locale to date-fns Locale
import * as locales from 'date-fns/locale';

function getDateFnsLocale(localeString: string | null): Locale | undefined {
  if (!localeString) return undefined;
  const localeKey = localeString.replace('-', ''); // Convert 'en-US' to 'enUS'
  return (locales as Record<string, Locale>)[localeKey];
}

export function formatDate(date: Date): string {
  const deviceLocale = getLocales()[0].languageCode;
  const locale = getDateFnsLocale(deviceLocale);
  return format(date, 'PP', { locale });
}

export function formatRelativeTime(date: Date): string {
  const deviceLocale = getLocales()[0].languageCode;
  const locale = getDateFnsLocale(deviceLocale);
  return formatDistance(date, new Date(), { addSuffix: true, locale });
} 