# Безопасность

<details>
<summary>Показать/скрыть</summary>

# Создание нового пользователя
    adduser x

# Добавление пользователя в группу sudo (опционально, для предоставления админ-доступа)
    usermod -aG sudo x

# Переключение на нового пользователя
    su x

# Создание директории для хранения SSH-ключей
    mkdir -p ~/.ssh

# Открытие файла для добавления публичного ключа
    nano ~/.ssh/authorized_keys

# (Вставьте сюда содержимое публичного ключа из PuTTYgen и сохраните файл)

# Установка корректных прав доступа к директории и файлу ключей
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

# Переключение обратно на root (если необходимо)
    exit

# Открытие конфигурационного файла SSH для редактирования
    nano /etc/ssh/sshd_config

Заменить порт

Port 22102

Найдите строку "PermitRootLogin yes" и замените её на "PermitRootLogin no", 

При необходимости измените "PasswordAuthentication yes" на "PasswordAuthentication no"

# Перезапуск службы SSH для применения изменений
    systemctl restart ssh

# Установка UFW
    sudo apt update
    sudo apt install ufw

# Открыть порты
    sudo ufw allow 22102/tcp #ssh
    sudo ufw allow 443/tcp #https
    sudo ufw allow 80/tcp #http
    sudo ufw allow 20196/tcp #subscribe
    sudo ufw allow 38777/tcp #pannel

# Блокировка ICMP-запросов для предотвращения двустороннего пинга
    sudo nano /etc/ufw/before.rules
    
    # ok icmp codes for INPUT
    -A ufw-before-input -p icmp --icmp-type destination-unreachable -j DROP
    -A ufw-before-input -p icmp --icmp-type time-exceeded -j DROP
    -A ufw-before-input -p icmp --icmp-type parameter-problem -j DROP
    -A ufw-before-input -p icmp --icmp-type echo-request -j DROP
    -A ufw-before-input -p icmp --icmp-type source-quench -j DROP

    # ok icmp code for FORWARD
    -A ufw-before-forward -p icmp --icmp-type destination-unreachable -j DROP
    -A ufw-before-forward -p icmp --icmp-type time-exceeded -j DROP
    -A ufw-before-forward -p icmp --icmp-type parameter-problem -j DROP
    -A ufw-before-forward -p icmp --icmp-type echo-request -j DROP

    sudo ufw enable

    reboot

# Проверить статус UFW
    sudo ufw status verbose

#  Вход под root:
    su root(с паролем root), sudo -i (с парлем user)

</details>


# Насторойка 3x-ui с самоподписанным SSL сертификатом

<details>
<summary>Показать/скрыть</summary>

# Скачиваем скрипт
    wget https://raw.githubusercontent.com/kir460/3x/main/ui.sh

# Предоставление прав на выполнение скрипта
    chmod +x ui.sh

</details>


# Насторойка 3x-ui с доменом

<details>
<summary>Показать/скрыть</summary>

https://github.com/MHSanaei/3x-ui

bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)

# Устоновка SSL
    x-ui
    18
    1
    domain
    80

# Подписка
Включить подписку
Порт подписки 20196
Корневой путь URL-адреса подписки /tv/
Путь к файлу открытого ключа сертификата подписки /root/cert/p.kirnetwiz.top/fullchain.pem
Путь к файлу закрытого ключа сертификата подписки /root/cert/p.kirnetwiz.top/privkey.pem
Интервалы обновления подписки 1

# Telegram-бот: Удалённое управление сервером, подключениями и мониторингом.

Создаём бота
@BotFather

ПолучАем id
@userinfobot

![image](https://github.com/user-attachments/assets/612dc1e8-c923-411b-9745-40f5f389794f)


# Port hopping

1 Открыть диапозон адресов

    sudo ufw allow 30000:30100/tcp
    sudo ufw allow 30000:30100/udp

2 Проверить что xRay работает на порту 443

3 Настройка Port Hopping через iptables. 

    sudo iptables -t nat -A PREROUTING -p tcp --dport 30000:30100 -j REDIRECT --to-port 443
    sudo iptables -t nat -A PREROUTING -p udp --dport 30000:30100 -j REDIRECT --to-port 443

4 Сохранение правил iptables

    sudo apt install -y iptables-persistent
    sudo netfilter-persistent save
    sudo netfilter-persistent reload

5 Проверка применения правил

    sudo iptables -t nat -L -v -n

6 Убедитесь, что порт 443 слушается:

    sudo lsof -i -P -n | grep LISTEN

# Speedtest c сервера

    wget -qO- speedtest.artydev.ru | bash

# Speedtest до конкретного сервера

bash <(curl -s https://raw.githubusercontent.com/kir460/3x/main/sped.sh)

# Fail2Ban

    x-ui
    20
    1
    y
    enter
    20
    4

    Логи
    20
    7

# IP.Check.Place: Проверка репутации IP-адреса. Предварительно можно понять "чистоту" IP и пройтись по публичным спискам об IP.

bash <(curl -Ls IP.Check.Place) -l en

My Traceroute (MTR): Утилита для диагностики сети. Утилита позволяет отследить маршрут пакетов и выявить проблемные узлы.

    mtr ya.ru
    mtr ip-address

# bbr

Проверить работу на сервере, вводим:
        
    sysctl net.ipv4.tcp_congestion_control
Работает - bbr нет - cubik

Включить

    x-ui
    23
    1
    
# DNS-over-LESS 

    tcp://8.8.8.8
    tcp://1.1.1.1
    https://dns.google/dns-query
    https://cloudflare-dns.com/dns-query

![image](https://github.com/user-attachments/assets/a030b9da-7d78-44a4-b54d-ac86e64ab740)


</details>
