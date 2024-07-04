# CMakeLists.txt
cmake_minimum_required(VERSION 3.10)

project(helloworld)
set(PROJECT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../)

set(CMAKE_C_COMPILER aarch64-none-elf-gcc)
set(CMAKE_LINKER aarch64-none-elf-ld)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -g -O3 -DSDT -mcpu=cortex-a53 -march=armv8-a ")

set(PLATFORM_BSP_DIR "${PROJECT_SOURCE_DIR}/platform/psu_cortexa53_0/domain_bm_a53/bsp/psu_cortexa53_0")


include_directories(
    ${PROJECT_SOURCE_DIR}/include
    ${PLATFORM_BSP_DIR}/include
)


file(GLOB SOURCES
    "${PROJECT_SOURCE_DIR}/source/*.c"
)

file(GLOB OBJECTS
    "${PLATFORM_BSP_DIR}/lib/*.o"
)

set(LINKER_SCRIPT "${PROJECT_SOURCE_DIR}/source/lscript.ld")


add_executable(helloworld.elf ${SOURCES} ${OBJECTS})

target_link_libraries(helloworld.elf 
    ${PLATFORM_BSP_DIR}/lib/libxil.a    
)

set_target_properties(helloworld.elf PROPERTIES LINK_FLAGS "-T ${LINKER_SCRIPT}")