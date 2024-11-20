# Check if the compiler supports generating AVX2 code
CHECK_CXX_COMPILER_FLAG("-mavx2" COMPILER_SUPPORTS_AVX2)

if(COMPILER_SUPPORTS_AVX2)
    # Run the shell command to check for AVX2 in /proc/cpuinfo
    execute_process(
        COMMAND /bin/sh -c "cat /proc/cpuinfo | grep avx2"
        OUTPUT_VARIABLE AVX2_CHECK_OUTPUT
        RESULT_VARIABLE AVX2_CHECK_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # Check if the output is empty
    if(AVX2_CHECK_OUTPUT STREQUAL "")
        message(STATUS "AVX2 is NOT mentioned in /proc/cpuinfo.")
        set(AVX2_IN_CPUINFO FALSE)
    else()
        message(STATUS "AVX2 is mentioned in /proc/cpuinfo.")
        set(AVX2_IN_CPUINFO TRUE)
    endif()

    # Check the result of the compilation
    if(AVX2_IN_CPUINFO)
        message(STATUS "AVX2 is supported by the CPU.")
        set(SIMD_FOUND TRUE)
        add_definitions(-mavx2)
    else()
        message(STATUS "AVX2 is NOT supported by the CPU.")
        message(WARNING "AVX2 is NOT supported by the CPU.")
        set(SIMD_FOUND FALSE)
    endif()
else()
    message(STATUS "AVX2 is not supported by the compiler.")
    set(SIMD_FOUND FALSE)
endif()
