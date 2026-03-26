import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hid_listener/hid_listener.dart';

// ignore: deprecated_member_use
void listener(RawKeyEvent event) {
  debugPrint(
      // ignore: deprecated_member_use
      "${event is RawKeyDownEvent} ${event.logicalKey.debugName} ${HardwareKeyboard.instance.isShiftPressed} ${HardwareKeyboard.instance.isAltPressed} ${HardwareKeyboard.instance.isControlPressed}");
}

void mouseListener(MouseEvent event) {
  debugPrint("$event");
}

var registerResult = "";

void main() {
  if (!getListenerBackend()!.initialize()) {
    debugPrint("Failed to initialize listener backend");
  }

  getListenerBackend()!.addKeyboardListener(listener);
  getListenerBackend()!.addMouseListener(mouseListener);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(registerResult),
        ),
      ),
    );
  }
}
