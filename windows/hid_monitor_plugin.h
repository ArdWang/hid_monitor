#ifndef FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_H_
#define FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace hid_monitor {

class HidMonitorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  HidMonitorPlugin();

  virtual ~HidMonitorPlugin();

  // Disallow copy and assign.
  HidMonitorPlugin(const HidMonitorPlugin&) = delete;
  HidMonitorPlugin& operator=(const HidMonitorPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace hid_monitor

#endif  // FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_H_
