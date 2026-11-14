#pragma once

#include <cstdint>
#include <string>

namespace sl1 {

// Provisional capability values only. Confirm against physical-device descriptors
// and successful streaming before treating these as authoritative.
struct DeviceInfo {
    std::uint16_t vendor_id{0x13E5};
    std::uint16_t product_id{0x0001};
    std::string product_name{"Rane SL1 (unverified descriptor)"};
    unsigned input_channels{0};
    unsigned output_channels{0};
    unsigned sample_rate{0};
};

} // namespace sl1
