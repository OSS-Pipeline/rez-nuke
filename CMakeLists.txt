CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

# We split the Nuke version string in multiple ones.
string(REPLACE "." ";" NUKE_VERSION_LIST ${REZ_BUILD_PROJECT_VERSION})
list(GET NUKE_VERSION_LIST 0 NUKE_MAJOR_VERSION)
list(GET NUKE_VERSION_LIST 1 NUKE_MINOR_VERSION)
list(GET NUKE_VERSION_LIST 2 NUKE_PATCH_VERSION)

set(NUKE_PRODUCT_VERSION ${NUKE_MAJOR_VERSION}.${NUKE_MINOR_VERSION}v${NUKE_PATCH_VERSION})

# Nuke
rez_set_archive(
    NUKE_URL nuke/Nuke${NUKE_PRODUCT_VERSION}-linux-x86-release-64.tgz
    https://www.foundry.com/products/download_product?file=Nuke${NUKE_PRODUCT_VERSION}-linux-x86-release-64.tgz
)

configure_file(config/nuke.in config/nuke @ONLY)

# The environment variable REZ_TMP_PATH is meant to point to a location such as "/tmp/rez".
set(EXTRACT_DIR $ENV{REZ_TMP_PATH}/nuke/${REZ_BUILD_PROJECT_VERSION})

# We configure/build/install Nuke through the ExternalProject_Add macro,
# using three different shell scripts for each of these steps.
# If necessary, it is possible to skip one of these steps by replacing the command
# by "", an empty string.
ExternalProject_Add(
    REZ_NUKE
    URL ${NUKE_URL}
    PREFIX nuke
    SOURCE_DIR ${EXTRACT_DIR}
    PATCH_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND bash ${CMAKE_SOURCE_DIR}/install.sh ${EXTRACT_DIR} ${NUKE_PRODUCT_VERSION}
)

install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/config/nuke
    DESTINATION .
)

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] Nuke-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
