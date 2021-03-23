# Troubleshooting

### Error #1 (Android)
```logs
E/flutter (20966): [ERROR:flutter/lib/ui/ui_dart_state.cc(186)] Unhandled Exception: PlatformException(error, null, null,
E/flutter (20966):      java.lang.IllegalArgumentException
E/flutter (20966):      at android.media.MediaMetadataRetriever.setDataSource(MediaMetadataRetriever.java:95)
E/flutter (20966):      at android.media.MediaMetadataRetriever.setDataSource(MediaMetadataRetriever.java:204)
E/flutter (20966):      at com.example.flutter_video_info.FlutterVideoInfoPlugin.getVidInfo(FlutterVideoInfoPlugin.java:66)
E/flutter (20966):      at com.example.flutter_video_info.FlutterVideoInfoPlugin.onMethodCall(FlutterVideoInfoPlugin.java:49)
E/flutter (20966):      at io.flutter.plugin.common.MethodChannel$IncomingMethodCallHandler.onMessage(MethodChannel.java:233)
E/flutter (20966):      at io.flutter.embedding.engine.dart.DartMessenger.handleMessageFromDart(DartMessenger.java:85)
E/flutter (20966):      at io.flutter.embedding.engine.FlutterJNI.handlePlatformMessage(FlutterJNI.java:818)
E/flutter (20966):      at android.os.MessageQueue.nativePollOnce(Native Method)
E/flutter (20966):      at android.os.MessageQueue.next(MessageQueue.java:336)
E/flutter (20966):      at android.os.Looper.loop(Looper.java:184)
E/flutter (20966):      at android.app.ActivityThread.main(ActivityThread.java:7824)
E/flutter (20966):      at java.lang.reflect.Method.invoke(Native Method)
E/flutter (20966):      at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:492)
E/flutter (20966):      at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:981)
E/flutter (20966): )
E/flutter (20966): #0      StandardMethodCodec.decodeEnvelope (package:flutter/src/services/message_codecs.dart:581:7)
E/flutter (20966): #1      MethodChannel._invokeMethod (package:flutter/src/services/platform_channel.dart:158:18)
E/flutter (20966): <asynchronous suspension>
E/flutter (20966): #2      FlutterVideoInfo.getVideoInfo (package:flutter_video_info/flutter_video_info.dart:14:21)
E/flutter (20966): <asynchronous suspension>
E/flutter (20966): #3      _MyAppState.getVideoInfo (package:flutter_video_info_example/main.dart:39:13)
E/flutter (20966): <asynchronous suspension>
```
### Possible Solution:
#### For All Devies:
   This exception generally come due to absence of <b>External Storage Permission </b>in case file accessed from external storage

####  For Android 10: 
  If Exception (java.lang.IllegalArgumentException) comes,
  Add ```android:requestLegacyExternalStorage="true"``` in AndroidManifest.xml file inside application.([Ref](https://developer.android.com/training/data-storage/use-cases#opt-out-scoped-storage))

  ```xml
    <manifest ... >
  <!-- This attribute is "false" by default on apps targeting
       Android 10 or higher. -->
    <application android:requestLegacyExternalStorage="true" ... >
      ...
    </application>
  </manifest>
  ```
