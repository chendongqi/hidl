#ifndef ANDROID_HARDWARE_BINDERIZED_TEST_V1_0_BINDERIZEDTEST_H
#define ANDROID_HARDWARE_BINDERIZED_TEST_V1_0_BINDERIZEDTEST_H

#include <android/hardware/binderized_test/1.0/IBinderizedTest.h>
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>

namespace android {
namespace hardware {
namespace binderized_test {
namespace V1_0 {
namespace implementation {

using ::android::hardware::hidl_array;
using ::android::hardware::hidl_memory;
using ::android::hardware::hidl_string;
using ::android::hardware::hidl_vec;
using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::sp;

struct BinderizedTest : public IBinderizedTest {
    // Methods from ::android::hardware::binderized_test::V1_0::IBinderizedTest follow.
    Return<void> helloWorld(const hidl_string& name, helloWorld_cb _hidl_cb) override;

    // Methods from ::android::hidl::base::V1_0::IBase follow.

};

// FIXME: most likely delete, this is only for passthrough implementations
// extern "C" IBinderizedTest* HIDL_FETCH_IBinderizedTest(const char* name);

}  // namespace implementation
}  // namespace V1_0
}  // namespace binderized_test
}  // namespace hardware
}  // namespace android

#endif  // ANDROID_HARDWARE_BINDERIZED_TEST_V1_0_BINDERIZEDTEST_H
