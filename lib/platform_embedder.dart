import 'package:flutter/services.dart';

class PlatformEmbedder{
  final channel = MethodChannel("sendData");

  Future<void> sendDataTonNative() async{
    final msg = await channel.invokeMethod("start",'arguments');
    receiveDataFromNative();
  }

  void receiveDataFromNative() {
    channel.setMethodCallHandler(receiveFromNative);
  }

  Future<void> receiveFromNative(MethodCall call) async{
    if (call.method == 'flutterMethod' ){
      flutterMethod(call.arguments);
    }
  }

  void flutterMethod(String arg) {
    print('call from native with $arg');
  }
}
