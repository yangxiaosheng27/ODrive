# 指定CMake最低版本
cmake_minimum_required(VERSION 3.10)

# 设置默认的构建配置
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# 设置工具链文件
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchain-arm-none-eabi.cmake")

# 指定C++标准
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

# 设置项目名称
project(XDrive)

# 设置宏定义
add_definitions(-DFIBRE_ENABLE_SERVER) # todo

# 设置C编译选项
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__weak=\"__attribute__((weak))\"")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D__packed=\"__attribute__((__packed__))\"")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mthumb")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=hard")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-psabi")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wdouble-promotion")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wfloat-conversion")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-nonnull")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fdata-sections")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -ffunction-sections")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")

# 设置C++编译选项
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__weak=\"__attribute__((weak))\"")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__packed=\"__attribute__((__packed__))\"")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-register")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mthumb")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfloat-abi=hard")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-psabi")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wdouble-promotion")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wfloat-conversion")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-nonnull")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdata-sections")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffunction-sections")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")

# 设置链接器选项
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -flto")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lc")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lm")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lnosys")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mthumb")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mfloat-abi=hard")
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

# 添加子目录（库模块）
add_subdirectory(ThirdParty/CMSIS)
add_subdirectory(ThirdParty/FreeRTOS)
add_subdirectory(ThirdParty/STM32F4xx_HAL_Driver)
add_subdirectory(ThirdParty/STM32_USB_Device_Library)

# 包含头文件目录
#include_directories(${PROJECT_SOURCE_DIR}/include)

# 添加主程序
#add_executable(${PROJECT_NAME} src/main.cpp)

# 链接库到主程序
#target_link_libraries(${PROJECT_NAME} mylib myutils)
