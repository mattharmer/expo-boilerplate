declare module '*.svg' {
  import React from 'react';
  import { SvgProps } from 'react-native-svg';
  const content: React.FC<SvgProps>;
  export default content;
}

declare module '@env' {
  export const API_URL: string;
  export const APP_ENV: string;
}

declare module 'react-native/Libraries/Image/AssetRegistry' {
  export function registerAsset(asset: any): number;
  export function getAssetByID(assetId: number): any;
}

declare module '@react-native/assets-registry' {
  export function registerAsset(asset: any): number;
  export function getAssetByID(assetId: number): any;
} 