import { Platform } from 'react-native';
import { createRoot } from 'react-dom/client';
import { AppRegistry } from 'react-native';
import App from './app';

if (Platform.OS === 'web') {
  const rootTag = document.getElementById('root') ?? document.getElementById('main');
  
  if (!rootTag) {
    throw new Error('No root element found. Add a root element to your index.html');
  }

  const root = createRoot(rootTag);
  
  const RootComponent = () => <App />;
  
  AppRegistry.registerComponent('main', () => RootComponent);
  
  root.render(<RootComponent />);
}

export default App; 