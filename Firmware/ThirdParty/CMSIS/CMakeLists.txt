# 接口库
add_library(cmsis_interface INTERFACE)

# 设置宏定义
target_compile_definitions(cmsis_interface INTERFACE
    STM32F405xx
    ARM_MATH_CM4
    USE_HAL_DRIVER
)

# 设置编译选项
target_compile_options(cmsis_interface INTERFACE
    -mcpu=cortex-m4
    -mfpu=fpv4-sp-d16
)

# 设置头文件目录
target_include_directories(cmsis_interface INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/Include
    ${CMAKE_CURRENT_SOURCE_DIR}/Device/ST/STM32F4xx/Include
)
