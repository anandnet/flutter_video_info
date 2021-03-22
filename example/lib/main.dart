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
    await Permission.storage.request();
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
  String videoFilePath = "";

  getVideoInfo() async {
    /// here file path of video required
    if (Platform.isIOS) {
      videoFilePath =
          "/Users/User/Library/Developer/CoreSimulator/Devices/6A0D4244-1DEB-49C3-9837-C08E19DAED31/data/Media/DCIM/100APPLE/IMG_0011.mp4";
    } else if (Platform.isAndroid) {
      videoFilePath = "storage/emulated/0/Geocam/Videos/4.mp4";
    }
    var a = await videoInfo.getVideoInfo(videoFilePath);
    setState(() {
      info =
          "title=> ${a!.title}\npath=> ${a.path}\nauthor=> ${a.author}\nmimetype=> ${a.mimetype}";
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.white,
            label: Text(
              "Get Info",
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(
              Icons.video_call_outlined,
              color: Colors.purple,
            ),
            onPressed: () {
              getVideoInfo();
            }),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: const Text('Video Info'),
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
