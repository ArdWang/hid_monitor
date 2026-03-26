#ifndef FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_H_
#define FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _HidMonitorPlugin HidMonitorPlugin;
typedef struct {
  GObjectClass parent_class;
} HidMonitorPluginClass;

FLUTTER_PLUGIN_EXPORT GType hid_monitor_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void hid_monitor_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS


#if defined(__cplusplus)
#include <thread>
#include <X11/XKBlib.h>
class FLUTTER_PLUGIN_EXPORT HidMonitor {
public:
    HidMonitor();
    ~HidMonitor();

    static HidMonitor *Get() { return HidMonitor::listenerInstance; }

private:
    void WorkerThread();
    std::thread m_workerThread;
    bool m_rootInitializer;
    bool m_running;
    Display* m_display;
    int m_xiOpcode;

    static HidMonitor* listenerInstance;
};
#endif


#endif  // FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_H_
