#ifndef FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_C_API_H_
#define FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_C_API_H_

#include <hid_monitor_shared.h>
#include <flutter_plugin_registrar.h>

#if defined(__cplusplus)
extern "C"
{
#endif

#if defined(__cplusplus)
#include <Windows.h>
	class FLUTTER_PLUGIN_EXPORT HidMonitor
	{
	public:
		HidMonitor();
		~HidMonitor();

		static HidMonitor* Get() { return HidMonitor::listenerInstance; }

	private:
		HHOOK m_keyboardHook;
		HHOOK m_mouseHook;

		static HidMonitor* listenerInstance;
	};
#endif

    FLUTTER_PLUGIN_EXPORT void HidMonitorPluginWindowsRegisterWithRegistrar(
        FlutterDesktopPluginRegistrarRef registrar);

#if defined(__cplusplus)
} // extern "C"
#endif

#endif // FLUTTER_PLUGIN_HID_MONITOR_PLUGIN_C_API_H_
