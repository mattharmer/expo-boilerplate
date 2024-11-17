import { View, Text, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';
import { useTranslation } from 'react-i18next';
import { styled } from 'nativewind';

// Style your components
const StyledView = styled(View);
const StyledText = styled(Text);
const StyledTouchableOpacity = styled(TouchableOpacity);

export default function Home() {
  const { signOut } = useAuth();
  const { t } = useTranslation();

  return (
    <StyledView className="flex-1 justify-center items-center">
      <StyledText className="text-xl mb-4">Welcome to the Home Screen!</StyledText>
      <StyledTouchableOpacity
        className="bg-red-500 rounded p-2"
        onPress={signOut}
      >
        <StyledText className="text-white">{t('auth.signOut')}</StyledText>
      </StyledTouchableOpacity>
    </StyledView>
  );
} 