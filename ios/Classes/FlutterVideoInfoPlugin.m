#import "FlutterVideoInfoPlugin.h"
#if __has_include(<flutter_video_info/flutter_video_info-Swift.h>)
#import <flutter_video_info/flutter_video_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_video_info-Swift.h"
#endif

@implementation FlutterVideoInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterVideoInfoPlugin registerWithRegistrar:registrar];
}
@end
