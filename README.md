## BoilerPlate Installation

chmod +x create-project.sh
sudo ./create-project.sh

The create-project.sh run the install.sh script
The install.sh script will handle project-specific configuration files

After running install.sh, users need to:

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
