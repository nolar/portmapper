                             ОТОБРАЖАТЕЛЬ  ПОРТОВ
                             ====================



                                  Назначение
                                  ----------
Программа  предназначена  для прозрачного отображения некоторых IP-соединений с
одного  хоста  и  порта  на  другие хост и порт с возможностью задержки данных.
Иными    словами,    в    программе   задается   несколько   отображений   вида
LocalHost:LocalPort  -> RemoteHost:RemotePort. Как только кто-то подключается к
порту LocalPort на машине, на которой запущена эта программа, она сразу создает
подключение к машине RemoteHost, порту RemotePort. При этом начинается сквозная
передача  данных  в  обе  стороны.  Однако, любые данные при этом принудительно
задерживаются на указанное количество миллисекунд.

Программу  можно  использовать  как портовый прокси-сервер для сетей, в которых
один  компьютер  имеет  доступ  к  интернет,  и желает предоставлять выборочный
доступ другим компьютерам.

Кроме того, с помощью этой программы можно устранить ошибку программы Microsoft
Outlook  XP(2002)  в реализации клиента POP3. Эта ошибка заключается в том, что
Outlook   иногда  не  успевает  обрабатывать  слишком  быстро  пришедший  ответ
POP3-сервера (например, если Outlook и POP3-сервер находятся на одной машине) и
сообщает  что  "превышено  время  ожидания  отклика  принимающего сервера". Для
исправления   этой   ошибки   необходимо   настроить   отображение,   например,
*:9110->localhost:110,  с  задержкой примерно 100 мс, а также настроить Outlook
на использование порта 9110 вместо 110 для протокола POP3.



                                   Установка
                                   ---------
Запустите   файл   Port  Mapper.msi  и  следуйте  инструкциям.

В   дистрибутиве  предлагается   несколько   языковых   вариантов программы. Их
можно  поставить все, использоваться  все  равно  будет  только  один  из  них.
Переключение  языковых  вариантов   можно  произвести через ярлыки меню "Пуск",
устанавливаемые  вместе  с  соответсвующим   языковым вариантом, либо с помощью



                                  Требования
                                  ----------
Для установки программы требуется MS Installer 2.0.
Microsoft Windows NT/2000/XP и ее аппаратные требования.
Установленный стек протоколов TCP/IP.



                                  Ограничения
                                  -----------
1) Пока существует только отображение TCP-соединений, и нет UDP.



                                   Реквизиты
                                   ---------
Почта		: portmapper@software.numeri.net
Сайт		: http://www.software.numeri.net/portmapper/
Обновления	: http://www.software.numeri.net/portmapper/update/
Поддержка	: http://www.software.numeri.net/portmapper/support/
