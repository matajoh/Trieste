# Header-only: Release and Debug are identical.
set(VCPKG_BUILD_TYPE release)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO microsoft/Trieste
    REF "${VERSION}"
    SHA512 0  # Update with actual hash when tagging a release
    HEAD_REF main
)

# NOTE: The CI overlay port (see .github/workflows/buildtest.yml,
# vcpkg-integration) uses sed to extract from this line onwards to build a
# portfile that points at the local checkout. If you reorder code above this
# line, update the sed pattern there.
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DTRIESTE_USE_FETCH_CONTENT=OFF
        -DTRIESTE_BUILD_SAMPLES=OFF
        -DTRIESTE_BUILD_PARSERS=OFF
        -DTRIESTE_ENABLE_TESTING=OFF
        -DTRIESTE_USE_SNMALLOC=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME trieste CONFIG_PATH share/trieste/cmake)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
