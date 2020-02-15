# easy-ripple

Первый в мире, по сути единственный гайд по поднятию сервера osu! на коленке. Готовьтесь к сборной солянке, слезам и разбитым мониторам.
Первое, чем надо обзавестить - домен. Купите сразу. Aip купил на domains.webmoney.ru, DRV, в свою очередь на Hostinger. Выбирайте то, что нравится.
Далее, настоятельно рекомендуем купить VDS. Но если у вас есть какая-то своя машина под сервер - используйте, ничего страшного. На сервере должна **обязательно** стоять Debian 9 "stretch".Работа и совместимость компонентов на других версиях не гарантирована!

Для удобства скачайте на компьютер-клиент ряд программ:
```
PuTTY для доступа к консоли,
WinSCP(либо FileZilla) для доступа к файловой системе,
HeidiSQL для редактирования базы данных.
```
Далее отправляйтесь на ваш сервер. Откройте WinSCP, подключитесь к вашему серверу и с помощью значка(http://aipserver.ru/p/WinSCP_scr12170.png) запустите сессию PuTTY. После этого нам необходимо
```
apt install sudo
sudo apt install gcc g++ build-essential
sudo apt install python3.5 python3-pip
sudo apt install git
sudo apt install vsftpd
sudo apt install nginx
sudo apt install php-fpm
sudo apt install composer
sudo apt install php7.0-mbstring
sudo apt install php7.0-curl
sudo apt install php-mysql
sudo apt install mc screen
sudo apt install luajit
```
Далее нужно установить mySQL. Это делается особым путём. Для начала нам необходимо добавить в sources.list репозиторий с рабочей версией MySQL 5.6
```
sudo add-apt-repository -y ppa:ondrej/mysql-5.6
sudo apt-get update
```
Игнорируем ошибки, если они возникают, и устанавливаем сервер MySQL. Следите за тем, чтобы у вас поставился именно MySQL, а не MariaDB!
```
sudo apt-get install mysql-server-5.6
```
