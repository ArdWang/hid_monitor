
## 0.0.5

* Modify macOS bug

## 0.0.4

* Update the bug where the plugin doesn't work and check code

## 0.0.3

* Update the bug where the plugin doesn't work

## 0.0.2

* Update hid_monitor document


## 0.0.1

* Initial release of hid_monitor
* Cross-platform HID (Human Interface Device) listening library
* Support for Windows, macOS, and Linux platforms
* Keyboard event monitoring with platform-aware key mapping
* Mouse event monitoring (move, wheel, button events)
* Built with FFI for native performance
* Explicit backend initialization controlled by user

### Features

- **Keyboard Listening**: Register keyboard listeners to capture key events across the system
- **Mouse Listening**: Register mouse listeners to capture mouse movement, scroll, and button events
- **Cross-Platform**: Supports Windows, macOS, and Linux with native backend implementations
- **Platform-Aware**: Keyboard events are now platform-aware with proper key mapping for each OS
- **High Performance**: Uses FFI (Foreign Function Interface) for direct native library access

### Platform Support

| Platform | Status |
|----------|--------|
| Windows  | ✓      |
| macOS    | ✓      |
| Linux    | ✓      |

### Technical Details

- SDK Requirements: Dart >=3.0.0, Flutter >=2.5.0
- Dependencies: `flutter`, `plugin_platform_interface`, `ffi`
- Native libraries required for each platform
