# silentauth_sdk_flutter

[![License][license-image]][license-url]

The only purpose of the SDK is to force the data cellular connectivity prior to call a public URL, and will return the following JSON response

* **Success**
When the data connectivity has been achieved and a response has been received from the url endpoint
```
{
"http_status": string, // HTTP status related to the url
"response_body" : { // optional depending on the HTTP status
           ... // the response body of the opened url
           ... // see API doc for /device_ip and /redirect
                },
"debug" : {
    "device_info": string,
    "url_trace" : string
          }
}
```

* **Error**
When data connectivity is not available and/or an internal SDK error occurred

```
{
"error" : string,
"error_description": string
"debug": {
    "device_info": string,
    "url_trace" : string
          }
}
```
Potential error codes: `sdk_no_data_connectivity`, `sdk_connection_error`, `sdk_redirect_error`, `sdk_error`.


## Installation

To add the package `silentauth_sdk_flutter` to your app project:

1. Depend on it. Open the `pubspec.yaml` file located inside the app folder and add the following under the dependencies heading:

```yaml
	`silentauth_sdk_flutter: ^x.y.z`
```

2. Install it
   - From the terminal: Run:
   ```bash
   flutter pub get
   ```
   - From Android Studio/IntelliJ: Click **Packages get** in the action ribbon at the top of pubspec.yaml.
   - From VS Code: Click **Get Packages** located in right side of the action ribbon at the top of pubspec.yaml.

## Compatibility

- [Android](../silentauth-sdk-android#compatibility)
- [iOS](../silentauth-sdk-ios#compatibility)


## Usage

* Is the device eligible for silent authentication?

```dart
import 'package:silentauth_sdk_flutter/silentauth_sdk_flutter.dart';

// ...
// retrieve access token with coverage scope from back-end
   var token = ...
// open the device_ip public API endpoint
   SilentauthSdkFlutter sdk = SilentauthSdkFlutter();
   try {
   Map reach = await sdk.openWithDataCellularAndAccessToken(
   "https://eu.api.silentauth.com/coverage/v0.1/device_ip", token, true);
   if (reach.containsKey("error")) {
// Network connectivity error
   } else if (reach.containsKey("http_status")) {
    if (reach["http_status"] == 200 && reach["response_body"] != null) {
      Map<dynamic, dynamic>body = reach["response_body"];
      Coverage cv = Coverage.fromJson(body);
      } else if (reach["status"] == 400 && reach["response_body"] != null) {
// MNO not supported see ${body.detail}
     } else if (reach["status"] == 412 && reach["response_body"] != null) {
// Not a mobile IP see ${body.detail}
    } else if (reach["response_body"] != null) {
// other error see ${body.detail}
      }
    }
    }
```
* How to open a check URL 
```dart
import 'package:silentauth_sdk_flutter/silentauth_sdk_flutter.dart';

// ...
   SilentauthSdkFlutter sdk = SilentauthSdkFlutter();

   Map result = await sdk.openWithDataCellular(checkUrl, false);
      if (result.containsKey("error")) {
         // error
      } else if (result["http_status"] == 200 && result["response_body"] != null) {
         if (result["response_body"].containsKey("error")) {
                        CheckErrorBody errorBody = CheckErrorBody.fromJson(body);
                      // error see ${body.error_description}
                     } else {
                         CheckSuccessBody successBody = CheckSuccessBody.fromJson(body);
                        // send code, check_id and reference_id to back-end
                        // to trigger a PATCH /checks/{check_id}
                     }
                  } else {
                     // other error see ${body.detail}
                  }
            }

```

## Example Demo

There's an embedded example demo is located in the `example` directory, see [README](./example/README.md)


## Meta

Distributed under the MIT license. See `LICENSE` for more information.

[https://github.com/silentauth](https://github.com/silentauth)
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
