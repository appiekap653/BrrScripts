#!/bin/sh

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ #
#       __        ___                                                 _       _       #
#    /\ \ \___   / __\___  _ __ ___  _ __  _ __ ___  ___ ___  ___  __| |  ___| |__    #
#   /  \/ / _ \ / /  / _ \| '_ ` _ \| '_ \| '__/ _ \/ __/ __|/ _ \/ _` | / __| '_ \   #
#  / /\  / (_) / /__| (_) | | | | | | |_) | | |  __/\__ \__ \  __/ (_| |_\__ \ | | |  #
#  \_\ \/ \___/\____/\___/|_| |_| |_| .__/|_|  \___||___/___/\___|\__,_(_)___/_| |_|  #
#                                   |_|                                               #                                                                                   #
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ #
# *********************************************************************************** #
# * You can use this script to prevent Autobrr from downloading compressed torrents * #
# *                                                                                 * #
# * This script will take a look inside the .torrent file and read what type of     * #
# * files are present in it and if those are compressed or not.                     * #
# *                                                                                 * #
# * Exit code 1: Compressed files are present. do not download.                     * #
# *                                                                                 * #
# * Exit code 0: No compressed files. OK to download.                               * #
# *                                                                                 * #
# *                           Created by: A. Hissink                                * #
# *                                                                                 * #
# * Made possible with the use of TorrentCheck created by: inglem                   * #
# * Website: https://torrentcheck.sourceforge.io/                                   * #
# *****************************************************************************//**** #

NUMRAR=$($SCRIPTDIR/utils/torrentcheck "$TORRENTFILE" | \
awk 'x==1 {print $3} /^--- ----------- ---------------------------------------------------------------/ {x=1}' | \
grep -ci "\.rar$")

if [ "$NUMRAR" -gt 0 ]
then
  echo "NOT-OK ~ found $NUMRAR compressed file(s). do not download!" 
  exit 1
fi
echo "OK ~ found $NUMRAR compressed file(s). OK to download."
exit 0
