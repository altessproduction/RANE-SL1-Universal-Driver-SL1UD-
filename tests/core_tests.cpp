#include "sl1/device_info.hpp"

#include <cassert>

int main() {
    const sl1::DeviceInfo device{};
    assert(device.vendor_id == 0x13E5);
    assert(device.product_id == 0x0001);
    // Unknown capabilities must remain unknown until confirmed on hardware.
    assert(device.input_channels == 0);
    assert(device.output_channels == 0);
    assert(device.sample_rate == 0);
    return 0;
}
