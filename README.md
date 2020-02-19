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
pip3 install flask
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
Качаем из репозитория файл requirements.txt, кидаем в папки LETS и pep.py **с заменой** 
В каждой из папок выполняем данные команды:
```
git submodule init && git submodule update
pip install -r requirements.txt
python3 setup.py build_ext --inplace
```
