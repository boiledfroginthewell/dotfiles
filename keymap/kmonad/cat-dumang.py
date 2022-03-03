#!/usr/bin/env python

import asyncio
from contextlib import ExitStack
import sys
from typing import List

import evdev


device_paths = sys.argv[1:]
if not device_paths:
	print("Error: No devices are specified")
	sys.exit(1)
devices: List[evdev.InputDevice] = [evdev.InputDevice(x) for x in device_paths]


def sands(event: evdev.events.InputEvent, ui: evdev.UInput) -> bool:
	"""
	Process SandS.
	:returns: True if the event is processed by us
	"""
	if event.type == evdev.ecodes.EV_KEY and \
		event.code == evdev.ecodes.KEY_0 and \
		any([evdev.ecodes.KEY_SPACE in device.active_keys() for device in devices]):
		ui.write(evdev.ecodes.EV_KEY, evdev.ecodes.KEY_YEN, event.value)
		return True

	return False


with evdev.UInput.from_device(devices[0], name="dumang-cat") as ui, ExitStack() as stack:
	[stack.enter_context(device.grab_context()) for device in devices]
	async def print_events(device):
		async for event in device.async_read_loop():
			# print(device.path, evdev.categorize(event), sep=': ')
			sands(event, ui) or ui.write_event(event)
		ui.syn()

	for device in devices:
		asyncio.ensure_future(print_events(device))

	loop = asyncio.get_event_loop()
	loop.run_forever()
