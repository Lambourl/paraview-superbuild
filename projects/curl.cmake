set(curl_optional_depends)
if (ALLOW_openssl)
  list(APPEND curl_optional_depends
    openssl)
endif ()

superbuild_add_project(curl
  DEPENDS_OPTIONAL ${curl_optional_depends}
  CAN_USE_SYSTEM
  LICENSE_FILES
    COPYING
  SPDX_LICENSE_IDENTIFIER
    MIT
  SPDX_COPYRIGHT_TEXT
    "Copyright (c) 1996 - 2023, Daniel Stenberg and many contributors"
  CMAKE_ARGS
    -DCMAKE_INSTALL_LIBDIR:STRING=lib
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    -DCURL_USE_OPENSSL:BOOL=${openssl_enabled}
    -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS})

# https://github.com/curl/curl/commit/619307feb09fb48feb9a24bbe5655dfcc8f17a3a
superbuild_apply_patch(curl fix-building-docs-with-dot3-in-base-dir
  "Fix building docs when the base directory contains .3")
