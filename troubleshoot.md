# Troubleshooting

####  For Android 10 
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
