# game/app specific values
export APP_VERSION="0.6.0"
export ICONSDIR="common/arch/cocoa"

#constants
source ../MSPScripts/constants.sh

rm -rf ${BUILT_PRODUCTS_DIR}

#because this port does so much of the work itself all we need to do is 
#run the build command twice for the two platforms
rm -rf ${X86_64_BUILD_FOLDER}
echo /usr/local/bin/scons opengl=1 sdlmixer=1 d1x=1 d2x=1 macos_add_frameworks=0 builddir=${X86_64_BUILD_FOLDER} PKG_CONFIG=/usr/local/bin/pkg-config --config=force
/usr/local/bin/scons opengl=1 sdlmixer=1 d1x=1 d2x=1 macos_add_frameworks=0 builddir=${X86_64_BUILD_FOLDER} PKG_CONFIG=/usr/local/bin/pkg-config --config=force

rm -rf ${ARM64_BUILD_FOLDER}
echo scons opengl=1 sdlmixer=1 d1x=1 d2x=1 macos_add_frameworks=0 builddir=${ARM64_BUILD_FOLDER} --config=force
scons opengl=1 sdlmixer=1 d1x=1 d2x=1 macos_add_frameworks=0 builddir=${ARM64_BUILD_FOLDER} --config=force

mkdir ${BUILT_PRODUCTS_DIR}

#descent1 values
export ICONSFILENAME="d1x-rebirth"
export PRODUCT_NAME="D1X-Rebirth"
export EXECUTABLE_NAME="d1x-rebirth"
export PKGINFO="APPLD1XR"
export COPYRIGHT_TEXT="Descent © 1995 InterPlay. All rights reserved."

# have to re-do all the variables cascading down from PRODUCT_NAME
export WRAPPER_NAME="${PRODUCT_NAME}.app"
export CONTENTS_FOLDER_PATH="${WRAPPER_NAME}/Contents"
export EXECUTABLE_FOLDER_PATH="${CONTENTS_FOLDER_PATH}/MacOS"
export BUNDLE_ID="com.macsourceports.${PRODUCT_NAME}"
export UNLOCALIZED_RESOURCES_FOLDER_PATH="${CONTENTS_FOLDER_PATH}/Resources"
export FRAMEWORKS_FOLDER_PATH="${CONTENTS_FOLDER_PATH}/Frameworks"
export ICONS="${ICONSFILENAME}.icns"

# create the app bundle
"../MSPScripts/build_app_bundle.sh"

#sign and notarize
"../MSPScripts/sign_and_notarize.sh" "$1"

#descent2 values
export ICONSFILENAME="d2x-rebirth"
export PRODUCT_NAME="D2X-Rebirth"
export EXECUTABLE_NAME="d2x-rebirth"
export PKGINFO="APPLD2XR"
export COPYRIGHT_TEXT="Descent © 1996 InterPlay. All rights reserved."
export ICONS="${ICONSFILENAME}.icns"

# have to re-do all the variables cascading down from PRODUCT_NAME
export WRAPPER_NAME="${PRODUCT_NAME}.app"
export CONTENTS_FOLDER_PATH="${WRAPPER_NAME}/Contents"
export EXECUTABLE_FOLDER_PATH="${CONTENTS_FOLDER_PATH}/MacOS"
export BUNDLE_ID="com.macsourceports.${PRODUCT_NAME}"
export UNLOCALIZED_RESOURCES_FOLDER_PATH="${CONTENTS_FOLDER_PATH}/Resources"
export FRAMEWORKS_FOLDER_PATH="${CONTENTS_FOLDER_PATH}/Frameworks"

# create the app bundle
"../MSPScripts/build_app_bundle.sh"

#sign and notarize
"../MSPScripts/sign_and_notarize.sh" "$1"