#import "FluttersdkpluginPlugin.h"
#if __has_include(<fluttersdkplugin/fluttersdkplugin-Swift.h>)
#import <fluttersdkplugin/fluttersdkplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttersdkplugin-Swift.h"
#endif

@implementation FluttersdkpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFluttersdkpluginPlugin registerWithRegistrar:registrar];
}
@end
