# macOS integration research

Targets to investigate: Intel (x86_64) and Apple Silicon (arm64).

## First action

Audit [OpenSL1](https://github.com/OnSerious/OpenSL1), its supported macOS versions,
device protocol assumptions, build instructions and GPL-3.0-or-later obligations.
Decide explicitly whether this project will:
1. reuse/adapt OpenSL1 code while complying with its license; or
2. implement an independent transport from independently collected protocol evidence.

Do not copy source code or binaries without reviewing license and attribution obligations.

## Host integration options

Investigate Core Audio HAL plug-in approaches and Apple's current AudioDriverKit
support/entitlement requirements. Select the least privileged supported design
after a minimal proof of concept. No system extension or installer is implemented.
