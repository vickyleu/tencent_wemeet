// Autogenerated from Pigeon (v4.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class DartInitParams {
  DartInitParams({
    required this.sdkId,
    required this.sdkToken,
    required this.appName,
    required this.serverAddress,
    required this.serverDomain,
    required this.envName,
    required this.envId,
    required this.envDomain,
    required this.envDebugMode,
    required this.preferLanguage,
  });

  String sdkId;
  String sdkToken;
  String appName;
  String serverAddress;
  String serverDomain;
  String envName;
  String envId;
  String envDomain;
  bool envDebugMode;
  String preferLanguage;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['sdkId'] = sdkId;
    pigeonMap['sdkToken'] = sdkToken;
    pigeonMap['appName'] = appName;
    pigeonMap['serverAddress'] = serverAddress;
    pigeonMap['serverDomain'] = serverDomain;
    pigeonMap['envName'] = envName;
    pigeonMap['envId'] = envId;
    pigeonMap['envDomain'] = envDomain;
    pigeonMap['envDebugMode'] = envDebugMode;
    pigeonMap['preferLanguage'] = preferLanguage;
    return pigeonMap;
  }

  static DartInitParams decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return DartInitParams(
      sdkId: pigeonMap['sdkId']! as String,
      sdkToken: pigeonMap['sdkToken']! as String,
      appName: pigeonMap['appName']! as String,
      serverAddress: pigeonMap['serverAddress']! as String,
      serverDomain: pigeonMap['serverDomain']! as String,
      envName: pigeonMap['envName']! as String,
      envId: pigeonMap['envId']! as String,
      envDomain: pigeonMap['envDomain']! as String,
      envDebugMode: pigeonMap['envDebugMode']! as bool,
      preferLanguage: pigeonMap['preferLanguage']! as String,
    );
  }
}

class _WeMeetApiCodec extends StandardMessageCodec{
  const _WeMeetApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is DartInitParams) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return DartInitParams.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

class WeMeetApi {
  /// Constructor for [WeMeetApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  WeMeetApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _WeMeetApiCodec();

  Future<void> init(DartInitParams arg_param) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.WeMeetApi.init', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_param]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> release() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.WeMeetApi.release', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}