import { Component, ReactNode } from 'react';
import { View, Text } from 'react-native';
import * as Sentry from '@sentry/react-native';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
  errorInfo?: {
    componentStack: string;
  };
}

export class ErrorBoundary extends Component<Props, State> {
  public readonly props: Props;

  constructor(props: Props) {
    super(props);
    this.props = props;
    this.state = { hasError: false };
  }

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  componentDidCatch(error: Error, errorInfo: any) {
    Sentry.captureException(error, { extra: errorInfo });
  }

  render() {
    if (this.state.hasError) {
      return (
        <View className="flex-1 items-center justify-center p-4">
          <Text className="text-lg font-bold">Something went wrong</Text>
          <Text className="mt-2 text-center">
            Please try again or contact support if the problem persists.
          </Text>
        </View>
      );
    }

    return this.props.children;
  }
} 