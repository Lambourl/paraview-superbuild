set(medreader_options)
if (UNIX AND NOT APPLE)
  set(medreader_rpath_entries
    <INSTALL_DIR>/lib)
  if (qt6_enabled)
    list(APPEND medreader_rpath_entries
      "${qt6_rpath}")
  endif ()
  list(JOIN medreader_rpath_entries "${_superbuild_list_separator}" medreader_rpath_entries)
  list(APPEND medreader_options
    -DCMAKE_INSTALL_RPATH:STRING=${medreader_rpath_entries})
endif ()

superbuild_add_project(medreader
  DEPENDS medfile medconfiguration medcoupling boost paraview
  DEPENDS_OPTIONAL mpi qt5 qt6
  LICENSE_FILES COPYING
  SPDX_LICENSE_IDENTIFIER
    LGPL-2.1-or-later
  SPDX_COPYRIGHT_TEXT
    # No copyright specified, extrapolated from some source files
    "Copyright (C) CEA/DEN, EDF R&D"
  CMAKE_ARGS
   -DCONFIGURATION_ROOT_DIR=<INSTALL_DIR>/configuration
   -DMEDCOUPLING_ROOT_DIR=<INSTALL_DIR>
   -DMEDFILE_ROOT_DIR=<INSTALL_DIR>
   -DMEDREADER_USE_MPI:BOOL=${mpi_enabled}
   -DSALOME_USE_MPI:BOOL=${mpi_enabled}
   -DCMAKE_INSTALL_LIBDIR:PATH=lib
   ${medreader_options}
)

superbuild_apply_patch(medreader install-medloaderforpv-in-correct-directory
  "Fix MEDLoaderForPV installation directory")

superbuild_apply_patch(medreader remove-custom-install
  "Remove custom installation")

superbuild_apply_patch(medreader add-missing-license
  "Add missing license")

superbuild_apply_patch(medreader quadrature-dataset
  "Update quadrature point generation")

superbuild_apply_patch(medreader pqTreeWidget-margins-api
  "Fix pqTreeWidget deprecated margin API usage")

# https://github.com/SalomePlatform/medreader/pull/2
superbuild_apply_patch(medreader iostream
  "Fix `iostream` bits")

# https://github.com/SalomePlatform/medreader/pull/3
superbuild_apply_patch(medreader required-on
  "Ensure MEDReader plugin is loaded on client and server")

# https://github.com/SalomePlatform/medreader/pull/4
superbuild_apply_patch(medreader prevent-python-include-install
  "Prevent installation of faulty Python.h")
