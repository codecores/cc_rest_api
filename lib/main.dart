// ignore_for_file: avoid_print

import 'package:cc_rest_api/api/enums/network_type.dart';
import 'package:cc_rest_api/api/enums/request_type.dart';
import 'package:cc_rest_api/api/models/api_config.dart';
import 'package:cc_rest_api/cc_rest_api.dart';
import 'package:cc_rest_api/cc_rest_options.dart';
import 'package:cc_rest_api/api/providers/user/get_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
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
        onRequest: (handler) => print(handler),
        onResponse: (handler) => print(handler),
        onError: (handler) => print(handler),
      ),
      modules: [
        GetUser(const CCApiConfig("get", RequestType.GET, NetworkType.HTTPS)),
      ],
    );

    GetUser getUser = CCRestApi.getModule<GetUser>();
    getUser.setHeaders({});
    getUser.setParameters({});
    getUser.setBody(
      {
        "firebaseToken ": "testFT",
        "user_id ": "test",
      },
    );
    super.initState();
    getUser.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
