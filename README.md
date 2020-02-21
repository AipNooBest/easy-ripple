# easy-ripple

Первый в мире, по сути единственный гайд по поднятию сервера osu! на коленке. Готовьтесь к сборной солянке, слезам и разбитым мониторам.
Первое, чем надо обзавестить - домен. Купите сразу. Aip купил на domains.webmoney.ru, DRV, в свою очередь на Hostinger. Выбирайте то, что нравится.
Далее, настоятельно рекомендуем купить VDS. Но если у вас есть какая-то своя машина под сервер - используйте, ничего страшного. На сервере должна **обязательно** стоять Debian 9 "stretch". Работа и совместимость компонентов на других версиях не гарантирована!

Для удобства скачайте на компьютер-клиент ряд программ:
```
PuTTY для доступа к консоли,
WinSCP(либо FileZilla) для доступа к файловой системе,
HeidiSQL для редактирования базы данных.
```
# Установка зависимостей
Откройте WinSCP, подключитесь к вашему серверу и с помощью значка(http://aipserver.ru/p/WinSCP_scr12170.png) запустите сессию PuTTY. После этого нам нужно установить все зависимости, необходимые для работы.
```
apt install sudo
sudo apt-get install gcc g++ build-essential
sudo apt-get install python3.5 python3-pip
sudo apt-get install git
sudo apt-get install vsftpd
sudo apt-get install nginx
sudo apt-get install php-fpm
sudo apt-get install composer
sudo apt-get install php7.0-mbstring
sudo apt-get install php7.0-curl
sudo apt-get install php-mysql
sudo apt-get install mc screen
sudo apt-get install luajit
sudo apt-get install golang-1.8
```
Далее нужно установить mySQL. Это делается особым путём. Для начала нам необходимо добавить в sources.list репозиторий с рабочей версией MySQL 5.6
```
sudo add-apt-repository -y ppa:ondrej/mysql-5.6
sudo apt-get update
```
Игнорируем ошибки, если они возникают, и устанавливаем сервер MySQL. Следите за тем, чтобы у вас поставился **именно MySQL**, а не MariaDB!
```
sudo apt-get install mysql-server-5.6
```
В том страшном случае, **если у вас поставился MariaDB - сносите** с помощью
```
sudo service mysql stop
sudo apt-get --purge remove mysql* -y
sudo apt-get --purge remove mariadb* -y
sudo apt-get autoremove
sudo apt-get autoclean
```
И ещё раз пробуем ставить mySQL.
Как дело с mySQL в шляпе переходим к репозиториям.
# Скачивание репозиториев
Открываем каталог **/var/www/html/**. Теперь это будет наш основной каталог. 
```
cd /var/www/html/
```
И начинаем по списку:
```
git clone --recursive https://github.com/AipNooBest/easy-ripple
git clone --recursive https://github.com/osuthailand/pep.py
git clone --recursive https://zxq.co/ripple/lets
git clone --recursive https://zxq.co/ripple/rippleapi
git clone --recursive https://zxq.co/ripple/hanayo
git clone --recursive https://github.com/osuripple/old-frontend
```
Обращаю внимание, что гарантированно появятся ошибки secret. Это нормально.
Далее:
```
git clone --recursive https://github.com/osufx/national-gallery
git clone --recursive https://github.com/osufx/secret
git clone --recursive https://github.com/osufx/ripple-python-common
```
Отлично. репозитории на месте.
Теперь нам необходимо зайти в папки lets и pep.py и установить нужные подмодули.
Перемещаем из нашего репозитория файлик requirements.txt, кидаем в папки LETS и pep.py **с заменой**. 
В каждой из папок выполняем данные команды:
```
git submodule init && git submodule update
pip3 install -r requirements.txt
python3 setup.py build_ext --inplace
```
Теперь нам необходимо добавить зависимости языка Go в файл bashrc для нормальной работы языка.
Открываем файл:
```
nano ~/.bashrc
```
И затем добавляем в него:
```
export PATH=/usr/lib/go-1.8/bin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOBIN=$GOPATH/bin
source ~/.bashrc
```
# Импорт базы данных
Для начала вам нужно создать пустую базу данных с произвольным названием:
**(Где 'пароль' - пароль от mySQL. Вводить слитно с -p без кавычек. Где 'БД' - название вашей базы данных тоже без кавычек)**
```
mysql -p'пароль'
create database 'БД';
quit
```
Делаем импорт с помощью:
```
mysql -p'пароль' 'БД' < /var/www/html/easy-ripple/ripple_database.sql
```
Таким образом получаем базу данных с готовыми таблицами. Чтобы проверить этот факт, можете сделать следующее:
```
mysql -p'пароль'
use 'БД'
SHOW TABLES;
```
# Настройка сервера
В примерах ниже замените DOMAIN на ваш домен.
Генерируем сертификат:
```
git clone https://github.com/Neilpang/acme.sh.git
cd acme.sh
systemctl stop nginx
./acme.sh --issue --standalone -d osu.DOMAIN -d c.DOMAIN -d a.DOMAIN -d oldripple.DOMAIN
systemctl start nginx
```
В данной папке у вас появятся два файла: **osu.DOMAIN.cer** и **osu.DOMAIN.key**, где DOMAIN - ваш домен.
Перенесите их в любое удобное вам место. Например, создайте папку certs и поместите туда данные сертификаты:
```
cd /var/www/html/
mkdir certs
mv /var/www/html/easy-ripple/acme.sh/osu.DOMAIN.cer certs/
mv /var/www/html/easy-ripple/acme.sh/osu.DOMAIN.key certs/
```
Возвращаемся в **/var/www/html/**. Теперь настроим сервер для хранения аватаров:
```
mkdir avatar && cd avatar && mkdir avatars
mv /var/www/html/easy-ripple/avatarserver.py /var/www/html/avatar/
python3 avatarserver.py
```
Затем переходим в каталог **/var/www/html/LETS/** и собираем калькулятор PP для его работы:
```
cd pp/oppai-ng/ && chmod +x ./build && ./build && cd ../../
```
Теперь сгенерируем сертификат для пользователей.
Переходим в **/var/www/html/easy-ripple** и запсукаем генератор:
```
./gencert.sh
```
В папке появятся два файла: **key.pem** и **cert.pem**. Второй файл вам необходимо сохранить на вашу основную машину и позже рассылать всем желающим подключиться к серверу(либо поместить в свитчер, если вы собираетесь делать свой). Сделать это можно либо через SFTP, либо просто скопировать всё содержимое сертификата в буфер обмена, создать новый файл на основной машине, вставить туда содержимое сертификата(включая BEGIN CERTIFICATE и END CERTIFICATE) и сохранить как файл cert.crt.
```
cat < cert.pem
```
Настроим конфиги. В первую очередь, конфиг сайта. Редактируем файл ripple.conf.
```
nano ripple.conf
```
Заменяете все DOMAIN на ваш домен и прописывайте пути к сертификатам там, где это необходимо. Если server_name заканчивается на .ppy.sh, то прописывайте путь к файлам cert.pem и key.pem. Если же заканчивается на ваш домен, то прописывайте путь к файлам osu.вашдомен.cer и osu.вашдомен.key.
Как закончили редактировать, переносим файл в директорию nginx и перезагружаем его:
```
cat ripple.conf > /etc/nginx/sites-available/default
sudo systemctl restart nginx
```
Настраиваете конфиги pep.py.config.ini и lets.config.ini и переносите их в соответствующие папки, попутно переименовав каждый в config.ini. Для нормальной работы osu!direct оставьте поле [cheesegull] нетронутым.
```
nano pep.py.config.ini
nano lets.config.ini
cp pep.py.config.ini ../pep.py/config.ini
cp lets.config.ini ../lets/config.ini
```
Точно также настраиваете hanayo.conf и перекидываете его в папку hanayo.
```
nano hanayo.conf
cp hanayo.conf ../hanayo/
```
После успешной настройки сервера вам необходимо заранее пофиксить синтаксические ошибки некоторых файлов(неизвестно, с чем это связано, возможно баги копирования файлов .py с GitHub или конвертирования версий, но факт остаётся фактом). К счастью, мы сделали всю работу за вас и вам остаётся лишь запустить скрипт починки файлов:
```
./fixsyntaxerrors.sh
```
