################################################################################
#
# sx127x
#
################################################################################

SX127X_VERSION = 0c3c86dc13edbd4d7f64b6ee43189c07b72badad
SX127X_SITE = $(call github,fifteenhex,sx127x,$(SX127X_VERSION))
SX127X_LICENSE = GPL-2.0
SX127X_LICENSE_FILES = LICENSE

$(eval $(kernel-module))
$(eval $(generic-package))
