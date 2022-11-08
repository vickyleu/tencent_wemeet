import 'package:pigeon/pigeon.dart';

class DartInitParams {
  final String sdkId;
  final String sdkToken;
  final String appName;
  final String serverAddress;
  final String serverDomain;
  final String envName;
  final String envId;
  final String envDomain;
  final bool envDebugMode;
  final String preferLanguage;

  DartInitParams(
      this.sdkId,
      this.sdkToken,
      this.appName,
      this.serverAddress,
      this.serverDomain,
      this.envName,
      this.envId,
      this.envDomain,
      this.envDebugMode,
      this.preferLanguage);
}


@HostApi()
abstract class WeMeetApi {
  void init(DartInitParams param);

  void release();
}
