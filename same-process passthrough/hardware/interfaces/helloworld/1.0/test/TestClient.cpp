#include <android/hardware/helloworld/1.0/IHelloWorld.h>
#include <hidl/HidlSupport.h>
#include <stdio.h>

using ::android::hardware::hidl_string;
using ::android::sp;
using ::android::hardware::helloworld::V1_0::IHelloWorld;

int main() {

    android::sp<IHelloWorld> service = IHelloWorld::getService();

    
    if (service == nullptr) {
        printf("Failed to get service\n");
        return -1;
    }

    service->helloWorld("Test", [&](hidl_string result) {
        printf("%s\n", result.c_str());
    });

    return 0;
}
