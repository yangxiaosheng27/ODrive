# 接口库
add_library(stm32f4xx_hal_interface INTERFACE)

# 设置头文件目录
target_include_directories(stm32f4xx_hal_interface INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/Inc
)

#-----------------------------------------------------------------

# 静态库
add_library(stm32f4xx_hal_lib STATIC)

# 设置接口
target_link_libraries(stm32f4xx_hal_lib PRIVATE
    cmsis_interface
)

# 设置头文件目录
target_include_directories(stm32f4xx_hal_lib PRIVATE
    ${PROJECT_SOURCE_DIR}/Board/v3/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Inc
)

# 设置源文件
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
