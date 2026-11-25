/* Project name project configuration file	*/

#ifndef _project_config_h_
#define _project_config_h_

#include "GenericMacros.h"
#include "GenericTypeDefs.h"
#include "MAX3421E.h"
#include "USB.h"
#include "usb_ch9.h"
#include "transfer.h"
#include "HID.h"
#include "xparameters.h"

#if defined(XPAR_TIMER_USB_AXI_CLOCK_FREQ_HZ)
#define USB_TIMER_CLOCK_HZ XPAR_TIMER_USB_AXI_CLOCK_FREQ_HZ
#elif defined(XPAR_TMRCTR_0_CLOCK_FREQ_HZ)
#define USB_TIMER_CLOCK_HZ XPAR_TMRCTR_0_CLOCK_FREQ_HZ
#elif defined(XPAR_CPU_CORE_CLOCK_FREQ_HZ)
#define USB_TIMER_CLOCK_HZ XPAR_CPU_CORE_CLOCK_FREQ_HZ
#else
#define USB_TIMER_CLOCK_HZ 100000000U
#endif

#define USB_TIMER_TICKS_PER_MS (USB_TIMER_CLOCK_HZ / 1000U)

/* USB constants */
/* time in milliseconds */
#define USB_SETTLE_TIME 					200         //USB settle after reset
#define USB_XFER_TIMEOUT					5000        //USB transfer timeout

#define USB_NAK_LIMIT 200
#define USB_RETRY_LIMIT 3

#endif // _project_config_h
