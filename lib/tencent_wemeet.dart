
import 'tencent_wemeet_platform_interface.dart';

class TencentWemeet {
  Future<String?> getPlatformVersion() {
    return TencentWemeetPlatform.instance.getPlatformVersion();
  }
}
