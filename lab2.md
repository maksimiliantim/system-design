
Задание второй лабораторной работы:
1. Создайте сервис на Python который реализует сервисы, спроектированные в первом задании (по проектированию). Должно быть реализовано как минимум два сервиса (управления пользователем, и хотя бы один «бизнес» сервис)
2. Сервис должен поддерживать аутентификацию с использованием JWT-token
3. Сервис должен реализовывать как минимум GET/POST методы
4. Данные сервиса должны храниться в памяти
5. В целях проверки должен быть заведён мастер-пользователь (имя admin, пароль secret)



Возникли трудности с редактирвоанием/удалением записей и просмотром всех пользователей:
<!doctype html>
<html lang=en>
<title>404 Not Found</title>
<h1>Not Found</h1>
<p>The requested URL was not found on the server. If you entered the URL manually please check your spelling and try
    again.</p>

Много чего перепробовал, но почему-то не читает id записи, хотя создать новые могу, и новые id нормально присваиваются. Методы http использовал корректно. Возможно ошибка в самом main.py, хотя в консоле ничего нет(делал через replit.com):
 * Serving Flask app 'main'
 * Debug mode: on
INFO:werkzeug:WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://127.0.0.1:8080
INFO:werkzeug:Press CTRL+C to quit
INFO:werkzeug: * Restarting with stat
WARNING:werkzeug: * Debugger is active!
INFO:werkzeug: * Debugger PIN: 115-979-896

Либо проблема в Postman. Буду благодарен, если поможете с решением, заранее спасибо!
