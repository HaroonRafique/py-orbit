command_exists () {
    type "$1" &> /dev/null ;
}


export ORBIT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "ORBIT installed in $ORBIT_ROOT"

export ORBIT_ARCH=`uname -s`


export PYTHON_VERSION=`python -c "from distutils import sysconfig; print sysconfig.get_config_var('VERSION');"`
echo "Python version is $PYTHON_VERSION"

PYTHON_LIB_DIR=`python -c "from distutils import sysconfig; print sysconfig.get_config_var('LIBPL');"`
if [ -f $PYTHON_LIB_DIR/libpython${PYTHON_VERSION}.a ]
   then
	export PYTHON_ROOT_LIB=$PYTHON_LIB_DIR/libpython${PYTHON_VERSION}.a
	LIB_TYPE=static
   else
	export PYTHON_ROOT_LIB="-L $PYTHON_LIB_DIR -lpython${PYTHON_VERSION}"
	LIB_TYPE=dynamic
fi

echo "Found python library: ${PYTHON_LIB_DIR} will use $LIB_TYPE library"

# export PYTHON_ROOT_LIB="$PYTHON_LIB_DIR/libpython${PYTHON_VERSION}.a $PYTHON_LIB_DIR/libpython${PYTHON_VERSION}.a" 
export PYTHON_ROOT_INC=`python -c "from distutils import sysconfig; print sysconfig.get_config_var('INCLUDEPY');"`
echo "Found Python include directory: $PYTHON_ROOT_INC"

export PYTHONPATH=${PYTHONPATH}:${ORBIT_ROOT}/py:${ORBIT_ROOT}/lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ORBIT_ROOT}/lib

######################################


IFPATH=`which ifort`
if [ $? == 0 ]; then
  IFDIR=${IFPATH///ifort}
  IN_INTEL_TARGET_ARCH=${IFDIR#*bin/}
  IFDIR=${IFDIR%/*} #must be twice
  IFDIR=${IFDIR%/*}
  IN_INTEL_TARGET_PLATFORM=${IFDIR##*/}
  IFDIR=${IFDIR%/*}
  echo $IFDIR $IN_INTEL_TARGET_ARCH $IN_INTEL_TARGET_PLATFORM
else
  echo "ifort is not configured"
fi


if [ -f  ${IFDIR}/${IN_INTEL_TARGET_PLATFORM}/bin/compilervars.sh ]; then
  source ${IFDIR}/${IN_INTEL_TARGET_PLATFORM}/bin/compilervars.sh -arch $IN_INTEL_TARGET_ARCH -platform $IN_INTEL_TARGET_PLATFORM
  export PROD_DIR INTEL_TARGET_ARCH
  echo "Configured intel from ${IFDIR}/${IN_INTEL_TARGET_PLATFORM}"
  echo "Exported  PROD_DIR=$PROD_DIR INTEL_TARGET_ARCH=$INTEL_TARGET_ARCH"
else
  echo "************************************************************"
  echo "Please configure your Intel compiler if you intend to use it"
  echo "Otherwise you need to comile with \"make COMP=gnu\""
  echo "************************************************************"
  
fi

if command_exists mpirun ; then
   echo "Found mpirun at: `which mpirun`"
   MPI_RUN_DIR=`dirname $(which mpirun)`
else
    MPI_RUN_DIR=`dirname $(find /usr 2>/dev/null| fgrep bin/mpirun | head -n1)`
    export PATH=$PATH:$MPI_RUN_DIR
    echo "Added  $MPI_RUN_DIR to PATH"
fi

export MPI_CPP=$MPI_RUN_DIR/mpicxx
echo "MPI_CPP set to $MPI_CPP"

