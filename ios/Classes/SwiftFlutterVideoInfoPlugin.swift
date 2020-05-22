import Flutter
import UIKit
import AVFoundation
import MobileCoreServices

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
       let path = myArgs["path"] as? String {
     getVidInfo(path: path, result: result)
    }
  }

  private func getVidInfo(path: String, result: FlutterResult) {
    let url = URL(fileURLWithPath: path)
    let asset = AVURLAsset(url: url)

    let creationDate = asset.creationDate?.value as! Date

    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.locale = Locale.current
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let durationTime = TimeInterval(round(Float(asset.duration.value) / Float(asset.duration.timescale)))

    let tracks = asset.tracks(withMediaType: .video)
    let fps = tracks.first?.nominalFrameRate
    let size = tracks.first?.naturalSize
    let mimetype = mimeTypeForPath(path: path)

    var fileSize : UInt64 = 0

    do {
        let attr = try FileManager.default.attributesOfItem(atPath: path)
        fileSize = attr[FileAttributeKey.size] as! UInt64
        let dict = attr as NSDictionary
        fileSize = dict.fileSize()
    } catch {
        print("Error: \(error)")
    }

    var jsonObj = Dictionary<String,Any>()
    jsonObj["path"] = path
    jsonObj["title"] = asset.url.lastPathComponent
    jsonObj["mimetype"] = mimetype
    jsonObj["author"] = ""
    jsonObj["date"] = formatter.string(from: creationDate)
    jsonObj["width"] = size?.width
    jsonObj["height"] = size?.height
    jsonObj["location"] = ""
    jsonObj["framerate"] = fps
    jsonObj["duration"] = durationTime
    jsonObj["filesize"] = fileSize
    //jsonObj["orientation"] = ""

    do {
        let jsonData = try JSONSerialization.data(withJSONObject: jsonObj)
        let jsonStr = String(bytes: jsonData, encoding: .utf8)!
        result(jsonStr)
    } catch (let e) {
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
