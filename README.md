# Expo boilerplate

A 2024 starter for Expo (React Native) apps with a web target, TypeScript and Firebase. It includes a dev setup script and `create-project.sh` for spinning up a new app from this template.

This is a personal boilerplate, not an app in the stores.

## Develop the boilerplate

```bash
chmod +x scripts/setup-dev.sh
npm run setup
npm run ts:check
npm run start:clear
```

## Create a new project from it

```bash
./create-project.sh
```

Then, in the new project:

1. Create a Firebase project, add the config to a local `.env` (see `.env.example`; do not commit `.env`), and enable Authentication and Firestore.
2. Update `app.json` / `app.config.ts` with the app name, bundle identifier, version, icons and splash screens.
3. Optionally set up Sentry, RevenueCat, EAS CI/CD and deep linking.

## Scripts

- `npm run start` — start with LAN access
- `npm run start:clear` — start with a cleared cache
- `npm run android` / `npm run ios` / `npm run web` — platform targets
