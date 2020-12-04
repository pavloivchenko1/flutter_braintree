import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:braintree_module/braintree_module.dart';

void main() {
  const MethodChannel channel = MethodChannel('braintree_module');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
