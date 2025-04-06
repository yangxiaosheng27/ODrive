# 接口库
add_library(board_interface INTERFACE)

# 设置头文件目录
target_include_directories(board_interface INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/Inc
)

# 设置宏定义
target_compile_definitions(board_interface INTERFACE
    HW_VERSION_MAJOR=3
    HW_VERSION_MINOR=6
    HW_VERSION_VOLTAGE=56
)

# 设置链接选项
target_link_options(board_interface INTERFACE
    -T${CMAKE_CURRENT_SOURCE_DIR}/STM32F405RGTx_FLASH.ld
)

#-----------------------------------------------------------------

# 静态库
add_library(board_lib STATIC)

# 设置接口
target_link_libraries(board_lib PRIVATE
    cmsis_interface
    stm32f4xx_hal_interface
    freertos_interface
    stm32_usb_device_interface
)

# 设置宏定义
target_compile_definitions(board_lib PRIVATE
    HW_VERSION_MAJOR=3
    HW_VERSION_MINOR=6
    HW_VERSION_VOLTAGE=56
)

# 设置头文件目录
target_include_directories(board_lib PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Inc
)

# 标记汇编文件
set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR}/startup_stm32f405xx.s PROPERTIES LANGUAGE ASM)

# 设置源文件
target_sources(board_lib PRIVATE
    #${PROJECT_SOURCE_DIR}/ThirdParty/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c
    #${PROJECT_SOURCE_DIR}/Drivers/DRV8301/drv8301.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/startup_stm32f405xx.s
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_timebase_TIM.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/tim.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/dma.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/freertos.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/usbd_conf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/spi.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/usart.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/usbd_cdc_if.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/adc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_msp.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/usbd_desc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_it.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/usb_device.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/can.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/system_stm32f4xx.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/gpio.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/i2c.c
)

