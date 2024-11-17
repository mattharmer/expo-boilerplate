import { View, ActivityIndicator } from 'react-native';
import { styled } from 'nativewind';
import { useTranslation } from 'react-i18next';

const StyledView = styled(View);

export function Loading() {
  const { t } = useTranslation();

  return (
    <StyledView className="flex-1 justify-center items-center">
      <ActivityIndicator size="large" color="#0000ff" />
      <StyledView className="mt-4">
        {t('common.loading')}
      </StyledView>
    </StyledView>
  );
} 