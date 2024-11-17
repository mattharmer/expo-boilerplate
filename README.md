## BoilerPlate Installation

Develop and test the boilerplate using setup-dev.sh
chmod +x scripts/setup-dev.sh
# From the root of your boilerplate project
npm run setup

Once the boilerplate is ready, use create-project.sh to create new projects from it
./create-project.sh test-expo-app

After running users need to:

1. Configure Firebase:
   - Create a Firebase project
   - Add the Firebase config to .env file
   - Enable Authentication and Firestore in Firebase Console

2. Configure environment variables in .env:
   - Update app.json/app.config.ts with their app-specific details:
     - App name
     - Bundle identifier
     - Version numbers
     - Icons and splash screens

3. Optional configurations:
   - Set up Sentry for error tracking
   - Configure RevenueCat for in-app purchases
   - Set up CI/CD with EAS
   - Configure deep linking

   npx expo start --lan -c
