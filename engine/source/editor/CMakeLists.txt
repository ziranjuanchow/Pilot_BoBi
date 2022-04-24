set(TARGET_NAME PilotBoBiEditor)

file(GLOB EDITOR_HEADERS CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/include/*.h)
file(GLOB EDITOR_SOURCES CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp)
file(GLOB EDITOR_RESOURCE CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/resource/PilotBoBiEditor.rc)

source_group(TREE "." FILES ${EDITOR_HEADERS} ${EDITOR_SOURCES} ${EDITOR_RESOURCE})

add_executable(${TARGET_NAME} ${EDITOR_HEADERS} ${EDITOR_SOURCES} ${EDITOR_RESOURCE})

add_compile_definitions("PILOTBOBI_ROOT_DIR=${BINARY_ROOT_DIR}") # 它将宏定义添加到当前目录和子目录中定义的所有目标。

# 按照一般的习惯，静态库名字跟动态库名字应该是一致的，只是扩展名不同；
# 即：静态库名为 libhello.a； 动态库名为libhello.so ；
# 所以，希望 "hello_static" 在输出时，不是"hello_static"，而是以"hello"的名字显示，故设置如下：
set_target_properties(${TARGET_NAME} PROPERTIES CXX_STANDARD 17 OUTPUT_NAME "PilotBoBiEditor") # https://www.cnblogs.com/zhoug2020/p/5904206.html
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER "Engine")

# 添加编译选项
target_compile_options(${TARGET_NAME} PUBLIC "$<$<COMPILE_LANG_AND_ID:CXX,MSVC>:/WX->") # 在编译给定目标文件时，指定要用到的编译选项。target目标文件必须已经存在（由命令add_executable()或add_library()创建）且不能被IMPORTED修饰。
# 添加链接库
target_link_libraries(${TARGET_NAME} PilotBoBiRuntime)

add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BINARY_ROOT_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy "${ENGINE_ROOT_DIR}/${TARGET_NAME.ini}" "$BINARY_ROOT_DIR"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/resource" "${BINARY_ROOT_DIR}/resource"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "$<TARGET_FILE_DIR:${TARGET_NAME}>/" "${BINARY_ROOT_dIR}"
        COMMAND ${CMAKE_COMMAND} -E remove_directory "${BINARY_ROOT_DIR}/${ENGINE_ASSET_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${ENGINE_ROOT_DIR}/${ENGINE_ASSET_DIR}" "${BINARY_ROOT_DIR}/${ENGINE_ASSET_DIR}"
        )