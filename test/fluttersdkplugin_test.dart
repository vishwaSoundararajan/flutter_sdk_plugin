import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersdkplugin/fluttersdkplugin.dart';
import 'package:fluttersdkplugin/fluttersdkplugin_platform_interface.dart';
import 'package:fluttersdkplugin/fluttersdkplugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFluttersdkpluginPlatform
    with MockPlatformInterfaceMixin
    implements FluttersdkpluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FluttersdkpluginPlatform initialPlatform = FluttersdkpluginPlatform.instance;

  test('$MethodChannelFluttersdkplugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFluttersdkplugin>());
  });

  test('getPlatformVersion', () async {
    Fluttersdkplugin fluttersdkpluginPlugin = Fluttersdkplugin();
    MockFluttersdkpluginPlatform fakePlatform = MockFluttersdkpluginPlatform();
    FluttersdkpluginPlatform.instance = fakePlatform;

    expect(await fluttersdkpluginPlugin.getPlatformVersion(), '42');
  });
}
