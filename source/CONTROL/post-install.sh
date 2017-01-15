#!/bin/sh

if [ -z "$APKG_PKG_DIR" ]; then
    PKG_DIR=/usr/local/AppCentral/radarr
else
    PKG_DIR=$APKG_PKG_DIR
fi

# Source env variables
. "${PKG_DIR}/CONTROL/env.sh"

install_radarr() {
    tar xzf "$PKG_DIR"/.release/Radarr.*.tar.gz -C "$PKG_DIR/"
}

case "${APKG_PKG_STATUS}" in
    install)
        if [ ! -f "$PKG_CONF/config.xml" ]; then
            cp "$PKG_CONF/config_base.xml" "$PKG_CONF/config.xml"
        fi

        chown -R "$DAEMON_USER" "$PKG_CONF"

        install_radarr
        ;;
    upgrade)
        rsync -ra "$APKG_TEMP_DIR/config/" "$PKG_CONF/"

        # Restore application or extract included version
        if [ -d "$APKG_TEMP_DIR/Radarr" ]; then
            cp -af "$APKG_TEMP_DIR/Radarr" "$PKG_DIR/"
        else
            install_radarr
        fi
        ;;
    *)
        ;;
esac

chown -R "$DAEMON_USER" "$PKG_DIR/Radarr"

exit 0
