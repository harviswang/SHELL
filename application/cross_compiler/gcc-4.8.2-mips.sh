#!/bin/bash
#tested under CentOS 7 x86_64(binutils-2.24.tar.bz2/gcc-4.8.2.tar.bz2/gdb-6.3.tar.bz2)
#test under FreeBSD11 X64(binutils-2.24.tar.bz2/gcc-4.8.2.tar.bz2/gdb-7.8.tar.gz)
#under FreeBSD11 using CC=gcc48, use gmake instead of make

# env setting
export WDIR=/home/harvis/Downloads/gcc-mips
export TARGET=mipsel-unknown-linux-gnu
export PREFIX=/usr/local/share/cross-compiler
export PATH="${PATH}":${PREFIX}/bin
cd $WDIR
mkdir ${TARGET}-toolchain  && cd ${TARGET}-toolchain
sudo mkdir -p $PREFIX


# get binutils-2.24.tar.bz2/gcc-4.8.2.tar.bz2/gdb-7.8.tar.bz2
cd $WDIR/${TARGET}-toolchain
#wget http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2
#wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2 
#wget http://ftp.gnu.org/gnu/gdb/gdb-6.3a.tar.bz2
#wget http://ftp.gnu.org/gnu/gdb/gdb-7.8.tar.gz


# compile binutils-2.24
cd $WDIR/${TARGET}-toolchain
tar xjf binutils-2.24.tar.bz2 
mkdir build-binutils && cd build-binutils
../binutils-2.24/configure --target=$TARGET --prefix=$PREFIX
#CC=gcc48 ../binutils-2.24/configure --target=$TARGET --prefix=$PREFIX
make
sudo make install


# get gmp/mpc/mpfr
cd $WDIR/${TARGET}-toolchain
#wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
#wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz
#wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2

# compile gmp-4.3.2.tar.bz2
cd $WDIR/${TARGET}-toolchain
tar xvf gmp-4.3.2.tar.bz2
cd gmp-4.3.2/
./configure --prefix=$PREFIX
#CC=gcc48 ./configure --prefix=$PREFIX
make
sudo make install

# compile mpfr-2.4.2.tar.bz2
cd $WDIR/${TARGET}-toolchain
tar xvf mpfr-2.4.2.tar.bz2
cd mpfr-2.4.2/
./configure --prefix=$PREFIX --with-gmp=$PREFIX
#CC=gcc48 ./configure --prefix=$PREFIX --with-gmp=$PREFIX
make
sudo make install

# compile mpc-0.8.1.tar.gz
cd $WDIR/${TARGET}-toolchain
tar xvf mpc-0.8.1.tar.gz 
cd mpc-0.8.1/
./configure --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX
#CC=gcc48 ./configure --prefix=$PREFIX --with-gmp=$PREFIX --with-mpfr=$PREFIX
make
sudo make install

# update LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PREFIX/lib/

# compile gcc-4.8.2.tar.bz2 
cd $WDIR/${TARGET}-toolchain
tar xvf gcc-4.8.2.tar.bz2 
mkdir build-gcc-bootstrap && cd build-gcc-bootstrap
../gcc-4.8.2/configure --target=$TARGET --prefix=$PREFIX --with-mpfr=$PREFIX --with-mpc=$PREFIX --with-gmp=$PREFIX --enable-languages=c --without-headers   --with-gnu-ld --with-gnu-as --disable-shared --disable-threads --disable-libmudflap --disable-libgomp --disable-libssp --disable-libquadmath --disable-libatomic
#CC=gcc48 ../gcc-4.8.2/configure --target=$TARGET --prefix=$PREFIX --with-mpfr=$PREFIX --with-mpc=$PREFIX --with-gmp=$PREFIX --enable-languages=c --without-headers   --with-gnu-ld --with-gnu-as --disable-shared --disable-threads --disable-libmudflap --disable-libgomp --disable-libssp --disable-libquadmath --disable-libatomic
make -j4
sudo make install

# compile gdb-6.3.tar.bz2
cd $WDIR/${TARGET}-toolchain
tar xjf gdb-6.3a.tar.bz2
mkdir build-gdb && cd build-gdb
#export C_INCLUDE_PATH=/usr/include:/usr/local/include
#export LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
../gdb-6.3/configure --target=$TARGET --prefix=$PREFIX
make -j4
sudo make install

# compile gdb-7.8.tar.gz
cd $WDIR/${TARGET}-toolchain
tar xjf gdb-7.8.tar.gz
mkdir build-gdb && cd build-gdb
#export C_INCLUDE_PATH=/usr/include:/usr/local/include
#export LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
CC=gcc48 ../gdb-7.8/configure --target=$TARGET --prefix=$PREFIX
make -j4
sudo make install

# create soft link for libgmp.so.3/libmpfr.so.1/libmpc.so.2/
# 如果能使用静态库链接就不需要创建软链接了, 还不知道怎么做?
sudo ln -s $PREFIX/lib/libgmp.so.3.5.2 /lib64/libgmp.so.3
sudo ln -s $PREFIX/lib/mpfr.so.1.2.2 /lib64/libmpfr.so.1
sudo ln -s $PREFIX/lib/libmpc.so.2.0.0 /lib64/libmpc.so.2
