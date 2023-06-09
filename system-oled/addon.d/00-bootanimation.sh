#!/sbin/sh
#
# ADDOND_VERSION=3
#
# /system/addon.d/00-bootanimation.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
/system/media/bootanimation.zip
END
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    for i in $(list_files); do
      f=$(get_output_path "$S/$i")
      chown root:root $f
      chmod 644 $f
      chmod 755 $(dirname $f)
    done
  ;;
esac
