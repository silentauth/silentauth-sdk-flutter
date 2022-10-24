#import "SilentauthSdkFlutterPlugin.h"
#if __has_include(<silentauth_sdk_flutter/silentauth_sdk_flutter-Swift.h>)
#import <silentauth_sdk_flutter/silentauth_sdk_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "silentauth_sdk_flutter-Swift.h"
#endif

@implementation SilentauthSdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSilentauthSdkFlutterPlugin registerWithRegistrar:registrar];
}
@end
