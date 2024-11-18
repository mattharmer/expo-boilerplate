// Mock implementation for web
const AssetRegistry = {
  registerAsset: (asset: any) => {
    return typeof asset === 'number' ? asset : 1;
  },
  getAssetByID: (assetId: number) => {
    return {
      __packager_asset: true,
      fileSystemLocation: `/assets`,
      httpServerLocation: `/assets`,
      width: 1,
      height: 1,
      scales: [1],
      hash: 'mock',
      name: 'mock',
      type: 'mock'
    };
  }
};

module.exports = AssetRegistry; 