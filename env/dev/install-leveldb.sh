#!/bin/bash

PREFIX=/usr/local
INCLUDE=$PREFIX/include
LIB_DIR=$PREFIX/lib
BIN_DIR=$PREFIX/bin


function assert_root() {
	if [ ! $(id -u) == 0 ] ; then
		echo "you are not root!"
		exit 1
	fi
}

function usage() {
	echo "$0 install|uninstall|check"
}

function check() {
	ls $INCLUDE/leveldb
	ls -l $LIB_DIR/libleveldb.a $LIB_DIR/libleveldb.so* $LIB_DIR/libmemenv.a $BIN_DIR/leveldbutil
}

function myinstall(){
	cp leveldbutil $BIN_DIR/leveldbutil
	cp -r include/leveldb $INCLUDE/leveldb
	cp libleveldb.a $LIB_DIR/libleveldb.a
	cp libleveldb.so* $LIB_DIR/
	cp libmemenv.a $LIB_DIR/libmemenv.a
	check
}

function myuninstall(){
	if [ -f $BIN_DIR/leveldbutil ] ; then
		rm $BIN_DIR/leveldbutil
	fi

	if [ -d $INCLUDE/leveldb ] ; then
		rm -r $INCLUDE/leveldb
	fi

	if [ -f $LIB_DIR/libleveldb.a ] ; then
		rm $LIB_DIR/libleveldb.a
		rm -f $LIB_DIR/libleveldb.so*
		rm -f $LIB_DIR/libmemenv.a
	fi
}

case "$1" in
	"-h" | "-?" | "-help") usage ;;
	"install" ) assert_root ; myinstall; echo "Install done" ;;
	"uninstall" ) assert_root ; myuninstall; echo "Uninstall done" ;;
	"check" ) check ;;
	*) usage ;;
esac

exit 0
