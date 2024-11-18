## BoilerPlate Installation

# Develop and test the boilerplate using setup-dev.sh
chmod +x scripts/setup-dev.sh
# From the root of your boilerplate project
npm run setup
Then run
npm run ts:check
Then run
npm run start:clear

# Once the boilerplate is ready, use create-project.sh to create new projects from it
./create-project.sh

# After running users need to:

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


# package.json contains the following scripts:
npm run start - Normal start with LAN access
npm run start:clear - Start with cleared cache (your previous command)
npm run android - Start for Android with LAN access
npm run ios - Start for iOS with LAN access
npm run web - Start for web
