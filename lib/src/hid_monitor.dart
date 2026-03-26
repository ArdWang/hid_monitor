// ignore_for_file: deprecated_member_use

import 'dart:collection';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:hid_monitor/src/macos/hid_monitor_macos.dart';
import 'package:hid_monitor/src/windows/hid_monitor_windows.dart';
import 'package:hid_monitor/src/linux/hid_monitor_linux.dart';

import 'hid_monitor_types.dart';
export 'hid_monitor_types.dart'
    show
        MouseEvent,
        MouseButtonEventType,
        MouseButtonEvent,
        MouseMoveEvent,
        MouseWheelEvent;

/// The name of the native library used for HID monitoring.
const String _libName = 'hid_monitor';

/// The dynamic library handle for the native HID monitor library.
///
/// This library is loaded based on the current platform:
/// - macOS/iOS: Loads the framework version
/// - Android/Linux: Loads the .so library
/// - Windows: Loads the .dll library
final ffi.DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return ffi.DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return ffi.DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// Abstract base class for HID listener backends.
///
/// This class provides the interface for platform-specific implementations
/// of keyboard and mouse event monitoring. It handles listener registration,
/// removal, and the underlying native communication.
///
/// Example usage:
/// ```dart
/// final backend = getListenerBackend();
/// if (backend != null) {
///   backend.initialize();
///   backend.addKeyboardListener((event) {
///     print('Key pressed: ${event.logicalKey}');
///   });
/// }
/// ```
abstract class HidListenerBackend {
  /// Adds a keyboard event listener and returns the listener ID.
  ///
  /// The [listener] callback will be invoked for each keyboard event
  /// (key down and key up) detected by the system.
  ///
  /// Returns a unique listener ID that can be used to remove this listener
  /// later, or `null` if the backend failed to register for keyboard events.
  ///
  /// Example:
  /// ```dart
  /// final listenerId = backend.addKeyboardListener((RawKeyEvent event) {
  ///   if (event is RawKeyDownEvent) {
  ///     print('Key down: ${event.logicalKey}');
  ///   }
  /// });
  /// ```
  int? addKeyboardListener(void Function(RawKeyEvent) listener) {
    if (!_keyboardRegistered) {
      if (!registerKeyboard()) return null;
      _keyboardRegistered = true;
    }

    keyboardListeners.addAll({_lastKeyboardListenerId: listener});
    return _lastKeyboardListenerId++;
  }

  /// Removes a keyboard listener by its ID.
  ///
  /// The [listenerId] should be the value returned from
  /// [addKeyboardListener] when the listener was registered.
  ///
  /// After removal, the listener will no longer receive keyboard events.
  void removeKeyboardListener(int listenerId) {
    keyboardListeners.remove(listenerId);
  }

  /// Adds a mouse event listener and returns the listener ID.
  ///
  /// The [listener] callback will be invoked for each mouse event
  /// (movement, button clicks, and scroll wheel) detected by the system.
  ///
  /// Returns a unique listener ID that can be used to remove this listener
  /// later, or `null` if the backend failed to register for mouse events.
  ///
  /// Example:
  /// ```dart
  /// final listenerId = backend.addMouseListener((MouseEvent event) {
  ///   print('Mouse event: ${event.x}, ${event.y}');
  /// });
  /// ```
  int? addMouseListener(void Function(MouseEvent) listener) {
    if (!_mouseRegistered) {
      if (!registerMouse()) return null;
      _mouseRegistered = true;
    }

    mouseListeners.addAll({_lastMouseListenerId: listener});
    return _lastMouseListenerId++;
  }

  /// Removes a mouse listener by its ID.
  ///
  /// The [listenerId] should be the value returned from
  /// [addMouseListener] when the listener was registered.
  ///
  /// After removal, the listener will no longer receive mouse events.
  void removeMouseListener(int listenerId) {
    mouseListeners.remove(listenerId);
  }

  /// Initializes the native backend for event monitoring.
  ///
  /// This method must be called before adding any keyboard or mouse listeners.
  /// It sets up the necessary native resources and event hooks.
  ///
  /// Returns `true` if initialization was successful, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// final backend = getListenerBackend();
  /// if (backend != null && backend.initialize()) {
  ///   // Ready to add listeners
  /// }
  /// ```
  bool initialize();

  /// Registers for keyboard events at the native level.
  ///
  /// This is called internally when the first keyboard listener is added.
  /// Subclasses should implement this to set up platform-specific
  /// keyboard event hooks.
  ///
  /// Returns `true` if registration was successful, `false` otherwise.
  bool registerKeyboard();

  /// Registers for mouse events at the native level.
  ///
  /// This is called internally when the first mouse listener is added.
  /// Subclasses should implement this to set up platform-specific
  /// mouse event hooks.
  ///
  /// Returns `true` if registration was successful, `false` otherwise.
  bool registerMouse();

  /// Map of registered keyboard listeners.
  ///
  /// This is protected and available for subclasses to access
  /// when dispatching keyboard events to registered listeners.
  @protected
  HashMap<int, void Function(RawKeyEvent)> keyboardListeners =
      HashMap.identity();

  /// Map of registered mouse listeners.
  ///
  /// This is protected and available for subclasses to access
  /// when dispatching mouse events to registered listeners.
  @protected
  HashMap<int, void Function(MouseEvent)> mouseListeners = HashMap.identity();

  /// The ID to assign to the next keyboard listener.
  int _lastKeyboardListenerId = 0;

  /// The ID to assign to the next mouse listener.
  int _lastMouseListenerId = 0;

  /// Whether keyboard events have been registered.
  bool _keyboardRegistered = false;

  /// Whether mouse events have been registered.
  bool _mouseRegistered = false;
}

/// Creates a platform-specific backend implementation.
///
/// Returns the appropriate [HidListenerBackend] subclass based on the
/// current operating system:
/// - Windows: [WindowsHidListenerBackend]
/// - macOS: [MacOsHidListenerBackend]
/// - Linux: [LinuxHidListenerBackend]
/// - Other platforms: `null`
///
/// This function is called internally during initialization.
HidListenerBackend? _createPlatformBackend() {
  if (Platform.isWindows) return WindowsHidListenerBackend(_dylib);
  if (Platform.isMacOS) return MacOsHidListenerBackend(_dylib);
  if (Platform.isLinux) return LinuxHidListenerBackend(_dylib);
  return null;
}

/// The global HID listener backend instance.
///
/// This is initialized based on the current platform when the library
/// is first loaded. Use [getListenerBackend] to access this instance.
HidListenerBackend? _backend = _createPlatformBackend();

/// Returns the global listener backend instance.
///
/// This function provides access to the platform-specific backend that
/// handles keyboard and mouse event monitoring. The backend is automatically
/// initialized based on the current platform.
///
/// Returns `null` if the current platform is not supported (e.g., web,
/// Android, iOS).
///
/// Example:
/// ```dart
/// final backend = getListenerBackend();
/// if (backend == null) {
///   print('HID monitoring is not supported on this platform');
///   return;
/// }
///
/// if (!backend.initialize()) {
///   print('Failed to initialize backend');
///   return;
/// }
///
/// backend.addKeyboardListener((event) {
///   print('Key event: $event');
/// });
/// ```
HidListenerBackend? getListenerBackend() {
  return _backend;
}
