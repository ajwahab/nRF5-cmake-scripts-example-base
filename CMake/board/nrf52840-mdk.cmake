# must be set as cache strings to ensure they are not overwritten in mesh SDK
set(IC "nRF52840" CACHE STRING "IC")
set(PLATFORM "nrf52840_xxAA"  CACHE STRING "Platform")
set(SOFTDEVICE_TYPE "s140" CACHE STRING "SoftDevice type")
set(SOFTDEVICE_VERSION "7.2.0" CACHE STRING "SoftDevice version")

string(TOUPPER PLATFORM PLATFORM_CAPS)
string(TOUPPER SOFTDEVICE_TYPE SOFTDEVICE_TYPE_CAPS)
string(REGEX MATCH "^[0-9]" SOFTDEVICE_VERSION_MAJOR ${SOFTDEVICE_VERSION})
string(REPLACE "-" "_" BOARD_DEF "${BOARD}")
string(TOUPPER "${BOARD_DEF}" BOARD_DEF)

add_definitions(
        -DBOARD_CUSTOM
        -D${BOARD_DEF}
        -DCONFIG_GPIO_AS_PINRESET
        -DFLOAT_ABI_HARD
        -D${PLATFORM_CAPS}
        -DNRF_SD_BLE_API_VERSION=${SOFTDEVICE_VERSION_MAJOR}
        -D${SOFTDEVICE_TYPE_CAPS}
        -DSOFTDEVICE_PRESENT
        -DSWI_DISABLE0
        )

set(nrf52840_mdk_INCLUDE_DIRS
        "${CMAKE_CURRENT_SOURCE_DIR}/config"
        "${SDK_ROOT}/components/boards"
        )

include_directories("${nrf52840_mdk_INCLUDE_DIRS}")

add_compile_options(
        -mcpu=cortex-m4
        -mthumb
        -mabi=aapcs
        -Wall
        -Werror
        -mfloat-abi=hard
        -mfpu=fpv4-sp-d16
        )

set(ASMFLAGS "${ASMFLAGS}
        -g3
        -mcpu=cortex-m4
        -mthumb
        -mabi=aapcs
        -mfloat-abi=hard
        -mfpu=fpv4-sp-d16
        -DBOARD_CUSTOM
        -D${BOARD_DEF}
        -DCONFIG_GPIO_AS_PINRESET
        -DFLOAT_ABI_HARD
        -D${PLATFORM_CAPS}
        -DNRF_SD_BLE_API_VERSION=${SOFTDEVICE_VERSION_MAJOR}
        -D${SOFTDEVICE_TYPE_CAPS}
        -DSOFTDEVICE_PRESENT
        -DSWI_DISABLE0"
        )

set(dfu_pca10056_ble "${SDK_ROOT}/examples/dfu/secure_bootloader/pca10056_${SOFTDEVICE_TYPE}_ble")
#file(GLOB_RECURSE DFU_GLOB
#        CONFIGURE_DEPENDS
#        "${dfu_pca10056_ble}/armgcc/*"
#        "${dfu_pca10056_ble}/config/*"
#        )
#file(COPY ${DFU_GLOB} DESTINATION ${SDK_ROOT}/examples/dfu/secure_bootloader/${BOARD}_${SOFTDEVICE_TYPE}_ble)
file(COPY
        "${dfu_pca10056_ble}/armgcc/Makefile"
        "${dfu_pca10056_ble}/armgcc/secure_bootloader_gcc_nrf52.ld"
        DESTINATION "${dfu_pca10056_ble}/../${BOARD}_${SOFTDEVICE_TYPE}_ble/armgcc")
file(COPY
        "${dfu_pca10056_ble}/config/sdk_config.h"
        DESTINATION "${dfu_pca10056_ble}/../${BOARD}_${SOFTDEVICE_TYPE}_ble/config")

#set(nrf52840_mdk_DEFINES
#        -DBOARD_CUSTOM
#        -DNRF52840_MDK
#        -DCONFIG_GPIO_AS_PINRESET
#        -DFLOAT_ABI_HARD
#        -D${PLATFORM_CAPS}
#        -DNRF_SD_BLE_API_VERSION=${SOFTDEVICE_VERSION_MAJOR}
#        -D${SOFTDEVICE_TYPE_CAPS}
#        -DSOFTDEVICE_PRESENT
#        -DSWI_DISABLE0)

#set(nrf52840_mdk_INCLUDE_DIRS
#        "${SDK_ROOT}/components/boards")
