#define LOG_TAG "android.hardware.hidl_test@1.0-service"
#include <android/hardware/hidl_test/1.0/ITest.h>
#include <hidl/LegacySupport.h>

using android::hardware::hidl_test::V1_0::ITest;
using android::hardware::defaultPassthroughServiceImplementation;

int main() {
    return defaultPassthroughServiceImplementation<ITest>();
}
