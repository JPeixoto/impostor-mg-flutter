import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingGateResult {
  const OnboardingGateResult({
    required this.shouldShowOnboarding,
    required this.appVersionTag,
  });

  final bool shouldShowOnboarding;
  final String appVersionTag;
}

class OnboardingGate {
  static const String _onboardingVersionKey = 'onboarding_version_seen';

  static Future<OnboardingGateResult> resolve({
    SharedPreferences? sharedPreferences,
    PackageInfo? packageInfo,
  }) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    final info = packageInfo ?? await PackageInfo.fromPlatform();
    final appVersionTag = _buildVersionTag(info);

    final lastSeenVersion = prefs.getString(_onboardingVersionKey);
    final shouldShowOnboarding = lastSeenVersion != appVersionTag;

    if (shouldShowOnboarding) {
      await prefs.setString(_onboardingVersionKey, appVersionTag);
    }

    return OnboardingGateResult(
      shouldShowOnboarding: shouldShowOnboarding,
      appVersionTag: appVersionTag,
    );
  }

  static String _buildVersionTag(PackageInfo info) {
    final version = info.version.trim();
    final buildNumber = info.buildNumber.trim();
    if (buildNumber.isEmpty) {
      return version;
    }
    return '$version+$buildNumber';
  }
}
