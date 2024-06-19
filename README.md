

Codecore Rest Api
================================================================================

CC Rest Api is a Dart package that facilitates communication with REST APIs.
It allows sending and receiving HTTP requests and provides configurable options.
The biggest purpose in its development is to move the entire architecture
from methods to class structure in order to eliminate code complexity.


> **NOTE:** It currently supports `GET`, `POST` and `DELETE` operations.

**For more detailed information:**
https://ferhaterdem.medium.com/simplify-your-rest-api-calls-with-cc-rest-api-in-dart-1e944e7ea9ab

Usage
================================================================================

Initialization
----------------------------------------


First, you need to initialize CC Rest Api with REST API configurations and
`request/response` logging options. Below is an example initialization:


``` dart
import 'package:cc_rest_api/cc_rest_api.dart';

void main() {
  CCRestApi.init(
    restOptions: CCRestOptions(
      baseUrl: "httpbin.org",
      defaultHeaders: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "*",
        "Content-Type": "application/json",
      },
    ),
    loggingOptions: CCRestLogging(
      logEnabled: true,
      onRequest: (handler) => print("Request: $handler"),
      onResponse: (handler) => print("Response: $handler"),
      onError: (handler) => print("Error: $handler"),
    ),
    modules: [
      GetUser(const CCApiConfig("user/get", RequestType.GET, NetworkType.HTTPS)),
      // Other modules can be added here
    ],
  );
}
```


> **NOTE:** This README uses long form, not all parameters are mandatory.



Modules and Usage
================================================================================

Creating Modules
----------------------------------------


You can create modules to represent each API operation.
These modules handle request configurations and response processing.


``` dart
class GetUser extends CCApiModule {
  GetUser(CCApiConfig config) : super(config);

  @override
  Future<Map<String, dynamic>> request() async {
    return await super.request();
  }

  @override
  response(dynamic data) {
    // Processing logic for the received data can go here
  }
}
```

`or`

``` dart
class GetUser extends CCApiModule {
  GetUser(CCApiConfig config) : super(config);

  @override
  response(dynamic data) {
    // Processing logic for the received data can go here
  }
}
```

> **NOTE:** It is not mandatory to override the request method.
> You can use it if you want to customize it.



Using Modules
----------------------------------------


You can `easily` make API requests using the modules you've created:

``` dart
import 'package:cc_rest_api/cc_rest_api.dart';

void main() {
  GetUser getUser = CCRestApi.getModule<GetUser>();
  getUser.setHeaders({
    "Authorization": "Bearer your_access_token",
  });
  getUser.setParameters({
    "param1": "value1",
    "param2": "value2",
  });
  getUser.setBody({
    "firebaseToken": "testFT",
    "user_id": "test",
  });

  getUser.request(); //It triggers request. It can return the response value.
}
```

In the above example, the GetUser module is used to make a `GET` or `POST` request,
and actions can be taken based on the response or error.



License
================================================================================


This package is licensed under the BSD-3-Clause License. For more details, please refer to the LICENSE file.



Installation
================================================================================


Grab it from [pub.dev](https://pub.dev/packages/cc_rest_api/install).
