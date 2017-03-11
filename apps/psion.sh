function install {
	source $PKG_DB/$PKG
	echo "Installing $PKG...";
	cd $PSION_ROOT/src
	git clone $PKG_REPO $PKG
	cd $PKG
	if [ -f Makefile ]; then make; fi
	if [ -d bin ]; then mkdir -p $PSION_ROOT/apps/$PKG; cp bin/* $PSION_ROOT/apps/$PKG; fi
	if [ -d lib ]; then mkdir -p $PSION_ROOT/libraries/$PKG; cp lib/* $PSION_ROOT/libraries/$PKG; fi
	if [ -d include ]; then mkdir -p $PSION_ROOT/headers/$PKG; cp include/* $PSION_ROOT/headers/$PKG; fi
	if [ -d resources ]; then mkdir -p $PSION_ROOT/resources/$PKG; cp resources/* $PSION_ROOT/resources/$PKG; fi
	if [ -d config ]; then mkdir -p $PSION_ROOT/config/$PKG; cp config/* $PSION_ROOT/config/$PKG; fi
}

if [ -z ${PSION_ROOT+x} ]; then
	PSION_ROOT=~/.quark
fi

PKG_DB=$PSION_ROOT/resources/psion/pkg

while getopts ":i:r:?" opt; do
	case $opt in
		i)	PKG=$OPTARG
			install;;
		/?) echo "Invalid option -$OPTARG";;
	esac
done
