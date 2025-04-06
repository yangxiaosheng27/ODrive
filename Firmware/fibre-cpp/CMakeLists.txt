# 接口库
add_library(fibre_interface INTERFACE)

# 设置头文件目录
target_include_directories(fibre_interface INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

#-----------------------------------------------------------------

# 静态库
add_library(fibre_lib STATIC)

# 设置接口
target_link_libraries(fibre_lib PRIVATE
    cmsis_interface
)

# 定义布尔参数
option(FIBRE_ENABLE_SERVER "Enable Fibre server" ON)
option(FIBRE_ENABLE_CLIENT "Enable Fibre client" OFF)
option(FIBRE_ENABLE_EVENT_LOOP "Enable event loop" OFF)
option(FIBRE_ALLOW_HEAP "Allow heap allocation" OFF)
option(FIBRE_ENABLE_LIBUSB_BACKEND "Enable libusb backend" OFF)
option(FIBRE_ENABLE_TCP_SERVER_BACKEND "Enable TCP server backend" OFF)
option(FIBRE_ENABLE_TCP_CLIENT_BACKEND "Enable TCP client backend" OFF)

# 定义可选的整数参数
set(FIBRE_MAX_LOG_VERBOSITY "0" CACHE STRING "Maximum log verbosity")
set(FIBRE_DEFAULT_LOG_VERBOSITY "2" CACHE STRING "Default log verbosity")

# 根据参数值添加宏定义
target_compile_definitions(fibre_lib PRIVATE
    FIBRE_ENABLE_SERVER=${FIBRE_ENABLE_SERVER}
    FIBRE_ENABLE_CLIENT=${FIBRE_ENABLE_CLIENT}
    FIBRE_ENABLE_EVENT_LOOP=${FIBRE_ENABLE_EVENT_LOOP}
    FIBRE_ALLOW_HEAP=${FIBRE_ALLOW_HEAP}
    FIBRE_MAX_LOG_VERBOSITY=${FIBRE_MAX_LOG_VERBOSITY}
    FIBRE_DEFAULT_LOG_VERBOSITY=${FIBRE_DEFAULT_LOG_VERBOSITY}
    FIBRE_ENABLE_LIBUSB_BACKEND=${FIBRE_ENABLE_LIBUSB_BACKEND}
    FIBRE_ENABLE_TCP_SERVER_BACKEND=${FIBRE_ENABLE_TCP_SERVER_BACKEND}
    FIBRE_ENABLE_TCP_CLIENT_BACKEND=${FIBRE_ENABLE_TCP_CLIENT_BACKEND}
)

# 设置头文件目录
target_include_directories(fibre_lib PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# 设置源文件
target_sources(fibre_lib PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/fibre.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/channel_discoverer.cpp
)

# 根据选项添加代码文件和库
if(FIBRE_ENABLE_LIBUSB_BACKEND)
    target_sources(fibre_lib PRIVATE platform_support/libusb_transport.cpp)
    target_link_libraries(fibre_lib PRIVATE pthread)
endif()
if(FIBRE_MAX_LOG_VERBOSITY GREATER 0)
    target_sources(fibre_lib PRIVATE logging.cpp)
endif()
if(FIBRE_ENABLE_CLIENT)
    target_sources(fibre_lib PRIVATE legacy_object_client.cpp)
endif()
if(FIBRE_ENABLE_CLIENT OR FIBRE_ENABLE_SERVER)
    target_sources(fibre_lib PRIVATE legacy_protocol.cpp)
endif()
if(FIBRE_ENABLE_EVENT_LOOP)
    target_sources(fibre_lib PRIVATE platform_support/epoll_event_loop.cpp)
endif()
if(FIBRE_ENABLE_TCP_CLIENT_BACKEND OR FIBRE_ENABLE_TCP_SERVER_BACKEND)
    target_sources(fibre_lib PRIVATE platform_support/posix_tcp_backend.cpp)
    target_sources(fibre_lib PRIVATE platform_support/posix_socket.cpp)
    target_link_libraries(fibre_lib PRIVATE anl)
endif()
