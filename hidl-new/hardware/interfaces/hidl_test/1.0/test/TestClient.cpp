#include <android/hardware/hidl_test/1.0/ITest.h>
#include <hidl/HidlSupport.h>
#include <stdio.h>

using ::android::hardware::hidl_string;
using ::android::sp;
using ::android::hardware::hidl_test::V1_0::ITest;

int main() {

    android::sp<ITest> service = ITest::getService();
    
    if (service == nullptr) {
        printf("Failed to get service\n");
        return -1;
    }

    service->helloWorld("Test", [&](hidl_string result) {
        printf("%s\n", result.c_str());
    });

    return 0;
}
