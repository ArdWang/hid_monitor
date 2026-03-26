# hid_monitor

[![Pub Version](https://img.shields.io/pub/v/hid_monitor)](https://pub.dev/packages/hid_monitor)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A cross-platform Flutter plugin for monitoring HID (Human Interface Device) events including keyboard and mouse input.

---

## English

### Overview

`hid_monitor` is a Flutter plugin that allows you to listen to global keyboard and mouse events on Windows, macOS, and Linux platforms. Built with FFI (Foreign Function Interface) for high-performance native communication.

### Features

- 🎹 **Keyboard Monitoring** - Capture global key down/up events
- 🖱️ **Mouse Monitoring** - Capture mouse movement, scroll, and button events
- 🌐 **Cross-Platform** - Works on Windows, macOS, and Linux
- ⚡ **High Performance** - Direct native library access via FFI
- 🔧 **Explicit Initialization** - Full control over backend initialization

### Installation

Add `hid_monitor` to your `pubspec.yaml`:

```yaml
dependencies:
  hid_monitor:
    path: ../hid_monitor  # or use published version
    # hid_monitor: ^0.0.1
```

### Platform Setup

#### Windows
- Requires `hid_monitor.dll` native library
- Place the DLL in your application directory

#### macOS
- Requires `hid_monitor.framework`
- The framework must be bundled with your application

#### Linux
- Requires `libhid_monitor.so`
- Ensure the library is in the library path or application directory

### Usage

#### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hid_monitor/hid_monitor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the listener backend
  final backend = getListenerBackend();
  if (backend == null) {
    debugPrint('hid_monitor is not supported on this platform');
    return;
  }

  if (!backend.initialize()) {
    debugPrint('Failed to initialize listener backend');
    return;
  }

  // Add keyboard listener
  backend.addKeyboardListener((RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      debugPrint('Key pressed: ${event.logicalKey}');
    }
  });

  // Add mouse listener
  backend.addMouseListener((MouseEvent event) {
    debugPrint('Mouse event: $event');
  });

  runApp(const MyApp());
}
```

#### Keyboard Events

```dart
backend.addKeyboardListener((RawKeyEvent event) {
  // Check event type
  if (event is RawKeyDownEvent) {
    debugPrint('Key Down: ${event.logicalKey}');
  } else if (event is RawKeyUpEvent) {
    debugPrint('Key Up: ${event.logicalKey}');
  }

  // Check modifier keys
  debugPrint('Shift: ${HardwareKeyboard.instance.isShiftPressed}');
  debugPrint('Control: ${HardwareKeyboard.instance.isControlPressed}');
  debugPrint('Alt: ${HardwareKeyboard.instance.isAltPressed}');
  debugPrint('Meta: ${HardwareKeyboard.instance.isMetaPressed}');
});
```

#### Mouse Events

```dart
backend.addMouseListener((MouseEvent event) {
  if (event is MouseButtonEvent) {
    // Handle button press/release
    debugPrint('Button: ${event.kind}');
  } else if (event is MouseMoveEvent) {
    // Handle mouse movement
    debugPrint('Position: (${event.x}, ${event.y})');
  } else if (event is MouseWheelEvent) {
    // Handle scroll wheel
    debugPrint('Scroll delta: ${event.wheelDelta}');
  }
});
```

#### Removing Listeners

```dart
// Store the listener ID when adding
final listenerId = backend.addKeyboardListener(myListener);

// Remove listener when no longer needed
if (listenerId != null) {
  backend.removeKeyboardListener(listenerId);
}
```

### API Reference

#### `getListenerBackend()`
Returns the platform-specific backend instance, or `null` if the platform is not supported.

#### `HidListenerBackend.initialize()`
Initializes the native backend. Must be called before adding any listeners. Returns `true` on success.

#### `HidListenerBackend.addKeyboardListener(void Function(RawKeyEvent) listener)`
Registers a keyboard event listener. Returns a listener ID or `null` on failure.

#### `HidListenerBackend.removeKeyboardListener(int listenerId)`
Removes a previously registered keyboard listener.

#### `HidListenerBackend.addMouseListener(void Function(MouseEvent) listener)`
Registers a mouse event listener. Returns a listener ID or `null` on failure.

#### `HidListenerBackend.removeMouseListener(int listenerId)`
Removes a previously registered mouse listener.

### Event Types

| Type | Description |
|------|-------------|
| `RawKeyDownEvent` | Key pressed down |
| `RawKeyUpEvent` | Key released |
| `MouseButtonEvent` | Mouse button pressed/released |
| `MouseMoveEvent` | Mouse position changed |
| `MouseWheelEvent` | Scroll wheel rotated |

### Important Notes

1. **Permissions**: On macOS, accessibility permissions may be required for global event monitoring.
2. **Background Execution**: Events are only captured while your application is running.
3. **Thread Safety**: All callbacks are executed on the main UI thread.
4. **Memory Management**: Always remove listeners when they are no longer needed.

### Troubleshooting

**Issue**: Backend initialization fails
- Ensure the native library is properly installed
- Check that your platform is supported (Windows/macOS/Linux only)

**Issue**: No events received
- Verify that `initialize()` was called successfully
- Check platform-specific permissions (especially on macOS)

---

## 中文

### 概述

`hid_monitor` 是一个 Flutter 插件，允许您在 Windows、macOS 和 Linux 平台上监听全局键盘和鼠标事件。使用 FFI（外部函数接口）构建，实现高性能的原生通信。

### 功能特性

- 🎹 **键盘监听** - 捕获全局按键按下/释放事件
- 🖱️ **鼠标监听** - 捕获鼠标移动、滚动和按键事件
- 🌐 **跨平台** - 支持 Windows、macOS 和 Linux
- ⚡ **高性能** - 通过 FFI 直接访问原生库
- 🔧 **显式初始化** - 完全控制后端初始化

### 安装

将 `hid_monitor` 添加到您的 `pubspec.yaml`:

```yaml
dependencies:
  hid_monitor:
    path: ../hid_monitor  # 或使用已发布的版本
    # hid_monitor: ^0.0.1
