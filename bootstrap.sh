#!/bin/sh

DDIR="./deps"
ROOTDIR=`pwd`
DEPSDIR="$ROOTDIR/$DDIR"

mkdir -p $DEPSDIR
cd $DEPSDIR

# Make sure gproc is available
(
  if [ ! -d "$DEPSDIR/gen_leader_revival" ]; then
    git clone http://github.com/uwiger/gen_leader_revival.git
  fi
  cp gen_leader_revival/hanssv+serge_version/gen_leader.erl ../src
)
