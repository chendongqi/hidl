#include "HelloWorld.h"

namespace android {
namespace hardware {
namespace helloworld {
namespace V1_0 {
namespace implementation {

// Methods from ::android::hardware::helloworld::V1_0::IHelloWorld follow.
Return<void> HelloWorld::helloWorld(const hidl_string& name, helloWorld_cb _hidl_cb) {
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

IHelloWorld* HIDL_FETCH_IHelloWorld(const char* /* name */) {
    return new HelloWorld();
}
//
}  // namespace implementation
}  // namespace V1_0
}  // namespace helloworld
}  // namespace hardware
}  // namespace android