```

### 平台设置

#### Windows
- 需要 `hid_monitor.dll` 原生库
- 将 DLL 放置在应用程序目录中

#### macOS
- 需要 `hid_monitor.framework`
- 框架必须与应用程序一起打包

#### Linux
- 需要 `libhid_monitor.so`
- 确保库在库路径或应用程序目录中

### 使用方法

#### 基础示例

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hid_monitor/hid_monitor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化监听器后端
  final backend = getListenerBackend();
  if (backend == null) {
    debugPrint('此平台不支持 hid_monitor');
    return;
  }

  if (!backend.initialize()) {
    debugPrint('初始化监听器后端失败');
    return;
  }

  // 添加键盘监听器
  backend.addKeyboardListener((RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      debugPrint('按键按下：${event.logicalKey}');
    }
  });

  // 添加鼠标监听器
  backend.addMouseListener((MouseEvent event) {
    debugPrint('鼠标事件：$event');
  });

  runApp(const MyApp());
}
```

#### 键盘事件

```dart
backend.addKeyboardListener((RawKeyEvent event) {
  // 检查事件类型
  if (event is RawKeyDownEvent) {
    debugPrint('按键按下：${event.logicalKey}');
  } else if (event is RawKeyUpEvent) {
    debugPrint('按键释放：${event.logicalKey}');
  }

  // 检查修饰键
  debugPrint('Shift: ${HardwareKeyboard.instance.isShiftPressed}');
  debugPrint('Control: ${HardwareKeyboard.instance.isControlPressed}');
  debugPrint('Alt: ${HardwareKeyboard.instance.isAltPressed}');
  debugPrint('Meta: ${HardwareKeyboard.instance.isMetaPressed}');
});
```

#### 鼠标事件

```dart
backend.addMouseListener((MouseEvent event) {
  if (event is MouseButtonEvent) {
    // 处理按键按下/释放
    debugPrint('按钮：${event.kind}');
  } else if (event is MouseMoveEvent) {
    // 处理鼠标移动
    debugPrint('位置：(${event.x}, ${event.y})');
  } else if (event is MouseWheelEvent) {
    // 处理滚轮
    debugPrint('滚动增量：${event.wheelDelta}');
  }
});
```

#### 移除监听器

```dart
// 添加时存储监听器 ID
final listenerId = backend.addKeyboardListener(myListener);

// 不再需要时移除监听器
if (listenerId != null) {
  backend.removeKeyboardListener(listenerId);
}
```

### API 参考

#### `getListenerBackend()`
返回平台特定的后端实例，如果不支持该平台则返回 `null`。

#### `HidListenerBackend.initialize()`
初始化原生后端。必须在添加任何监听器之前调用。成功时返回 `true`。

#### `HidListenerBackend.addKeyboardListener(void Function(RawKeyEvent) listener)`
注册键盘事件监听器。返回监听器 ID，失败时返回 `null`。

#### `HidListenerBackend.removeKeyboardListener(int listenerId)`
移除之前注册的键盘监听器。

#### `HidListenerBackend.addMouseListener(void Function(MouseEvent) listener)`
注册鼠标事件监听器。返回监听器 ID，失败时返回 `null`。

#### `HidListenerBackend.removeMouseListener(int listenerId)`
移除之前注册的鼠标监听器。

### 事件类型

| 类型 | 描述 |
|------|------|
| `RawKeyDownEvent` | 按键按下 |
| `RawKeyUpEvent` | 按键释放 |
| `MouseButtonEvent` | 鼠标按键按下/释放 |
| `MouseMoveEvent` | 鼠标位置变化 |
| `MouseWheelEvent` | 滚轮旋转 |

### 重要说明

1. **权限**：在 macOS 上，全局事件监控可能需要辅助功能权限。
2. **后台执行**：仅在应用程序运行时捕获事件。
3. **线程安全**：所有回调都在主 UI 线程上执行。
4. **内存管理**：不再需要监听器时务必移除。

### 故障排除

**问题**：后端初始化失败
- 确保正确安装了原生库
- 检查您的平台是否受支持（仅限 Windows/macOS/Linux）

**问题**：未收到任何事件
- 验证 `initialize()` 是否成功调用
- 检查平台特定权限（尤其是在 macOS 上）

---

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
