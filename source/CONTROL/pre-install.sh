#!/bin/sh

if [ -z "$APKG_PKG_DIR" ]; then
    PKG_DIR=/usr/local/AppCentral/radarr
else
    PKG_DIR=$APKG_PKG_DIR
fi

# Source env variables
. "${PKG_DIR}/CONTROL/env.sh"

case "${APKG_PKG_STATUS}" in
    install)
        ;;
    upgrade)
        # Back up configuration
        rsync -ra --exclude "config_base.xml" "$PKG_CONF/" "$APKG_TEMP_DIR/config/"

        # Back up application
        if [ -d "$PKG_DIR/Radarr" ]; then
            cp -af "$PKG_DIR/Radarr" "$APKG_TEMP_DIR/"
        fi
        ;;
    *)
        ;;
esac

exit 0
