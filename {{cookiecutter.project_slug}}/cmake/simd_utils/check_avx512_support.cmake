# Check if the compiler supports generating AVX512 code
CHECK_CXX_COMPILER_FLAG("-mavx512f" COMPILER_SUPPORTS_AVX512)

if(COMPILER_SUPPORTS_AVX512)
    # Run the shell command to check for AVX512 in /proc/cpuinfo
    execute_process(
        COMMAND /bin/sh -c "cat /proc/cpuinfo | grep avx512"
        OUTPUT_VARIABLE AVX512_CHECK_OUTPUT
        RESULT_VARIABLE AVX512_CHECK_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # Check if the output is empty
    if(AVX512_CHECK_OUTPUT STREQUAL "")
        message(STATUS "AVX512 is NOT mentioned in /proc/cpuinfo.")
        set(AVX512_IN_CPUINFO FALSE)
    else()
        message(STATUS "AVX512 is mentioned in /proc/cpuinfo.")
        set(AVX512_IN_CPUINFO TRUE)
    endif()

    # Check the result of the compilation
    if(AVX512_IN_CPUINFO)
        message(STATUS "AVX512 is supported by the CPU.")
        set(SIMD_FOUND TRUE)
        add_definitions(-mavx512f)
    else()
        message(STATUS "AVX512 is NOT supported by the CPU.")
        message(WARNING "AVX512 is NOT supported by the CPU.")
        set(SIMD_FOUND FALSE)
    endif()
else()
    message(STATUS "AVX512 is not supported by the compiler.")
    set(SIMD_FOUND FALSE)
endif()
