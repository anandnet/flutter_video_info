package com.example.flutter_video_info;

import android.content.Context;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.Build;

import androidx.annotation.NonNull;

import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.io.*;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterVideoInfoPlugin
 */
public class FlutterVideoInfoPlugin implements FlutterPlugin, MethodCallHandler {
    public  Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(),
                "flutter_video_info");
        channel.setMethodCallHandler(new FlutterVideoInfoPlugin());
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getVidInfo")) {
            String path = call.argument("path");
            result.success(getVidInfo(path));
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }

    String getVidInfo(String path) {
        File file = new File(path);
        boolean isFileExists=file.exists();
        String author,dateString,mimeType,location,frameRateStr,widthStr,heightStr,durationStr,orientation;
        double filesize;
        if(isFileExists){
            MediaMetadataRetriever mediaRetriever = new MediaMetadataRetriever();
            try {
                mediaRetriever.setDataSource(context, Uri.fromFile(file));
            } catch (Exception e) {
                e.printStackTrace();
            }
            

            author = getData(MediaMetadataRetriever.METADATA_KEY_AUTHOR, mediaRetriever);
            dateString = getData(MediaMetadataRetriever.METADATA_KEY_DATE, mediaRetriever);
            try {
                SimpleDateFormat readFormat = new SimpleDateFormat("yyyyMMdd'T'HHmmss.SSS", Locale.getDefault());
                Date date = readFormat.parse(dateString);
                SimpleDateFormat outFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());
                assert date != null;
                dateString = outFormat.format(date);
            } catch (Exception e) {
                e.printStackTrace();
            }

            mimeType = getData(MediaMetadataRetriever.METADATA_KEY_MIMETYPE, mediaRetriever);
            location = getData(MediaMetadataRetriever.METADATA_KEY_LOCATION, mediaRetriever);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                frameRateStr = getData(MediaMetadataRetriever.METADATA_KEY_CAPTURE_FRAMERATE, mediaRetriever);
            }else{
                frameRateStr="";
            }
            durationStr = getData(MediaMetadataRetriever.METADATA_KEY_DURATION, mediaRetriever);
            widthStr = getData(MediaMetadataRetriever.METADATA_KEY_VIDEO_WIDTH, mediaRetriever);
            heightStr = getData(MediaMetadataRetriever.METADATA_KEY_VIDEO_HEIGHT, mediaRetriever);
            filesize = file.length();
            orientation = getData(MediaMetadataRetriever.METADATA_KEY_VIDEO_ROTATION, mediaRetriever);

            try {
                 mediaRetriever.release();
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        }else{
            author="";
            dateString="";
            mimeType="";
            location="";
            frameRateStr="";
            widthStr="";
            heightStr="";
            durationStr="";
            orientation="";
            filesize=0;
        }

        JSONObject json = new JSONObject();
        try {
            json.put("path", path);
            json.put("mimetype", mimeType);
            json.put("author", author);
            json.put("date", dateString);
            json.put("width", widthStr);
            json.put("height", heightStr);
            json.put("location", location);
            json.put("framerate", frameRateStr);
            json.put("duration", durationStr);
            json.put("filesize", filesize);
            json.put("orientation", orientation);
            json.put("isfileexist",isFileExists);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return json.toString();
    }

    String getData(int key, MediaMetadataRetriever mediaRetriever) {
        try {
            return mediaRetriever.extractMetadata(key);
        } catch (Exception e) {
            return null;
        }
    }

}
