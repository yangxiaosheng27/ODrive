# 接口库
add_library(freertos_interface INTERFACE)

# 设置头文件目录
target_include_directories(freertos_interface INTERFACE
    ${PROJECT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/include
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/CMSIS_RTOS
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/GCC/ARM_CM4F
)

#-----------------------------------------------------------------

# 静态库
add_library(freertos_lib STATIC)

# 设置接口
target_link_libraries(freertos_lib PRIVATE
    cmsis_interface
)

# 设置头文件目录
target_include_directories(freertos_lib PRIVATE
    ${PROJECT_SOURCE_DIR}/Board/v3/Inc
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/include
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/CMSIS_RTOS
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/GCC/ARM_CM4F
)

# 设置源文件
target_sources(freertos_lib PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/croutine.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/event_groups.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/stream_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/tasks.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/timers.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/CMSIS_RTOS/cmsis_os.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/MemMang/heap_4.c
    ${CMAKE_CURRENT_SOURCE_DIR}/Source/portable/GCC/ARM_CM4F/port.c
)
