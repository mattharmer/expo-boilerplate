const { getDefaultConfig } = require('@expo/metro-config');

const config = getDefaultConfig(__dirname);

// Add necessary extensions and asset plugins
config.resolver.sourceExts = ['jsx', 'js', 'ts', 'tsx', 'json'];
config.transformer.assetPlugins = ['expo-asset/tools/hashAssetFiles'];

// Remove any expo-router/babel references if present
if (config.transformer.babelTransformerPath) {
  delete config.transformer.babelTransformerPath;
}

module.exports = config; 