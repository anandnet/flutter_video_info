# flutter_video_info_example

```Dart
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final flutterVideoInfo = FlutterVideoInfo();

  String info = "";

  getVideoInfo() async {
    /// here file path of video required
    String videoFilePath = "your_video_file_path";
    var a = await flutterVideoInfo.getVideoInfo(videoFilePath);
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
```
