# video_info

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

###### This plugin is presently working only on `Android`. (if anyone wants to contribute for `ios` feel free to [PR here..](https://github.com/anandnet/flutter_video_info))


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
