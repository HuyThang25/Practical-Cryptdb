apt update -y
apt remove bison libbison-dev -y
apt upgrade -y
apt install g++-4.7 gawk liblua5.1-0-dev libntl-dev libmysqlclient-dev libssl-dev libbsd-dev libevent-dev libglib2.0-dev libgmp-dev mysql-server libaio-dev automake gtk-doc-tools flex cmake libncurses5-dev make ruby lua5.1 libmysqld-dev exuberant-ctags cscope -y
cd packages;dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb;dpkg -i bison_2.7.1.dfsg-1_amd64.deb;cd ..


echo =============COMPILE MYSQL================================

rm -rf mysql-src
tar -xvf packages/mysql-src.tar.gz
export CXX=g++-4.7
cd mysql-src;mkdir build;cd build;cmake -DWITH_EMBEDDED_SERVER=on -DENABLE_DTRACE=off .. ; make;cd ../..;

echo ===============OK========================================


echo =============INSTALL MYSQL-proxy=========================

tar -xvf packages/mysql-proxy-0.8.5.tar.gz -C mysql-src/

binpath=`pwd`/mysql-src/mysql-proxy-0.8.5/bin

echo " " >> ~/.bashrc
echo PATH='$'PATH:${binpath} >> ~/.bashrc
source ~/.bashrc

echo =============INSTALL Cryptdb=============================

make
make install
chmod 0660 mysql-proxy.cnf

echo ============Enjoy it!!!=====================================
