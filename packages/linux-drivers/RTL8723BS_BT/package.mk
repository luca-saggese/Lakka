################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="RTL8723BS_BT"
PKG_VERSION="09eb91f"
PKG_REV="1" 
PKG_ARCH="any"
PKG_LICENSE="GPL"
# amlogic: PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_SITE="https://github.com/lwfinger/rtl8723bs_bt"

PKG_URL="http://latexpatterns.com/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="rtl8723BS-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Amlogic RTL8723BS Linux 3.x driver"
PKG_LONGDESC="RTL8723BS-BT: Realtek RTL8723BS Linux 3.x driver used in some devices based on Amlogic SoCs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=$TARGET_ARCH \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=$TARGET_PREFIX \
       CONFIG_POWER_SAVING=n
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
  mkdir -p $INSTALL/lib/firmware/rtl_bt
    cp rtlbt_fw* $INSTALL/lib/firmware/rtl_bt/
  mkdir -p $INSTALL/usr/bin/
  	cp -p *.sh $INSTALL/usr/bin/
  	cp -p rtk_hciattach $INSTALL/usr/bin/
}
