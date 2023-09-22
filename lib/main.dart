import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _sharedText = "";

  @override
  void initState() {
    super.initState();

    // For sharing or opening URLs/text.
    ReceiveSharingIntent.getTextStream().listen((String? value) {
      if (value != null) {
        setState(() {
          _sharedText = value;
        });
      }
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // If the app was terminated, then this will extract the shared data
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null) {
        setState(() {
          _sharedText = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Receive Sharing Intent")),
        body: Center(
          child: Text("Shared text: $_sharedText"),
        ),
      ),
    );
  }
}
