#!/bin/sh

# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ #
#                ___           __           _       _             _                   #
#               / __\_ __ _ __/ _\ ___ _ __(_)_ __ | |_ ___   ___| |__                #
#              /__\// '__| '__\ \ / __| '__| | '_ \| __/ __| / __| '_ \               #
#             / \/  \ |  | |  _\ \ (__| |  | | |_) | |_\__ \_\__ \ | | |              #
#             \_____/_|  |_|  \__/\___|_|  |_| .__/ \__|___(_)___/_| |_|              #
#                                            |_|                                      #
# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+ #
# *********************************************************************************** #
# * With BrrScript you can use multiple scripts as a filter in Autobrr              * #
# *                                                                                 * #
# * Make sure to set up the script filter at the external tab inside Autobrr with   * #
# * the following parameters for this script to work:                               * #
# *   Command:   /config/scripts/brrscripts.sh                                      * #
# *   Arguments: {{.TorrentPathName}}                                               * #
# *                                                                                 * #
# *                                                                                 * #
# *                                                                                 * #
# *                           Created by: A. Hissink                                * #
# *                                                                                 * #
# *****************************************************************************//**** #


# Retrieve the absolute path to this script
a="/$0"; a="${a%/*}"; a="${a:-.}"; a="${a##/}/"; BINDIR=$(cd "$a"; pwd)

# Export variables to pass them to the other scripts
export SCRIPTDIR=$BINDIR
export TORRENTFILE=$1

# Run all scripts in the enabled folder
for file in $SCRIPTDIR/enabled/*.sh
do
  sh $file

  RETURN=$?

  if [ $RETURN -gt 0 ];
  then
    echo "NOT-OK ~ One of the scripts returned with exit code $RETURN"
    exit 1
  fi
done
echo "OK ~ All scripts returned with exit code $RETURN"
exit 0
