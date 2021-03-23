import AVFoundation
import Flutter
import MobileCoreServices
import UIKit

public class SwiftFlutterVideoInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_video_info", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterVideoInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "getVidInfo" else {
      result(FlutterMethodNotImplemented)
      return
    }

    guard let args = call.arguments else {
      return
    }

    if let myArgs = args as? [String: Any],
       let path = myArgs["path"] as? String
    {
      getVidInfo(path: path, result: result)
    }
  }

  private func getVidInfo(path: String, result: FlutterResult) {
    let url = URL(fileURLWithPath: path)
    let asset = AVURLAsset(url: url)
    let fileManager = FileManager.default
    let isFileExist = fileManager.fileExists(atPath: path)

    let creationDate = asset.creationDate?.dateValue

    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let durationTime = round(CMTimeGetSeconds(asset.duration) * 1000)

    let tracks = asset.tracks(withMediaType: .video)
    let fps = tracks.first?.nominalFrameRate
    let size = tracks.first?.naturalSize
    let mimetype = mimeTypeForPath(path: path)
    let orientation = asset.orientation

    var fileSize: UInt64 = 0

    do {
      let attr = try FileManager.default.attributesOfItem(atPath: path)
      fileSize = attr[FileAttributeKey.size] as! UInt64
      let dict = attr as NSDictionary
      fileSize = dict.fileSize()
    } catch {
      print("Error: \(error)")
    }

    var jsonObj = [String: Any]()
    jsonObj["path"] = path
    jsonObj["mimetype"] = mimetype
    jsonObj["author"] = ""
    if let date = creationDate {
      jsonObj["date"] = formatter.string(from: date)
    } else {
      jsonObj["date"] = ""
    }
    jsonObj["width"] = size?.width
    jsonObj["height"] = size?.height
    jsonObj["location"] = ""
    jsonObj["framerate"] = fps
    jsonObj["duration"] = durationTime
    jsonObj["filesize"] = fileSize
    jsonObj["orientation"] = orientation
    jsonObj["isfileexist"] = isFileExist

    do {
      let jsonData = try JSONSerialization.data(withJSONObject: jsonObj)
      let jsonStr = String(bytes: jsonData, encoding: .utf8)!
      result(jsonStr)
    } catch let e {
      result(e)
    }
  }

  private func mimeTypeForPath(path: String) -> String {
    let url = NSURL(fileURLWithPath: path)
    let pathExtension = url.pathExtension

    if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
      if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
        return mimetype as String
      }
    }
    return "application/octet-stream"
  }
}

extension AVURLAsset {
  var orientation: String {
    guard let tf = tracks(withMediaType: AVMediaType.video).first?.preferredTransform else {
      return ""
    }

    if tf.a == 0, tf.b == 1.0, tf.d == 0 {
      return "90"
    } else if tf.a == 0, tf.b == -1.0, tf.d == 0 {
      return "270"
    } else if tf.a == 1.0, tf.b == 0, tf.c == 0 {
      return "0"
    } else if tf.a == -1.0, tf.b == 0, tf.c == 0 {
      return "180"
    }
    return ""
  }
}
