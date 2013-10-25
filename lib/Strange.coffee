# Strange.coffee
#
# © 2013 David Goehrig <dave@dloh.org>
#

syslog = require 'node-syslog'
spawn = require('child_process').spawn

args = process.argv
args.splice(1,1)
cmd = args.shift()
console.log "#{cmd} -- #{args}"

syslog.init "#{cmd}", syslog.LOG_CONS | syslog.LOG_PID | syslog.LOG_ODELAY, syslog.LOG_LOCAL0
uptime = (seconds) ->
	"#{ Math.floor(seconds / (24*3600)) }d #{ Math.floor(seconds / 3600)}h #{ Math.floor(seconds / 60) }m #{ Math.floor(seconds % 60)  }s"

StrangeAeons = () ->
	child = spawn(cmd,args, stdio: [ null, null, null ] )
	start = new Date()
	syslog.log syslog.LOG_ERR, "start #{start} pid #{child.pid}"
	child.on 'exit', ( code ) ->
		stop = new Date()
		delta = (stop.getTime() - start.getTime())/1000
		syslog.log syslog.LOG_ERR, "stop #{stop} uptime #{uptime(delta)} code #{code}"
		StrangeAeons()
	child.on 'error', ( code ) ->
		stop = new Date()
		syslog.log syslog.LOG_ERR, "stop #{stop} uptime #{uptime(delta)} code #{code}"
		StrangeAeons()

module.exports = StrangeAeons
