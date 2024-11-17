import { createContext, useContext, useState, ReactNode } from 'react';
import { useColorScheme } from '../hooks/useColorScheme';

type Theme = 'light' | 'dark' | 'system';

interface ThemeContextType {
  theme: Theme;
  setTheme: (theme: Theme) => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

interface ThemeProviderProps {
  children: ReactNode | ((props: { theme: Theme }) => ReactNode);
}

export function ThemeProvider({ children }: ThemeProviderProps) {
  const systemTheme = useColorScheme();
  const [theme, setTheme] = useState<Theme>('system');

  const value = {
    theme,
    setTheme,
  };

  return (
    <ThemeContext.Provider value={value}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
} 