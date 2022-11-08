import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tencent_wemeet_method_channel.dart';

abstract class TencentWemeetPlatform extends PlatformInterface {
  /// Constructs a TencentWemeetPlatform.
  TencentWemeetPlatform() : super(token: _token);

  static final Object _token = Object();

  static TencentWemeetPlatform _instance = MethodChannelTencentWemeet();

  /// The default instance of [TencentWemeetPlatform] to use.
  ///
  /// Defaults to [MethodChannelTencentWemeet].
  static TencentWemeetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TencentWemeetPlatform] when
  /// they register themselves.
  static set instance(TencentWemeetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
