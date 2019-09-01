#include "Test.h"

namespace android {
namespace hardware {
namespace hidl_test {
namespace V1_0 {
namespace implementation {

// Methods from ::android::hardware::hidl_test::V1_0::ITest follow.
Return<void> Test::helloWorld(const hidl_string& name, helloWorld_cb _hidl_cb) {
    // TODO implement
    printf("Test helloWorld");
    char buf[100];
    memset(buf, 0, 100);
    snprintf(buf, 100, "Hello World, %s", name.c_str());
    hidl_string result(buf);
    _hidl_cb(result);
    return Void();
}


// Methods from ::android::hidl::base::V1_0::IBase follow.

ITest* HIDL_FETCH_ITest(const char* /* name */) {
    return new Test();
}
//
}  // namespace implementation
}  // namespace V1_0
}  // namespace hidl_test
}  // namespace hardware
}  // namespace android
