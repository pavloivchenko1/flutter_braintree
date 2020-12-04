import 'package:flutter/material.dart';
import 'dart:async';

import 'package:braintree_module/braintree_module.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> initBraintree() async {
    String paymentToken = 'eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjSEp2WkhWamRHbHZiaUlzSW1semN5STZJa0YxZEdoNUluMC5leUpsZUhBaU9qRTFOekkwTkRFM016TXNJbXAwYVNJNklqRTFOMlJsWWpKaExUVTJaak10TkRoa1lpMWhObU00TFRrd1lUSXlOelZrWldSa1l5SXNJbk4xWWlJNklqaDNNMmgzZVdKMmFHZGtjbVkxZUhraUxDSnBjM01pT2lKQmRYUm9lU0lzSW0xbGNtTm9ZVzUwSWpwN0luQjFZbXhwWTE5cFpDSTZJamgzTTJoM2VXSjJhR2RrY21ZMWVIa2lMQ0oyWlhKcFpubGZZMkZ5WkY5aWVWOWtaV1poZFd4MElqcDBjblZsZlN3aWNtbG5hSFJ6SWpwYkltMWhibUZuWlY5MllYVnNkQ0pkTENKdmNIUnBiMjV6SWpwN0ltTjFjM1J2YldWeVgybGtJam9pTVRJNE1URXpNVFkyTVNKOWZRLmZ0akltMG9Ha1pXOTlDN0RnWnNxN1AxSXh5ZE83RjlCaGVfSncxVkJETDNZNkgzTkpwZVBBdVVnVjJLdjZEbDh5Q1RDSXFGN1JYRHhMUFFSRFVySlRRP2N1c3RvbWVyX2lkPSIsImNvbmZpZ1VybCI6Imh0dHBzOi8vYXBpLmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvOHczaHd5YnZoZ2RyZjV4eS9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuYnJhaW50cmVlLWFwaS5jb20vZ3JhcGhxbCIsImRhdGUiOiIyMDE4LTA1LTA4In0sImNoYWxsZW5nZXMiOlsiY3Z2Il0sImVudmlyb25tZW50IjoicHJvZHVjdGlvbiIsImNsaWVudEFwaVVybCI6Imh0dHBzOi8vYXBpLmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvOHczaHd5YnZoZ2RyZjV4eS9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLmNvbSIsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL2NsaWVudC1hbmFseXRpY3MuYnJhaW50cmVlZ2F0ZXdheS5jb20vOHczaHd5YnZoZ2RyZjV4eSJ9LCJ0aHJlZURTZWN1cmVFbmFibGVkIjpmYWxzZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiSGVhbHRoZG9tIiwiY2xpZW50SWQiOiJBYnZudGw5TG44WHFBNlNFRzhxYUhIejFNZXlMM0tfNkU1QjE2VGhRUVkxS1Z6YXEyRTdJSU5qUGhnMWhrRllKR1Z4WEIyMlF0VEQtbWZnSCIsInByaXZhY3lVcmwiOiJodHRwczovL3d3dy5oZWFsdGhkb20uY29tL3ByaXZhY3ktcG9saWN5IiwidXNlckFncmVlbWVudFVybCI6Imh0dHBzOi8vd3d3LmhlYWx0aGRvbS5jb20vdGVybXMtb2Ytc2VydmljZSIsImJhc2VVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFzc2V0c1VybCI6Imh0dHBzOi8vY2hlY2tvdXQucGF5cGFsLmNvbSIsImRpcmVjdEJhc2VVcmwiOm51bGwsImFsbG93SHR0cCI6ZmFsc2UsImVudmlyb25tZW50Tm9OZXR3b3JrIjpmYWxzZSwiZW52aXJvbm1lbnQiOiJsaXZlIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoiQVJLcllSRGgzQUdYRHpXN3NPXzNiU2txLVUxQzdIR191V05DLXo1N0xqWVNETlVPU2FPdElhOXE2VnBXIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6IkhlYWx0aGRvbV9pbnN0YW50IiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn0sIm1lcmNoYW50SWQiOiI4dzNod3lidmhnZHJmNXh5IiwidmVubW8iOiJvZmYifQ==';
    String paymentResult = await BraintreeModule().initBraintree(paymentToken);
    print('Payment result $paymentResult');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('Init Braintree'),
            onPressed: () => {
              initBraintree()
            },
          )
        ),
      ),
    );
  }
}
