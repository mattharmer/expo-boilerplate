# Project Overview

## Purpose
This boilerplate is designed to facilitate the development of applications for Android, iOS, and the web, focusing on a cross-platform experience that adheres to high-quality standards, including support for multiple languages, social login, and in-app purchases while following platform-specific design guidelines.

## Supported Platforms
- Android
- iOS
Web

## Technology Stack
- Development Environment: Cursor
- Node.js: v18.x
npm: v9.x
- Git: For Version Control
- TypeScript: v5.x
- Expo: SDK 50
- Expo Router v4
Expo Go for testing
- React: v18.x
- React Native: Included with Expo SDK 50
- Firebase: For backend functions
- Firestore
Authentication
- Storage
- Cloud Messaging (FCM)
- Analytics
- Offline Persistence
Tailwind CSS: For Web Styling.
- Jest: For Unit Tests
- RevenueCat: For In-App Purchases and Subscriptions
- Internationalization: i18next or react-i18next
- Sentry: For Error Reporting and Performance Monitoring
WebPush API: For web push notifications

## Architecture & Design Principles

### Modular Architecture
The project encourages breaking down the app into smaller, manageable parts or packages for isolation of features, which can be tested independently.

### Apple Human Interface Guidelines
Ensures UI consistency with iOS expectations, including navigation patterns and user interface elements.

## Development Setup

### Development Environment (Cursor)
Configured with necessary extensions for TypeScript, React, React Native, and Expo.

### Node.js and npm
Versions v18.x and v9.x respectively, managed through package.json.

### Git
Used for version control, with recommended practices for branching, committing, etc.

### TypeScript Configuration
tsconfig.json is set up for both React and React Native compatibility. strict mode to catch more errors during development, enhancing code reliability.

### Expo Setup
- SDK 52
- Expo Router (v4) for navigation
Expo Go for immediate testing on devices
Configuration in app.json for permissions and settings

## Core Features

### Multi-Language Support
i18next or react-i18next for translation management
RTL support for right-to-left languages

### Social Login
Integrated using Firebase Authentication.

### PayWall
Implemented with RevenueCat for handling subscriptions and purchases.

### Push Notifications
- FCM for mobile push notifications
- WebPush API for web notifications

### Offline Capabilities
Enabled via Firebase's offline persistence for Firestore.

### State Management & Data Flow

#### React Context API
For managing UI state or transient data that doesn't require persistence.
Firebase: Handles persistent data storage and offline sync.

## UI & Styling

### Tailwind CSS
Configured to work with both web and React Native (using tailwindcss-expo).

### Theming Support
Implement a theming system to support dark mode and custom themes, enhancing user experience.

## Security

### Secure Storage
expo-secure-store for storing sensitive information.

### Firebase Security Rules
Applied to Firestore and Storage for data protection.

### Authentication Flows
Secure implementations for various authentication methods.

### GDPR and CCPA Compliance
Ensure that your app complies with data protection regulations like GDPR and CCPA, especially if it handles personal data from users in Europe or California.

## Performance Optimization

### Code Splitting
Utilized with Expo Router for efficient bundle management.

### Asset Optimization
Techniques for optimizing images and other assets.

### Lazy Loading
Implement lazy loading for components and assets to improve initial load times.

### React Native Reanimated
Use React Native Reanimated for smoother animations with better performance.

### Image Optimization
Expo Image: Utilize expo-image for advanced image loading and caching capabilities.

## Testing & Quality Assurance

### Unit Testing
Using Jest, with configurations for both web and React Native.

### Accessibility
Ensured compliance with platform guidelines, particularly for iOS.

## Deployment & Versioning

### CI/CD
Automated builds with EAS for mobile and Vercel for web.

### OTA Updates
Using Expo for over-the-air updates.

### Versioning
Semantic versioning applied for release management.

## Analytics & Monitoring

### Firebase Analytics
For user and app analytics.

### Sentry
For real-time error tracking and performance monitoring.

## Documentation

### Usage Guide
How to set up, run, and extend the boilerplate.

### Changelog
Version history and significant updates.

### FAQ
Common questions and solutions.

## Additional Notes

### Localization Formatting
Intl or date-fns-tz: Use the Intl API or date-fns for locale-aware date, time, and number formatting.

### Payment Processing
Stripe Integration: If your app requires more complex payment processing, integrating Stripe can offer more flexibility alongside RevenueCat.

### Environment Variables
Use expo-env for managing different environment configurations.

### Custom Fonts and Icons
Properly load these across platforms using Expo's asset management.

### Deep Linking
Configured for navigation across platforms.

### Best Practices
Follow coding standards and use pre-commit hooks for maintaining code quality.

### Husky
Run scripts before commits, pushes, or other Git actions
Prevent bad commits or pushes that might break your codebase
