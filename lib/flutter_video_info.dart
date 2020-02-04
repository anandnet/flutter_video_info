library flutter_video_info;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class FlutterVideoInfo {
  static const MethodChannel _channel = const MethodChannel('flutter_video_info');

  Future<VideoData> getVideoInfo(String path) async {
    assert(path != null);
    try {
      final jsonStr = await _channel.invokeMethod('getVidInfo', {"path": path});
      final jsonMap = json.decode(jsonStr);
      return VideoData.fromJson(jsonMap);
    } catch (e) {
      print(e);
      print(
          "[VideoInfoError:]\n----Check video path\n----Check External Storage Permission(in case reading data from external storage)\n");
    }
  }
}

class VideoData {
  String path;

  /// string
  String title;

  /// string
  String author;

  /// string
  String mimetype;

  /// string
  String date;

  /// string
  String location;

  /// double
  double framerate;

  /// int
  int width;

  /// int
  int height;

  /// [Android] API level 17, (0,90,180)
  int orientation;

  /// bytes
  int filesize;

  /// millisecond
  double duration;

  VideoData({
    @required this.path,
    this.title,
    this.author,
    this.mimetype,
    this.date,
    this.location,
    this.framerate,
    this.width,
    this.height,
    this.orientation,
    this.filesize,
    this.duration,
  });

  VideoData.fromJson(Map<String, dynamic> json) {
    path = (json['path']);
    title = (json['title'] != null)
        ? json['title']
        : (basename(json['path']).split(".")[0]);
    mimetype = (json["mimetype"]);
    date = ((json["date"]).replaceAll("T", " ")).replaceAll("Z", "");
    location = (json["location"]);
    framerate = double.tryParse("${json["framerate"]}");
    author = (json['author']);
    width = int.tryParse('${json['width']}');
    height = int.tryParse('${json['height']}');
    orientation =
        (json['orientation'] != null) ? int.parse(json["orientation"]) : null;
    filesize = json['filesize'];
    duration = double.tryParse('${json['duration']}');
  }
}
