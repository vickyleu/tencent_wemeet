import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tencent_wemeet_platform_interface.dart';

/// An implementation of [TencentWemeetPlatform] that uses method channels.
class MethodChannelTencentWemeet extends TencentWemeetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tencent_wemeet');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
