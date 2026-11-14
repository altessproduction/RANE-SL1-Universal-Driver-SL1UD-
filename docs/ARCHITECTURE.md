# Architecture decision record (initial)

## Goals

- One platform-neutral C++ core for shared types, stream configuration, buffering,
  diagnostics and testable state machines.
- Thin platform adapters: Windows ASIO and macOS Core Audio.
- No vendor-driver replacement during discovery.
- DVS signal path must be transparent: no resampling, AGC, noise suppression,
  channel mixing or other processing unless explicitly required and measured.

## Layers

1. **Host adapter** — maps host callbacks and buffer formats to the core.
2. **Audio engine** — stream lifecycle, bounded queues, timestamps, xruns and metrics.
3. **Transport** — platform-specific USB discovery/control/isochronous transfers.
4. **Hardware** — Rane SL1.

## Decisions still open

- USB interface and endpoint map.
- Sample format, packet sizes, synchronization/clock model.
- Control messages and initialization sequence.
- Whether the existing Windows driver can coexist during early research.
- macOS HAL versus AudioDriverKit implementation.
- ASIO SDK version/license and installer/signing requirements.

## Non-goals for the first milestone

- Firmware modification.
- Replacing the factory driver.
- Claiming DVS compatibility before physical tests.
- Shipping unsigned kernel/system components.
