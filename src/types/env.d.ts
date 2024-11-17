/// <reference types="node" />
/// <reference types="react" />
/// <reference types="react-native" />
/// <reference types="@react-native-async-storage/async-storage" />

declare module "*.json" {
  const value: any;
  export default value;
}

declare const __DEV__: boolean; 