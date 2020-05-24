import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getExternalStoragePermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  final videoInfo = FlutterVideoInfo();

  @override
  void initState() {
    if (Platform.isAndroid) {
      getExternalStoragePermission();
    }
    super.initState();
  }

  String info = "";

  getVideoInfo() async {
    /// here file path of video required
    String videoFilePath = "storage/emulated/0/Geocam/Videos/V.mp4";
    var a = await videoInfo.getVideoInfo(videoFilePath);
    setState(() {
      info =
          "title=> ${a.title}\npath=> ${a.path}\nauthor=> ${a.author}\nmimetype=> ${a.mimetype}";
      info +=
          "\nheight=> ${a.height}\nwidth=> ${a.width}\nfileSize=> ${a.filesize} Bytes\nduration=> ${a.duration} milisec";
      info +=
          "\norientation=> ${a.orientation}\ndate=> ${a.date}\nframerate=> ${a.framerate}";
      info += "\nlocation=> ${a.location}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.plus_one),
            onPressed: () {
              getVideoInfo();
            }),
        appBar: AppBar(
          title: const Text('Flutter_Video_info example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Text(
              info,
              style: TextStyle(fontSize: 21),
            ),
          ),
        ),
      ),
    );
  }
}
