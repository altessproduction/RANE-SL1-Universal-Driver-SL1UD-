# Hardware validation record

Fill this document from observations of a physical SL1. Do not infer values from marketing material or another device revision.

| Field | Observation |
|---|---|
| SL1 hardware revision / label | TBD |
| USB VID:PID | Reported as 13e5:0001; verify |
| USB bcdDevice | TBD |
| Windows version/build | TBD |
| macOS version/build | TBD |
| USB interfaces | TBD |
| Endpoint addresses/types | TBD |
| Alternate settings | TBD |
| Audio sample format | TBD |
| Sample rate(s) | TBD |
| Input/output channel map | TBD |
| Clock/synchronization | TBD |
| Vendor driver version | TBD |

## Capture procedure

1. Record the exact OS version and SL1 hardware revision.
2. Capture descriptors with a trusted USB inspection utility.
3. Save only SL1-related records; redact serial numbers and unrelated device IDs.
4. Repeat after a cold reconnect and after the vendor application has initialized the device.
5. Compare descriptor state and document differences.

No USB traffic should be injected and no driver should be detached during this inventory phase.
