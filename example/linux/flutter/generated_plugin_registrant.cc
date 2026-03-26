//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hid_monitor/hid_monitor_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hid_monitor_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HidMonitorPlugin");
  hid_monitor_plugin_register_with_registrar(hid_monitor_registrar);
}
