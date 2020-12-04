import 'package:flutter/services.dart';

class BraintreeModule {
  static const MethodChannel _channel =
      const MethodChannel('braintree_module');


  initBraintree(String paymentToken) async {
    final args = <String, dynamic>{'paymentToken': paymentToken};
    String paymentResult = await _channel.invokeMethod('init', args);
    return paymentResult;
  }


}
