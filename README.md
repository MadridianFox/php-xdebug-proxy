# Xdebug Proxy #

Прокси сервер для могопользовательской разработки на dev-сервере, 
который находится за NAT'ом.

## Принцип работы ##

Стандартный DBGp прокси делает одну простую вещь - в зависимости от idekey, который передан при отладке
передаёт отладочные данные на тот ip с которого этот idekey был зарегистрирован.

Это работает, когда вы можете разместить прокси в одной сети с машинами разработчиков.

**Этот** прокси немного изменён. Он позволяет регистрировать ключи вида `idekey:port`.
Указанный таким образом порт прокси запомнит, и будет слать отладочные данные на него. Это маленькое изменение
позволяет разработчикам прокидывать разные порты через ssh на машину с прокси, а прокси сможет 
посылать им отладочные данные в эти порты.

## Отладка ##

Чтобы работала отладка, необходимо настроить сервер, настроить машину разработчика и перед отладкой регистрировать свой idekey.

### Настройка сервера ###

Настраиваем php так, чтобы он слал отладочные данные на localhost:9000.  
Ставим и запускаем DBGp прокси так, чтобы он слушал 9000 порт.  

### Настройка машины разработчика ###

Настраиваем ssh соединение, чтобы пробрасывались порты. Важно выбрать себе уникальный порт. Например 9010.
Пример настройки соединения через `~/.ssh/config`:
   
   ```
   Host my-site.dev
   	HostName 11.22.33.44
   	Port 22
   	User developer
   	LocalForward 9001 127.0.0.1:9001
   	RemoteForward 9010 127.0.0.1:9010
   ```
Здесь порт 9001 проброшен для того чтобы зарегистрировать свой idekey, а на порт 9010 прокси будет слать отладочные данные.

Настраиваем IDE, чтобы для отладки слушала выбранный ранее порт.

### Регистрация idekey ###
 
Перед началом отладки регистрируем свой idekey. 
Для регистрации ипользуем `host = localhost` и `port = 9001`.
В самом idekey указываем свой порт. Например `idekey = madridianfox:9010`

### Отладка ###

Как обычно, чтобы запустить отладку надо передать параметр `XDEBUG_SESSION_START=idekey`. **Важно**, idekey тут указывается без порта.

## Установка ##

Клонируем репозиторий в любую папку, выполняем install.sh.

```bash
cd /path/to/proxy

git clone git@github.com:MadridianFox/php-xdebug-proxy.git ./

./install.sh

systemctl enable dbgp
```

Управлять прокси можно как обычным systemd сервисом:
```bash
systemctl start dbgp # service dbgp start
systemctl stop dbgp # service dbgp stop
systemctl restart dbgp # service dbgp restart
```

## Настройка ##

Есть всего 3 момента, которые вы можете поменять:

* Пользователя и группу, от имени которых работает прокси
* Порты, на которых прокси слушает xdebug и регистрацию
* Предустановленные порты для заранее определённых idekey

### Смена пользователя ###

По умолчанию прокси запускается от пользователя www-data.

Чтобы это изменить, надо отредактировать файлы

* ./install.sh
* ./bin/dbgp.service.template

Выполняем `install.sh`. Если до этого установка уже была выполнена, то надо перезагрузить
`systemctl`:
```bash
systemctl daemon-reload
```

### Смена портов и предустановленных idekey ###

По умолчанию прокси слушает xdebug на 9000 порту 
и регистрацию от пользователей не 9001 порту. Изменить это можно в файле `./config/config.php`.

Кроме того, если состав команды разработки стабилен, то можно заранее задать порты, 
на которые прокси будет отправлять отладочные данные.
делается это в том же файле `./config/config.php` в секции `predefinedIdeList`.