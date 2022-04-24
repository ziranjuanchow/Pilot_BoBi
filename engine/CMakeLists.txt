cmake_minimum_required(VERSION 3.21 FATAL_ERROR)
project(PilotBoBi VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(BUILD_SHARED_LIBS  OFF)

include(CMakeDependentOption)

# ---- Include guards ----
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR) # STREQUAL: compare str
    message(
            FATAL_ERROR
            "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there."
    )
endif()

set(PILOTBOBI_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/..")
set(CMAKE_INSTALL_PREFIX "${PILOTBOBI_ROOT_DIR}/bin")
set(BINARY_ROOT_DIR "${CMAKE_INSTALL_PREFIX}/")
set(ENGINE_ROOT_DIR "${PILOTBOBI_ROOT_DIR}/engine")
set(THIRD_PARTY_DIR "${ENGINE_ROOT_DIR}/3rdparty")
set(ENGINE_ASSET_DIR "/asset")
set(ENGINE_SCHEMA_DIR "/schema")

if(WIN32)
    add_definitions("/MP")
endif()

set(vulkan_include ${THIRD_PARTY_DIR}/VulkanSDK/include)

if(WIN32)
    set(vulkan_lib ${THIRD_PARTY_DIR}/VulkanSDK/lib/Win32/Vulkan-1.lib)
    set(glslangValidator_executable ${THIRD_PARTY_DIR}/VulkanSDK/bin/Win32/glslangValidator.exe)
#elseif(UNIX)
#    if(APPLE)
#        set()
#        set()
#        add_compile_definitions()
#        add_compile_definitions()
#    else()
#    endif()
else()
    message(FATAL_ERROR "Unknown Platform")
endif()


set(SHADER_COMPILE_TARGET PilotShaderCompile)
add_subdirectory(shader)

add_subdirectory(3rdparty)

add_subdirectory(source/runtime)
add_subdirectory(source/editor)

set(CODEGEN_TARGET "PilotBoBiPreCompile")
include(source/precompile/precompile.cmake)
set_target_properties("${CODEGEN_TARGET}" PROPERTIES FOLDER "Engine")

add_dependencies(PilotBoBiRuntime "${CODEGEN_TARGET}")
