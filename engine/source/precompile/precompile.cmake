
set(PRECOMPILE_TOOLS_PATH "${CMAKE_SOURCE_DIR}/bin")
set(PILOTBOBI_PRECOMPILE_PARAMS_IN_PATH "${CMAKE_SOURCE_DIR}/source/precompile/precompile.json.in")
set(PILOTBOBI_PRECOMPILE_PARAMS_PATH "${PRECOMPILE_TOOLS_PATH}/precompile.json.in")
configure_file(${PILOTBOBI_PRECOMPILE_PARAMS_IN_PATH} ${PILOTBOBI_PRECOMPILE_PARAMS_PATH})

if(CMAKE_HOST_WIN32)
    set(PRECOMPILE_PRE_EXE)
    set(PRECOMPILE_PARSER ${PRECOMPILE_TOOLS_PATH}/Windows/x64/meta_parser.exe)
    set(sys_include "*")
endif()

set(PARSER_INPUT ${CMAKE_BINARY_DIR}/parser_header.h)

set(PRECOMPILE_TARGET "PilotBoBiPreCompile")

add_custom_target(${PRECOMPILE_TARGET} ALL

# If more than one COMMAND is specified they will be executed in order...
COMMAND
    ${CMAKE_COMMAND} -E echo "************************************************************* "
COMMAND
    ${CMAKE_COMMAND} -E echo "**** [Precompile] BEGIN "
COMMAND
    ${CMAKE_COMMAND} -E echo "************************************************************* "

COMMAND
    ${PRECOMPILE_PARSER} "${PILOT_PRECOMPILE_PARAMS_PATH}"  "${PARSER_INPUT}"  "${ENGINE_ROOT_DIR}/source" ${sys_include} "Pilot" S 0 0 0
### BUILDING ====================================================================================
COMMAND
    ${CMAKE_COMMAND} -E echo "+++ Precompile finished +++"
)
