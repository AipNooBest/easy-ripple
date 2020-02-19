#!/bin/bash
printf "MySQL username: "
read mysqlu
printf "MySQL пароль: "
read mysqlp
printf "Название базы данных: "
read db
printf "Кому сменить права(username): "
read username
printf "\nКакие права выдать? Введите id группы:"
printf "\n1) Забаненные"
printf "\n2) BAT(Проверяющие карты)"
printf "\n3) Модераторы чата"
printf "\n4) Администратор"
printf "\n5) Разработчик"
printf "\n6) Донор"
printf "\n7) Бог"
printf "\n8) Нормальный пользователь"
printf "\n9) В обработке"
printf "\n10) Restricted"
printf "\n11) Beatmap Nominator"
printf "\n12) Полные права"
printf "\n13) Менеджер сообщества"
printf "\n\nID группы: "
read id
if [ $id = 1 ]; then
	privileges=0
elif [ $id = 2 ]; then
	privileges=267
elif [ $id = 3 ]; then
	privileges=2883911
elif [ $id = 4 ]; then
	privileges=1048575
elif [ $id = 5 ]; then
	privileges=1043995
elif [ $id = 6 ]; then
	privileges=7
elif [ $id = 7 ]; then
	privileges=1048575
elif [ $id = 8 ]; then
	privileges=3
elif [ $id = 9 ]; then
	privileges=1048576
elif [ $id = 10 ]; then
	privileges=2
elif [ $id = 11 ]; then
	privileges=267
elif [ $id = 12 ]; then
	privileges=3145727
elif [ $id = 13 ]; then
	privileges=918015
else
	echo Введите ID от 1 до 13!
	return
fi
mysql -u $mysqlu -p$mysqlp -e "use $db; UPDATE users SET privileges = $privileges WHERE username = '$username';"
echo Готово!