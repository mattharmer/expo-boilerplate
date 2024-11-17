import * as Sentry from '@sentry/react-native';

export const startPerformanceTransaction = (
  name: string,
  operation: string
): any => {
  return Sentry.startTransaction({
    name,
    op: operation,
  });
};

export const endPerformanceTransaction = (transaction: any): void => {
  transaction.finish();
}; 