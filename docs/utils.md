
## Screen Utils
When use:
- You you want to check if the current device is a tablet or smartphone.
- Check the device orientation.
- Get App Theme.
- Get Text Theme.
- MediaQuery options.

How to use:
Just import the screen module.
```dart
import 'package:flutter_meedu/screen.dart';
```
Now you can use the `BuildContext`'s extensions.

```
context.width;
context.height;
context.orientation;
context.isTablet;
context.isLandscape;
.
.
.
AND MORE.
```


## Platform Utils
Use this module when you want check if your are on iOS,Android, macOS, web, etc.

```dart
import 'package:flutter_meedu/platform.dart';

GetPlatform.isAndroid;
GetPlatform.isIOS;
.
.
.
AND MORE.
```