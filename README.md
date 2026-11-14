# RANE SL1 Universal Driver (SL1UD)

Experimental community project to investigate using the Rane SL1 as a general-purpose USB audio interface, independently of Serato Scratch Live.

> **Status: research / hardware-protocol validation.** This repository does not yet contain a working audio driver. Do not install experimental kernel/system drivers or use this project in a live performance.

## Goals

- Windows 10 x64: investigate a low-latency ASIO driver; consider WASAPI later.
- macOS Intel and Apple Silicon: expose the device through Core Audio.
- Bidirectional audio I/O for general audio applications.
- Evaluate DVS/timecode use with DJ software, including djay and Mixxx.
- Preserve the existing vendor driver and provide a safe rollback path during development.

## Important scope and compatibility notes

- A USB device being detected is not proof that its audio protocol is understood.
- The reported USB VID:PID `13e5:0001` and the commonly documented 44.1 kHz / four-input / four-output configuration are **working hypotheses** to verify on physical hardware.
- ASIO and Core Audio are separate host APIs. A shared C++ engine can be useful, but each operating system needs its own integration layer.
- DVS compatibility must be tested with actual timecode records, input gain, channel routing and latency measurements. Do not assume that a supported audio interface automatically supports every DVS vinyl.
- No firmware, proprietary binaries, vendor driver code, or Serato code belongs in this repository.

## Proposed architecture

```text
DJ / DAW applications
       |                         |
Windows ASIO adapter       macOS Core Audio adapter
       |                         |
       +------ shared SL1 engine-+
                  |
       USB discovery / transport
                  |
                Rane SL1
```

The shared engine should own device capabilities, stream configuration, buffer/ring-buffer management, clocking, diagnostics and error handling. Platform adapters should remain thin and use documented APIs.

## Repository layout

- `core/` — platform-neutral types and audio-engine interfaces.
- `platform/windows/` — Windows device discovery and later ASIO integration.
- `platform/macos/` — Core Audio integration research.
- `tools/` — non-destructive hardware inventory utilities.
- `docs/` — protocol observations, test plans and design decisions.

## Development phases

1. **Hardware inventory:** capture USB descriptors, interfaces, endpoints, driver binding and OS version.
2. **Protocol research:** establish the control/streaming protocol from lawful, reproducible observations; document unknowns.
3. **Read-only discovery prototype:** identify the SL1 without detaching or replacing the vendor driver.
4. **Audio transport prototype:** prove stable input/output streaming, sample format, channel map, clocking and recovery.
5. **Windows host integration:** build and validate an ASIO adapter; signing and installation strategy to be determined.
6. **macOS host integration:** evaluate the existing OpenSL1 project and Core Audio driver options before implementing a new driver.
7. **DVS validation:** test timecode integrity, routing, calibration and latency with supported DJ applications.
8. **Packaging and release:** CI builds, signed/notarized installers where applicable, documentation and rollback instructions.

## First hardware test — Windows 10

1. Keep the existing Rane/Serato driver installed.
2. Connect the SL1 directly to the PC, preferably without a USB hub.
3. Open PowerShell in the repository and run:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\tools\inspect-sl1.ps1
   ```

4. Share `sl1-usb-report.txt` in a GitHub issue (remove any unrelated device identifiers before posting).

The script only queries Plug-and-Play properties. It does not change drivers or device settings.

## macOS research

Review [OpenSL1](https://github.com/OnSerious/OpenSL1) and its license before deciding whether to reuse or adapt it. If code is reused, comply with its applicable license terms and preserve notices. A clean-room implementation must be based on independently documented device behavior, not copied proprietary code.

## Contributions and safety

- Record hardware model/revision, OS version and exact test setup.
- Never publish serial numbers, personal paths, access tokens, private logs or unrelated USB identifiers.
- Do not test experimental drivers during paid/live work.
- Keep a known-good audio interface available for rollback.

## Disclaimer

RANE, Serato and inMusic are trademarks of their respective owners. This is an independent, unaffiliated project. Compatibility is not endorsed or guaranteed by those companies.
