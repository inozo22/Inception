#!/bin/sh

# Skip if the directory "/run/mysql" exists.  
# If not, it creates the directory and sets ownership to the mysql user.
if [ ! -d "/run/mysql" ]; then
	echo "[i] /run/mysqld creating..."
	mkdir -p /run/mysqld
fi
chown -R mysql:mysql /run/mysqld

# Skip if the MySQL database directory "/var/lib/mysql/mysql" exists. 
# If not, it initializes the MySQL database, sets ownership, 
# and performs some initial configurations.
if [ ! -d /var/lib/mysql/mysql ]; then
	echo "[i] initial database creating..."
	#chown は /var/lib/mysql ディレクトリの所有者を mysql ユーザーとグループに変更する。
	chown -R mysql:mysql /var/lib/mysql
	chown -R mysql /var/lib/mysql
	# mysql_install_db は MySQL データディレクトリを指定されたパラメータ (--user, --basedir, --datadir) 
	# で初期化する。出力 (--rpm) は /dev/null にリダイレクトされ、不要な情報を抑制する。
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null

 # Generates a temporary file with MySQL queries and executes them using mysqld. 
 # The queries include setting up the root user and privileges, 
 # creating a database, and creating a user for a WordPress database.

  # 一時ファイル ($tfile) は、ファイルが存在することを確認するループで作成される
  tfile=""
  while [ ! -f "$tfile" ]; do
    tfile=$(mktemp)
  done
  # MySQL クエリは一時ファイルに書き込まれます using cat。
  # これらのクエリーには、ルートユーザーの設定、権限の設定、データベースの作成、
  # WordPressデータベース用のユーザーの作成などが含まれる。
	cat << EOF > $tfile
USE mysql ;
FLUSH PRIVILEGES ;
DROP DATABASE IF EXISTS test ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
SET PASSWORD FOR 'root'@'%'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci ;
CREATE USER '$WP_DB_USER'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE USER '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'%';
FLUSH PRIVILEGES ;
EOF
  # 1. rootは全部のDBの権限
  # 2. WP_DB_NAMEというDBにアクセスできるWP_DB_USERというユーザーを作成。
  # mysqld --user=mysql --bootstrap は MySQL をブートストラップモードで実行し、
  # テンポラリファイルで提供されたクエリを処理。
	/usr/bin/mysqld --user=mysql --bootstrap < $tfile
  # The temporary file is then removed.
  rm -f $tfile
fi
 
# executes the command specified when running the script, 
# passing along any command-line arguments. 
# This is often used to start the main process of the Docker container.
exec "$@"