import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tencent_wemeet/api_generated.dart';
import 'package:tencent_wemeet/tencent_wemeet_method_channel.dart';

void main() {
  MethodChannelTencentWemeet platform = MethodChannelTencentWemeet(
      binaryMessenger: WidgetsBinding.instance.defaultBinaryMessenger);
  TestWidgetsFlutterBinding.ensureInitialized();
  final params = DartInitParams(sdkId: '', sdkToken: '', serverAddress: ''//
      , appName: '', serverDomain: '', preferLanguage: '');
  test('initWeMeet', () async {
    final dynamic a = (await platform.initWeMeet(params)) as dynamic;
    expect(a.runtimeType, 'void');
  });
}
