import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// The running app's version, read from the platform bundle, which Flutter
/// fills from the `version:` field in pubspec.yaml. Nothing in the UI carries
/// a version string of its own, so a release only needs the pubspec bump.
final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
});
