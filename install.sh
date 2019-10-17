#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
NUKE_PRODUCT_VERSION=$2
NUKE_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "==============="
echo -e "=== INSTALL ==="
echo -e "==============="
echo -e "\n"

echo -e "[INSTALL][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[INSTALL][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[INSTALL][ARGS] NUKE VERSION: ${NUKE_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${INSTALL_PATH} || -z ${NUKE_VERSION} ]]; then
    echo -e "\n"
    echo -e "[INSTALL][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We install Nuke.
echo -e "\n"
echo -e "[INSTALL] Installing Nuke-${NUKE_VERSION}..."
echo -e "\n"

unzip \
    -o ${EXTRACT_PATH}/Nuke${NUKE_PRODUCT_VERSION}-linux-x86-release-64-installer \
    -d ${INSTALL_PATH}

echo -e "\n"
echo -e "[INSTALL] Finished installing Nuke-${NUKE_VERSION}!"
echo -e "\n"
