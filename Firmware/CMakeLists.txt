# 指定CMake最低版本
cmake_minimum_required(VERSION 3.10)

# 设置工具链文件
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchain-arm-none-eabi.cmake")

# 设置项目名称，并显式声明语言
project(ODriveFirmware LANGUAGES C CXX ASM)

# 启用详细链接日志
set(CMAKE_VERBOSE_MAKEFILE ON)

# 设置默认的构建配置
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# 指定C++标准
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

# 设置C编译选项
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__weak=\"__attribute__((weak))\"")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__packed=\"__attribute__((__packed__))\"")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mthumb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-psabi")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wdouble-promotion")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wfloat-conversion")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-nonnull")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fdata-sections")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffunction-sections")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")

# 设置C++编译选项
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-register")

# 设置汇编编译选项
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}")

# 设置链接器选项
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -flto")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lm")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lnosys")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mthumb")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -specs=nosys.specs")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -u _printf_float")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -u _scanf_float")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--cref")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--undefined=uxTopUsedPriority")

# 指定输出目录
if(CMAKE_CONFIGURATION_TYPES)
    foreach(config IN LISTS CMAKE_CONFIGURATION_TYPES)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${config} "${PROJECT_SOURCE_DIR}/build/${config}/bin")
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${config} "${PROJECT_SOURCE_DIR}/build/${config}/lib")
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${config} "${PROJECT_SOURCE_DIR}/build/${config}/lib")
    endforeach()
else()
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/debug/bin)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/debug/lib)
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/debug/lib)
    elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/release/bin)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/release/lib)
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/release/lib)
    else()
        message(WARNING "Unknown build type: ${CMAKE_BUILD_TYPE}")
    endif()
endif()

# 添加子模块
add_subdirectory(ThirdParty/CMSIS)
add_subdirectory(ThirdParty/FreeRTOS)
add_subdirectory(ThirdParty/STM32F4xx_HAL_Driver)
add_subdirectory(ThirdParty/STM32_USB_Device_Library)
add_subdirectory(fibre-cpp)
add_subdirectory(Board/v3)

# 主程序
add_executable(ODriveFirmware)
set_target_properties(ODriveFirmware PROPERTIES OUTPUT_NAME ${PROJECT_NAME}.elf)

# 设置头文件目录
target_include_directories(ODriveFirmware PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl
    ${CMAKE_CURRENT_SOURCE_DIR}/fibre-cpp/include
)

# 链接
target_link_libraries(ODriveFirmware PRIVATE
    cmsis_interface
    stm32f4xx_hal_interface
    freertos_interface
    stm32_usb_device_interface
    fibre_interface
    board_interface
)

# 设置源文件
target_sources(ODriveFirmware PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/syscalls.c
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/utils.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/arm_sin_f32.c
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/arm_cos_f32.c
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/low_level.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/axis.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/motor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/thermistor.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/encoder.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/endstop.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/acim_estimator.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/mechanical_brake.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/controller.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/foc.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/open_loop_controller.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/oscilloscope.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/sensorless_estimator.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/trapTraj.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/pwm_input.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/MotorControl/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/STM32/stm32_system.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/STM32/stm32_gpio.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/STM32/stm32_nvm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/STM32/stm32_spi_arbiter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/Drivers/DRV8301/drv8301.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/can/can_simple.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/can/odrive_can.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/communication.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/ascii_protocol.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/interface_uart.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/interface_usb.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/communication/interface_i2c.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-openocd.c
    ${CMAKE_CURRENT_SOURCE_DIR}/autogen/version.c
)

# 链接
target_link_libraries(ODriveFirmware PRIVATE
    stm32f4xx_hal_lib
    freertos_lib
    stm32_usb_device_lib
    fibre_lib
    board_lib
)

# 生成映射文件
target_link_options(ODriveFirmware PRIVATE
    "-Wl,-Map=${PROJECT_NAME}.map"
)
