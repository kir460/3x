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
    
# Обновление
    x-ui
    2

# Подписка
Включить подписку
Порт подписки 20196
Корневой путь URL-адреса подписки /tv/
Путь к файлу открытого ключа сертификата подписки /root/cert/p.kirnetwiz.top/fullchain.pem
Путь к файлу закрытого ключа сертификата подписки /root/cert/p.kirnetwiz.top/privkey.pem
Интервалы обновления подписки 1

# Port hopping

1 Открыть диапозон адресов

    sudo ufw allow 30000:30100/tcp
    sudo ufw allow 30000:30100/udp

2 Проверить что xRay работает на порту 443

3 Настройка Port Hopping через iptables. 

    sudo iptables -t nat -A PREROUTING -p tcp --dport
    30000:30100 -j REDIRECT --to-port 443
    sudo iptables -t nat -A PREROUTING -p udp --dport
    30000:30100 -j REDIRECT --to-port 443

</details>
