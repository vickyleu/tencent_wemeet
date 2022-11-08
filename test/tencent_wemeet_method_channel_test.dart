import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tencent_wemeet/tencent_wemeet_method_channel.dart';

void main() {
  MethodChannelTencentWemeet platform = MethodChannelTencentWemeet();
  const MethodChannel channel = MethodChannel('tencent_wemeet');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
