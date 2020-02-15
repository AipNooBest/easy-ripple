# easy-ripple

Первый в мире, по сути единственный гайд по поднятию сервера osu! на коленке. Готовьтесь к сборной солянке, слезам и разбитым мониторам.
Первое, чем надо обзавестить - домен. Купите сразу. Aip купил на domains.webmoney.ru, DRV, в свою очередь на Hostinger. Выбирайте то, что нравится.
Далее, настоятельно рекомендуем купить VDS. Но если у вас есть какая-то своя машина под сервер - используйте, ничего страшного.
Для удобства скачайте на компьютер-клиент ряд программ:
```
PuTTY для доступа к консоли
WinSCP(либо FileZilla) для доступа к файловой системе
HeidiSQL для редактирования базы данных
```
Далее отправляйтесь на ваш сервер. Откройте WinSCP и с помощью значка запустите сессию PuTTY.
```
apt install sudo
sudo apt install gcc g++ build-essential
sudo apt install python3.5 python3-pip
sudo apt install git
sudo apt install redis-server
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
Далее нужно установить mySQL. Это делается особым путём.
