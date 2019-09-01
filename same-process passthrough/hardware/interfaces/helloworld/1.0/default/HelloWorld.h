#ifndef ANDROID_HARDWARE_HELLOWORLD_V1_0_HELLOWORLD_H
#define ANDROID_HARDWARE_HELLOWORLD_V1_0_HELLOWORLD_H

#include <android/hardware/helloworld/1.0/IHelloWorld.h>
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>

namespace android {
namespace hardware {
namespace helloworld {
namespace V1_0 {
namespace implementation {

using ::android::hardware::hidl_array;
using ::android::hardware::hidl_memory;
using ::android::hardware::hidl_string;
using ::android::hardware::hidl_vec;
using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::sp;

struct HelloWorld : public IHelloWorld {
    // Methods from ::android::hardware::helloworld::V1_0::IHelloWorld follow.
    Return<void> helloWorld(const hidl_string& name, helloWorld_cb _hidl_cb) override;

    // Methods from ::android::hidl::base::V1_0::IBase follow.

};

// FIXME: most likely delete, this is only for passthrough implementations
extern "C" IHelloWorld* HIDL_FETCH_IHelloWorld(const char* name);

}  // namespace implementation
}  // namespace V1_0
}  // namespace helloworld
}  // namespace hardware
}  // namespace android

#endif  // ANDROID_HARDWARE_HELLOWORLD_V1_0_HELLOWORLD_H
