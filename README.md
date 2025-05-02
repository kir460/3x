#Безопасность

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


# Заменить порт

Port 22102

    sudo ufw allow 22102/tcp

# Закрыть порт

    sudo ufw deny 22/tcp

# (Найдите строку "PermitRootLogin yes" и замените её на "PermitRootLogin no"), (При необходимости измените "PasswordAuthentication yes" на "PasswordAuthentication no")

# Перезапуск службы SSH для применения изменений
    systemctl restart ssh

# Установка UFW
    sudo apt update
    sudo apt install ufw
    sudo ufw allow ssh
    sudo ufw allow <ваш_порт>/tcp

sudo nano /etc/ufw/before.rules

# Блокировка ICMP-запросов для предотвращения двустороннего пинга
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

# Проверить статус UFW
    sudo ufw status verbose

#  Вход под root:
    su root(с паролем root), sudo -i (с парлем user)












# Скачиваем скрипт
    wget https://raw.githubusercontent.com/kir460/3x/main/ui.sh

# Предоставление прав на выполнение скрипта
    chmod +x ui.sh

# Запуск скрипта от имени суперпользователя
    sudo ./ui.sh
