# Android Release Checklist

This checklist is specific to the current Flutter/Android setup in this repository.

## 1. Release identity and metadata

- [ ] Set `APP_APPLICATION_ID` in `android/gradle.properties`.
- [ ] Confirm the Android package name is the final production package name.
- [ ] Replace the Android app label in `android/app/src/main/AndroidManifest.xml` so it does not ship as `my_app`.
- [ ] Verify `version:` in `pubspec.yaml` matches the intended release version and build number.
- [ ] Confirm launcher icons are the final production assets.

Example `android/gradle.properties` entries:

```properties
APP_APPLICATION_ID=com.friendsfamilyfungames.someonelying
ADMOB_APP_ID_RELEASE=ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy
MYAPP_UPLOAD_STORE_FILE=/absolute/path/to/upload-keystore.jks
MYAPP_UPLOAD_STORE_PASSWORD=***
MYAPP_UPLOAD_KEY_ALIAS=upload
MYAPP_UPLOAD_KEY_PASSWORD=***
```

## 2. Signing configuration

- [ ] Create or obtain the Android upload keystore.
- [ ] Store the keystore outside the repository.
- [ ] Set `MYAPP_UPLOAD_STORE_FILE`.
- [ ] Set `MYAPP_UPLOAD_STORE_PASSWORD`.
- [ ] Set `MYAPP_UPLOAD_KEY_ALIAS`.
- [ ] Set `MYAPP_UPLOAD_KEY_PASSWORD`.
- [ ] Run a release build once to confirm Gradle accepts the signing config.

The current Gradle script hard-fails release builds without these values.

## 3. AdMob configuration

- [ ] Set `ADMOB_APP_ID_RELEASE` in `android/gradle.properties`.
- [ ] Confirm the manifest placeholder resolves correctly in release.
- [ ] Replace the rewarded ad unit id test values in `lib/src/monetization/ads_service.dart`.
- [ ] Verify the release AdMob app id and rewarded unit id belong to the same AdMob account/app.
- [ ] Validate that ads are disabled or handled safely if AdMob init fails.

Do not ship with Google test ad unit ids.

## 4. In-app purchase configuration

- [ ] Confirm the Android product id in `lib/src/monetization/monetization_controller.dart` is correct: `day_pass_24h`.
- [ ] Ensure the product exists in Google Play Console for the same application id.
- [ ] Verify the product is active and available to the release track being tested.
- [ ] Test purchase flow on a Play-distributed build, not just a local install.
- [ ] Verify purchase restore/entitlement behavior matches product type expectations.

Note: the current implementation grants entitlement from client-side local state. Review this before production if paid access must survive reinstall/device change.

## 5. Code and content validation

- [ ] Run `flutter pub get`.
- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Smoke test the full game loop:
  - [ ] onboarding
  - [ ] lobby player add/remove
  - [ ] settings changes
  - [ ] role reveal flow
  - [ ] discussion timer
  - [ ] voting and results
- [ ] Verify localization on supported languages.
- [ ] Verify monetization UI states:
  - [ ] free quota available
  - [ ] free quota exhausted
  - [ ] rewarded ad unavailable
  - [ ] rewarded ad success
  - [ ] purchase canceled
  - [ ] purchase failed
  - [ ] active pass

## 6. Android platform checks

- [ ] Confirm `com.android.vending.BILLING` is the only required Android permission currently needed.
- [ ] Verify Play billing, ads, and app id values match the release package name.
- [ ] Test on at least one low-end or older Android device.
- [ ] Test on at least one modern Android version.
- [ ] Confirm app startup, background/foreground transitions, and rotation behavior are acceptable.
- [ ] Check that keyboard behavior in the lobby works correctly on small screens.

## 7. Build commands

Install dependencies:

```bash
flutter pub get
```

Validate:

```bash
flutter analyze
flutter test
```

Build release APK:

```bash
flutter build apk --release
```

Optional split-per-ABI build:

```bash
flutter build apk --release --split-per-abi
```

## 8. Artifact verification

- [ ] Confirm the APK was generated under `build/app/outputs/flutter-apk/`.
- [ ] Verify the expected artifact exists:
  - [ ] `app-release.apk`, or
  - [ ] ABI-split APKs if using `--split-per-abi`
- [ ] Install the built APK on a physical device.
- [ ] Launch and verify the app name, icon, and startup behavior.
- [ ] Verify ads and purchases on the actual release-distributed build path when applicable.

## 9. Pre-publish release gate

Do not publish until all of the following are true:

- [ ] Release signing is configured.
- [ ] Release AdMob app id is configured.
- [ ] Test ad unit ids are removed.
- [ ] Android app label is corrected.
- [ ] Production application id is set.
- [ ] Static analysis and tests pass.
- [ ] Manual smoke test passes on real Android hardware.
- [ ] Purchase and ad flows are validated in the intended Play track.
