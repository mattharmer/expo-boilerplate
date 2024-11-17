import { View, Text, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';
import { useTranslation } from 'react-i18next';

export default function Home() {
  const { signOut } = useAuth();
  const { t } = useTranslation();

  return (
    <View className="flex-1 justify-center items-center">
      <Text className="text-xl mb-4">Welcome to the Home Screen!</Text>
      <TouchableOpacity
        className="bg-red-500 rounded p-2"
        onPress={signOut}
      >
        <Text className="text-white">{t('auth.signOut')}</Text>
      </TouchableOpacity>
    </View>
  );
} 