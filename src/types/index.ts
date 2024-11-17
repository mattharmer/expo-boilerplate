export interface User {
  id: string;
  email: string;
  displayName?: string;
  photoURL?: string;
}

export interface Theme {
  dark: boolean;
  colors: {
    primary: string;
    background: string;
    card: string;
    text: string;
    border: string;
    notification: string;
  };
} 