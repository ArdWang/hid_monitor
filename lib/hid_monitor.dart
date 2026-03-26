/// A cross-platform Flutter plugin for monitoring HID (Human Interface Device) events.
///
/// This plugin provides global keyboard and mouse event monitoring on
/// Windows, macOS, and Linux platforms using FFI (Foreign Function Interface)
/// to communicate with native libraries.
///
/// ## Features
///
/// - Keyboard event monitoring (key down/up)
/// - Mouse event monitoring (movement, buttons, scroll wheel)
/// - Cross-platform support (Windows, macOS, Linux)
/// - High-performance native library access
///
/// ## Getting Started
///
/// ```dart
/// import 'package:hid_monitor/hid_monitor.dart';
///
/// void main() async {
///   final backend = getListenerBackend();
///   if (backend != null && backend.initialize()) {
///     backend.addKeyboardListener((event) {
///       print('Key event: $event');
///     });
///     backend.addMouseListener((event) {
///       print('Mouse event: $event');
///     });
///   }
/// }
/// ```
///
/// ## Platform Support
///
/// | Platform | Status |
/// |----------|--------|
/// | Windows  | ✓      |
/// | macOS    | ✓      |
/// | Linux    | ✓      |
///
/// ## References
///
/// This project uses native libraries from [hid_listener](https://github.com/localcc/hid_listener).
library hid_monitor;

export 'src/hid_monitor.dart';
