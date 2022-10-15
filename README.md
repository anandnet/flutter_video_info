<a href="https://pub.dev/packages/flutter_video_info" rel="nofollow"><img src="https://img.shields.io/badge/pub-v1.3.0-blue" alt="pub package" data-canonical-src="https://img.shields.io/pub/v/sliding_up_panel.svg" style="max-width:100%;"></a>
<img src="https://img.shields.io/badge/Platform-android%20%7C%20ios-green" alt="pub package" data-canonical-src="https://img.shields.io/pub/v/sliding_up_panel.svg" style="max-width:100%;">
# flutter_video_info  1.3.0

This plugin uses MediaMetadataRetriever class of native android to get basic meta information 
of a video file.


<b>The following info can be extracted by this plugin:</b>

`title`
`path`
`author`
`mimetype`
`height`
`width`
`filesize`
`duration`
`orientation`
`date`
`framerate`
`location`



## Installation & Uses

Add `flutter_video_info` as a dependency in your pubspec.yaml file ([what?](https://flutter.io/using-packages/)).
```
dependencies:
    flutter_video_info: <current version>
```

Import FlutterVideoInfo in your dart file.
```dart
import 'package:flutter_video_info/flutter_video_info.dart';

final videoInfo = FlutterVideoInfo();

String videoFilePath = "your_video_file_path";
var info = await videoInfo.getVideoInfo(videoFilePath);

//String title = info.title;   to get title of video
//similarly path,author,mimetype,height,width,filesize,duration,orientation,date,framerate,location can be extracted.

```

## for iOS
If you select a video from your photo library, 
Add the following keys to your Info.plist file, located in /ios/Runner/Info.plist:

NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.


## Troubleshooting
  Checkout <a href="https://github.com/anandnet/flutter_video_info/blob/master/troubleshoot.md">here<a/>
    
## PR is welcomed
  Anyone can pr for these  <a href="https://github.com/anandnet/flutter_video_info/issues">issues<a/><br/>
  Thanks for your PR Over IOException issue <a href="https://github.com/martinale14">@martinale14</a>,<a href="https://github.com/devianl2">@devianl2</a> and <a href="https://github.com/nagendarbalajij-devs">@nagendarbalajij-devs</a>

