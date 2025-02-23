# 静态库
add_library(stm32_usb_device_lib STATIC)

# 设置接口
target_link_libraries(stm32_usb_device_lib PRIVATE
    cmsis_interface
    freertos_interface
    stm32f4xx_hal_interface
)

# 设置头文件目录
target_include_directories(stm32_usb_device_lib PRIVATE
    ${PROJECT_SOURCE_DIR}/Board/v3/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Class/CDC/Inc
)

# 设置源文件
target_sources(stm32_usb_device_lib PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/Src/usbd_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/Src/usbd_ctlreq.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Core/Src/usbd_ioreq.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Class/CDC/Src/usbd_cdc.c
)
