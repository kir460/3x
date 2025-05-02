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
    sudo ufw allow 22102/tcp #Открыть порт

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


# Подробнее

<details>
<summary>Показать/скрыть</summary>

# Устоновка SSL
    x-ui
    18
    1
    3.kirnetwiz.top
    80
    
# Обновление
    x-ui
    2

# Подписка
![image](https://github.com/user-attachments/assets/5cbe56b6-9496-47c5-aadf-6c09d034117d)
![image](https://github.com/user-attachments/assets/29a49e4f-dcc9-40b1-b0df-1776d9ca39ee)




</details>
