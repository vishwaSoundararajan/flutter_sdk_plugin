import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersdkplugin/fluttersdkplugin_method_channel.dart';

void main() {
  MethodChannelFluttersdkplugin platform = MethodChannelFluttersdkplugin();
  const MethodChannel channel = MethodChannel('fluttersdkplugin');

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
