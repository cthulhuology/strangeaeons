strange aeons
=============

And with strange aeons even death may die...

strange aeons is still yet another watchdog daemon for nodejs.

It tracks uptime and logs to syslog each child process restart.

It is intended to keep an app up and running, resurrecting like superviser but geared towards logging.

Eventually it will be management bus aware, logging all relevant events to an AMQP message stream.


Usage
-----

	aeons ./my/coffeescript/app some-args...


Kill aeons to end the child process...

