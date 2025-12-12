set(pdal_platform_dependencies)
if (UNIX)
  list(APPEND pdal_platform_dependencies
    libxml2)
endif ()

set(pdal_zlib_include_dir)
if (zlib_enabled AND NOT USE_SYSTEM_zlib)
  list(APPEND pdal_zlib_include_dir
    -DZLIB_INCLUDE_DIR:PATH=<INSTALL_DIR>/include)
endif ()

superbuild_add_project(pdal
  DEPENDS
    gdal geotiff curl
  DEPENDS_OPTIONAL
    zlib zstd xerces ${pdal_platform_dependencies}
  LICENSE_FILES
    LICENSE.txt
  SPDX_LICENSE_IDENTIFIER
    BSD-3-Clause
  SPDX_COPYRIGHT_TEXT
    "Copyright (c) 2022, Hobu, Inc."
  CMAKE_ARGS
    -DWITH_TESTS:BOOL=OFF
    -DWITH_LZMA:BOOL=OFF
    -DWITH_ZLIB:BOOL=${zlib_enabled}
    -DWITH_ZSTD:BOOL=${zstd_enabled}
    -DBUILD_PLUGIN_HDF:BOOL=OFF
    -DBUILD_PLUGIN_E57:BOOL=${xerces_enabled}
    -DCMAKE_INSTALL_LIBDIR:STRING=lib
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    ${pdal_zlib_include_dir})

superbuild_apply_patch(pdal no-gtest
  "Avoid downloading gtest during configure")

include(CheckIncludeFileCXX)

if (zlib_enabled)
  superbuild_apply_patch(pdal zlib-include-dir "Fix zlib include directory")
endif()

check_include_file_cxx("filesystem" has_filesystem)
if (NOT has_filesystem)
  check_include_file_cxx("experimental/filesystem" has_experimental_filesystem)
  if (has_experimental_filesystem)
    superbuild_apply_patch(pdal fix-include-filesystem "Fix filesystem include")
  else()
    message(WARNING "Could not find <filesystem> or <experimental/filesystem> headers, PDAL may fail to compile")
  endif()
endif()
