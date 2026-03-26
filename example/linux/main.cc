#include "my_application.h"

#include <hid_monitor/hid_monitor_plugin.h>

int main(int argc, char **argv)
{
  HidMonitor listener;
  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
