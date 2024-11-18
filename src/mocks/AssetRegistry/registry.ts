// Mock implementation for web asset registry
const registry = {
  __packager_asset: true,
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

module.exports = registry; 