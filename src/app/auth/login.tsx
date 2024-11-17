import { View, Text, TextInput, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';
import { useTranslation } from 'react-i18next';

export default function Login() {
  const { signIn } = useAuth();
  const { t } = useTranslation();

  return (
    <View className="flex-1 justify-center p-4">
      <Text className="text-2xl font-bold mb-4">{t('auth.signIn')}</Text>
      <TextInput
        className="border rounded p-2 mb-4"
        placeholder={t('auth.email')}
      />
      <TextInput
        className="border rounded p-2 mb-4"
        placeholder={t('auth.password')}
        secureTextEntry
      />
      <TouchableOpacity
        className="bg-blue-500 rounded p-2"
        onPress={() => signIn('', '')}
      >
        <Text className="text-white text-center">{t('auth.signIn')}</Text>
      </TouchableOpacity>
    </View>
  );
} 