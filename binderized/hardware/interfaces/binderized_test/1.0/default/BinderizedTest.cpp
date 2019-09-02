#include "BinderizedTest.h"

namespace android {
namespace hardware {
namespace binderized_test {
namespace V1_0 {
namespace implementation {

// Methods from ::android::hardware::binderized_test::V1_0::IBinderizedTest follow.
Return<void> BinderizedTest::helloWorld(const hidl_string& name, helloWorld_cb _hidl_cb) {
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

//IBinderizedTest* HIDL_FETCH_IBinderizedTest(const char* /* name */) {
    //return new BinderizedTest();
//}
//
}  // namespace implementation
}  // namespace V1_0
}  // namespace binderized_test
}  // namespace hardware
}  // namespace android
