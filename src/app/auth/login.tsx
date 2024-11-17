import { View, Text, TextInput, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';
import { useTranslation } from 'react-i18next';
import { styled } from 'nativewind';

// Style your components
const StyledView = styled(View);
const StyledText = styled(Text);
const StyledTextInput = styled(TextInput);
const StyledTouchableOpacity = styled(TouchableOpacity);

export default function Login() {
  const { signIn } = useAuth();
  const { t } = useTranslation();

  return (
    <StyledView className="flex-1 justify-center p-4">
      <StyledText className="text-2xl font-bold mb-4">{t('auth.signIn')}</StyledText>
      <StyledTextInput
        className="border rounded p-2 mb-4"
        placeholder={t('auth.email')}
      />
      <StyledTextInput
        className="border rounded p-2 mb-4"
        placeholder={t('auth.password')}
        secureTextEntry
      />
      <StyledTouchableOpacity
        className="bg-blue-500 rounded p-2"
        onPress={() => signIn('', '')}
      >
        <StyledText className="text-white text-center">{t('auth.signIn')}</StyledText>
      </StyledTouchableOpacity>
    </StyledView>
  );
} 