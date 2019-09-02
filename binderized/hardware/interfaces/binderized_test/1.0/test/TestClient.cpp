#include <android/hardware/binderized_test/1.0/IBinderizedTest.h>
#include <hidl/HidlSupport.h>
#include <stdio.h>

using ::android::hardware::hidl_string;
using ::android::sp;
using ::android::hardware::binderized_test::V1_0::IBinderizedTest;

int main() {

    android::sp<IBinderizedTest> service = IBinderizedTest::getService();
    
    if (service == nullptr) {
        printf("Failed to get service\n");
        return -1;
    }

    service->helloWorld("Test", [&](hidl_string result) {
        printf("%s\n", result.c_str());
    });

    return 0;
}
