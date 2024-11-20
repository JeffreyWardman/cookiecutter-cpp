# Check if the compiler supports generating NEON code (typically with the -mfpu=neon flag for ARM)
CHECK_CXX_COMPILER_FLAG("-mfpu=neon" COMPILER_SUPPORTS_NEON)

if(COMPILER_SUPPORTS_NEON)
    # Run the shell command to check for NEON in /proc/cpuinfo
    execute_process(
        COMMAND /bin/sh -c "cat /proc/cpuinfo | grep neon"
        OUTPUT_VARIABLE NEON_CHECK_OUTPUT
        RESULT_VARIABLE NEON_CHECK_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # Check if the output is empty
    if(NEON_CHECK_OUTPUT STREQUAL "")
        message(STATUS "NEON is NOT mentioned in /proc/cpuinfo.")
        set(NEON_IN_CPUINFO FALSE)
    else()
        message(STATUS "NEON is mentioned in /proc/cpuinfo.")
        set(NEON_IN_CPUINFO TRUE)
    endif()

    # Check the result of the compilation
    if(NEON_IN_CPUINFO)
        message(STATUS "NEON is supported by the CPU.")
        set(SIMD_FOUND TRUE)
        add_definitions(-mfpu=neon)
        add_definitions(-D__NEON__)
    else()
        message(STATUS "NEON is NOT supported by the CPU.")
        message(WARNING "NEON is NOT supported by the CPU.")
        set(SIMD_FOUND FALSE)
    endif()
else()
    message(STATUS "NEON is not supported by the compiler.")
    set(SIMD_FOUND FALSE)
endif()
