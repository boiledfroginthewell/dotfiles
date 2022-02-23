#!/usr/bin/env python

import asyncio
import evdev

devices_paths = [
	# Dumang_left
	"/dev/input/by-id/usb-www.BeyondQ.com_DuMang_KeyBoard_DK6_05D6FF313431474843257220-event-kbd",
	# Dumang_right
	"/dev/input/by-id/usb-www.BeyondQ.com_DuMang_KeyBoard_DK6_05D8FF303037484843148234-event-kbd",
]
devices = [evdev.InputDevice(x) for x in devices_paths]

with evdev.UInput.from_device(devices[0], name="dumang-cat") as ui:
	with devices[0].grab_context(), devices[1].grab_context():
		async def print_events(device):
			async for event in device.async_read_loop():
				# print(device.path, evdev.categorize(event), sep=': ')
				ui.write_event(event)
			ui.syn()

		for device in devices:
			asyncio.ensure_future(print_events(device))

		loop = asyncio.get_event_loop()
		loop.run_forever()

