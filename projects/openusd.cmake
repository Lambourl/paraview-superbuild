# Based on https://github.com/f3d-app/f3d-superbuild/blob/main/projects/openusd.cmake, Copyright F3D-APP Foundation

superbuild_add_project(openusd
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    NOTICE.txt
    LICENSE.txt
  SPDX_LICENSE_IDENTIFIER
    "LicenseRef-openusd AND MIT AND BSD-2-Clause AND BSD-3-Clause AND Unlicense AND Apache-2.0 AND BSL-1.0 AND OFL-1.1"
  SPDX_COPYRIGHT_TEXT
    "Copyright 2016 Pixar" # NOTICE.txt
    "Copyright (C) 2015 THL A29 Limited, a Tencent company, and Milo Yip." # RapidJSON
    "Copyright (c) 2006-2013 Alexander Chemeris" # RapidJSON - The msinttypes r29
    "Copyright 2006-2011, the V8 project authors" # double-conversion
    "Copyright (c) 2002, Industrial Light & Magic, a division of Lucas Digital Ltd. LLC" # OpenEXR/IlmBase/Half
    "Copyright 2016 Eric Biggers" # libdeflate
    "Copyright (C) 2011-present, Yann Collet." # LZ4
    "Copyright (c) 2006-2019 Arseny Kapoulkine" # pugixml
    "Copyright (c) 2016 Sascha Willems" # Vulkan C++ examples and demos (dome light texture filtering)
    "Copyright (c) 1998-2015, Matt Pharr, Greg Humphreys, and Wenzel Jakob." # pbrt (Hammersley Low-Discrepancy Sampling Sequence)
    "Copyright The Draco Authors" # draco
    "Copyright 2011 The Roboto Project Authors" # roboto fonts
    "Copyright The Roboto Mono Project Authors" # roboto mono fonts
    "Copyright (c) 2017-2020 Advanced Micro Devices, Inc." # Vulkan memory allocator
    "Copyright 2017-2018 Google Inc." # spirv reflect
    "Copyright (c) 2008-2018 The Khronos Group Inc." # khrplatform.h
    "Copyright (c) 2020 mmikk" # surfgrad-bump-standalone-demo
    "Copyright (c) 2017 Thibaut Goetghebuer-Planchon <tessil@gmx.com>" #Tessil robin-map
    "CLI11 2.3.1 Copyright (c) 2017-2022 University of Cincinnati, developed by Henry Schreiner under NSF AWARD 1414736." # CLI11
    "Copyright (c) 2007-2022 Dr. Colin Hirsch and Daniel Frey" # The Art of C++ : PEGTL (Parsing Expression Grammar Template Library)
    "Copyright (c) 2021 - 2023 jothepro" # Doxygen Awesome
    "Copyright 2019 Joe Drago." # LibAvif v1.0.4
    "Copyright © 2018-2019, VideoLAN and dav1d authors" # AVIF/src/obu.c, renamed in this repository as AVIF/src/avif_obu.c
    "Copyright 2011 The LibYuv Project Authors." # AVIF/third_party/libyuv/*
    "Copyright (c) 2016, Alliance for Open Media." # libaom
    "Copyright Beman Dawes, David Abrahams, 1998-2005" # recovered from boost.common.cmake
    "Copyright Rene Rivera 2004-2007" # recovered from boost.common.cmake
  SPDX_CUSTOM_LICENSE_FILE
    LICENSE.txt
  SPDX_CUSTOM_LICENSE_NAME
    LicenseRef-openusd
  DEPENDS tbb
  CMAKE_ARGS
    -DPXR_BUILD_EXAMPLES:BOOL=OFF
    -DPXR_BUILD_IMAGING:BOOL=OFF
    -DPXR_BUILD_MONOLITHIC:BOOL=ON
    -DPXR_BUILD_TESTS:BOOL=OFF
    -DPXR_BUILD_TUTORIALS:BOOL=OFF
    -DPXR_BUILD_USD_TOOLS:BOOL=OFF
    -DPXR_ENABLE_GL_SUPPORT:BOOL=OFF
    -DPXR_ENABLE_PRECOMPILED_HEADERS:BOOL=OFF
    -DPXR_ENABLE_PYTHON_SUPPORT:BOOL=OFF
    -DPXR_INSTALL_LOCATION:STRING=../lib/usd
)

# Upstream issue for Windows DLL installation location: https://github.com/PixarAnimationStudios/OpenUSD/issues/2490
superbuild_apply_patch(openusd exported-targets "Add namespace to exported targets and fix Windows DLL installation destinations")
