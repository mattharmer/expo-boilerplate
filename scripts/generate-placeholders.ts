import sharp from 'sharp';

const sizes = {
  icon: 1024,
  splash: 2048,
  'adaptive-icon': 1024,
  favicon: 48
};

async function generatePlaceholder(name: string, size: number) {
  await sharp({
    create: {
      width: size,
      height: size,
      channels: 4,
      background: { r: 255, g: 255, b: 255, alpha: 1 }
    }
  })
    .composite([{
      input: {
        text: {
          text: `${name}\n${size}x${size}`,
          rgba: true,
          font: 'sans-serif',
          fontSize: size / 10
        }
      },
      gravity: 'center'
    }])
    .png()
    .toFile(`src/assets/images/${name}.png`);
}

Object.entries(sizes).forEach(([name, size]) => {
  generatePlaceholder(name, size);
}); 