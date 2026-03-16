import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/src/core/onboarding_gate.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

PackageInfo _packageInfo({
  required String version,
  required String buildNumber,
}) {
  return PackageInfo(
    appName: 'Impostor',
    packageName: 'com.example.impostor',
    version: version,
    buildNumber: buildNumber,
    buildSignature: 'signature',
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('shows onboarding only once for the same app version', () async {
    final prefs = await SharedPreferences.getInstance();
    final packageInfo = _packageInfo(version: '1.0.0', buildNumber: '1');

    final firstResult = await OnboardingGate.resolve(
      sharedPreferences: prefs,
      packageInfo: packageInfo,
    );
    final secondResult = await OnboardingGate.resolve(
      sharedPreferences: prefs,
      packageInfo: packageInfo,
    );

    expect(firstResult.shouldShowOnboarding, isTrue);
    expect(firstResult.appVersionTag, '1.0.0+1');
    expect(secondResult.shouldShowOnboarding, isFalse);
  });

  test('shows onboarding again after app version changes', () async {
    final prefs = await SharedPreferences.getInstance();
    final oldVersion = _packageInfo(version: '1.0.0', buildNumber: '1');
    final updatedVersion = _packageInfo(version: '1.1.0', buildNumber: '2');

    final firstOpen = await OnboardingGate.resolve(
      sharedPreferences: prefs,
      packageInfo: oldVersion,
    );
    final afterUpdate = await OnboardingGate.resolve(
      sharedPreferences: prefs,
      packageInfo: updatedVersion,
    );
    final secondOpenAfterUpdate = await OnboardingGate.resolve(
      sharedPreferences: prefs,
      packageInfo: updatedVersion,
    );

    expect(firstOpen.shouldShowOnboarding, isTrue);
    expect(afterUpdate.shouldShowOnboarding, isTrue);
    expect(secondOpenAfterUpdate.shouldShowOnboarding, isFalse);
  });
}
