# NEON - Supports post-2020 (Apple M-series)
# AVX2 - Supports post-2013 Intel, post-2015 AMD
# AVX512 - Supports post-2017 Intel, post-2022 AMD (7000 series onwards)

set(SIMD_FOUND FALSE)

if (ENABLE_SIMD)
  include(CheckCXXCompilerFlag)
  
  if(UNIX AND NOT APPLE)
    # Check for AVX-512 support
    include(cmake/simd_utils/check_avx512_support.cmake)

    if (NOT SIMD_FOUND)
      include(cmake/simd_utils/check_avx2_support.cmake)
    endif()

    if (NOT SIMD_FOUND)
      include(cmake/simd_utils/check_neon_support.cmake)
    endif()

    if(NOT SIMD_FOUND)
      message(STATUS "AVX2, AVX-512 and NEON are not supported by both the compiler and CPU.")
    endif()

  elseif(APPLE)
    # Only check for NEON intrinsics
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "arm*|aarch64*")
      message(STATUS "Compiler supports NEON SIMD instructions.")
      add_compile_options("-march=armv8-a+fp+simd+crypto+crc")
      add_definitions(-D__NEON__)
      set(SIMD_FOUND TRUE)
    elseif(NOT SIMD_FOUND)
      # Project does not need to support Apple x86
      message(WARNING "Apple ARM64 architecture detected but NEON support not available.")
    endif()
  endif()
endif()

if(MSVC)
    # Support only AVX2
    add_compile_options("/arch:AVX2")
    add_definitions(-D__AVX2__)
endif()