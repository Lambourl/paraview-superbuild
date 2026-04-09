superbuild_add_project(openvdb
  DEPENDS tbb cxx17 blosc zlib boost
  LICENSE_FILES
    LICENSE
  SPDX_LICENSE_IDENTIFIER
    MPL-2.0
  SPDX_COPYRIGHT_TEXT
    "Copyright Contributors to the OpenVDB project"
  CMAKE_ARGS
    -DUSE_BLOSC:BOOL=ON
    -DUSE_ZLIB:BOOL=ON
    -DUSE_CCACHE:BOOL=OFF
    -DOPENVDB_BUILD_NANOVDB:BOOL=ON
    -DUSE_NANOVDB:BOOL=ON
    -DNANOVDB_USE_OPENVDB:BOOL=ON
    -DOPENVDB_CORE_STATIC:BOOL=OFF
    -DCMAKE_INSTALL_LIBDIR:PATH=lib)

# This code below can be removed when OpenVDB is updated to version 12.1.0 or later
# That version is known to compile on LLVM 17 and later without this flag.
include(CheckCompilerFlag)
set(no_missing_template_arg_list_flag "-Wno-missing-template-arg-list-after-template-kw")
check_compiler_flag(CXX ${no_missing_template_arg_list_flag} has_no_missing_template_arg_list_flag)
if (has_no_missing_template_arg_list_flag)
  superbuild_append_flags(cxx_flags ${no_missing_template_arg_list_flag} PROJECT_ONLY)
endif ()

superbuild_add_extra_cmake_args(
  -DOpenVDB_CMAKE_PATH:PATH=<INSTALL_DIR>/lib/cmake/OpenVDB
)

superbuild_apply_patch(openvdb tbb-disable-autolink
  "Disable TBB autolinking")


# backport some fixes from 13.0.0: https://github.com/AcademySoftwareFoundation/openvdb/commit/930c3acb8e0c7c2f1373f3a70dc197f5d04dfe74
superbuild_apply_patch(openvdb v13-backports "Backport fixes from OpenVDB 13.0.0")
