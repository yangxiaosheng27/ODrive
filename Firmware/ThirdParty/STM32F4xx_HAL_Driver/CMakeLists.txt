# 添加静态库（先不指定源文件）
add_library(stm32f4xx_hal_lib STATIC)

# 设置宏定义
target_compile_definitions(stm32f4xx_hal_lib PRIVATE ARM_MATH_CM4 FPU_FPV4)

# 设置编译选项
target_compile_options(stm32f4xx_hal_lib PRIVATE -mcpu=cortex-m4 -mfpu=fpv4-sp-d16)

# 指定头文件目录
target_include_directories(stm32f4xx_hal_lib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/Inc)
target_include_directories(stm32f4xx_hal_lib PRIVATE ${PROJECT_SOURCE_DIR}/Board/v3/Inc)
target_include_directories(stm32f4xx_hal_lib PRIVATE ${PROJECT_SOURCE_DIR}/ThirdParty/CMSIS/Device/ST/STM32F4xx/Include)

# 动态添加源文件
target_sources(stm32f4xx_hal_lib PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_adc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_adc_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_can.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_cortex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_dma.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_dma_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_flash.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_flash_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_flash_ramfunc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_gpio.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_i2c.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_i2c_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_pcd.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_pcd_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_pwr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_pwr_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_rcc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_rcc_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_spi.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_tim.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_tim_ex.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_hal_uart.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/stm32f4xx_ll_usb.c
)

# 设置目标属性（可选）
#set_target_properties(stm32f4xx_hal_lib PROPERTIES VERSION 1.0)
