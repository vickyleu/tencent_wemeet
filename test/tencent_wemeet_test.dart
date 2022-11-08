import 'package:flutter_test/flutter_test.dart';
import 'package:tencent_wemeet/tencent_wemeet.dart';
import 'package:tencent_wemeet/tencent_wemeet_platform_interface.dart';
import 'package:tencent_wemeet/tencent_wemeet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTencentWemeetPlatform
    with MockPlatformInterfaceMixin
    implements TencentWemeetPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TencentWemeetPlatform initialPlatform = TencentWemeetPlatform.instance;

  test('$MethodChannelTencentWemeet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTencentWemeet>());
  });

  test('getPlatformVersion', () async {
    TencentWemeet tencentWemeetPlugin = TencentWemeet();
    MockTencentWemeetPlatform fakePlatform = MockTencentWemeetPlatform();
    TencentWemeetPlatform.instance = fakePlatform;

    expect(await tencentWemeetPlugin.getPlatformVersion(), '42');
  });
}
