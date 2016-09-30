# gearboxscott-anacron

# Description:

This module will help create anacron entries to schedule programs, scripts, etc. on Linux systems that support anacron.

# Using Anacron on Servers

Anacron was originally put in place for workstations and servers that were not constantly powered on.  Anacron on servers that are powered on permanently can be a powerful scheduling resource.  It can reduce the number crontab entries and makes it easier to find scheduled programs and script because schedule is file based not entry based.  

# About gearboxscott-anacron 

gearboxscott-anacron will manage anacron.  It will manage entries in: 

* /etc/cron.d 

or files in directories:

* /etc/cron.hourly
* /etc/cron.daily
* /etc/cron.weekly 
* /etc/cron.yearly


gearboxscott-anacron supports smart-parameters for Foreman and hiera.


##Usage:

Include the system module in your puppet configuration (non-foreman):

	include anacron
	
and add hiera configuration. In foreman's add the anacron to the puppet repostory, publish and in the puppet section, go to anacron and edit the smart parameters.  The variable type will be hash or yaml to be like hiera.


## jobs

jobs is the only class that uses a template to create the /etc/cron.d/somefile.

Values:

* 	ensure: present or absent (default: present)
* 	user: username (default: root)
* 	date: day of the month, 1-31 (default: '*')
* 	month: month of the year, 1-12 or names (default: '*')
* 	weekday: day number of the week, 0-7 or names (0 or 7 is Sunday, or use names) (default: '*')
* 	hour: 0-23 (default: '*')
* 	minute: 0-59 (default: '*')

## /var/lib/puppet/templates/job.erb content:

```ruby
###########################################################################################
### This file is managed by puppet, and is refreshed regularly. Edit at your own peril! ###
###########################################################################################
## <%= @name %> Cron Job
#
# Environment Settings
<% Array(@environment).join("\n").split(%r{\n}).each do |env_var|
if env_var.match(%r{\S+=\S+}) -%>
<%= env_var %>
<%   elsif env_var.match(%r{\S}) -%>
## Possible input error: <%= env_var %>
<%   end
end -%>

# Job Definition
<%= @minute %> <%= @hour %> <%= @date %> <%= @month %> <%= @weekday %>  <%= @user %>  <%= @command %>
```
	
Example 1 - rsync's the templates to another puppet master every 30 minutes.  A file named rsync_templates will be created in /etc/cron.d/ and will have the following contents:

	*/30 * * * * foreman rsync -av -e ssh /var/lib/puppet/templates root@somepuppetmaster
	
The master template is called job.erb found in the /etc/puppet/environment/your_environment/modules/ana, copy the template into /var/lib/pupppet/templates.  The templates directory might need to be created with mkdir /var/lib/puppet/templates.
	
Here is the hash:

	rsync_templates:
	  ensure: present
	  command: foreman rsync -av -e ssh $SRC $DEST
	  user: root
	  minute: '*/30'
	  environment:
	  - MAILTO=root
	  - PATH="/usr/bin:bin"
	  - DEST="root@somepuppetmaster"
	  - SRC="/var/lib/puppet/templates"
	  
## hourly, daily, weekly, monthly

hourly, daily, weekly, or monthly will create a file from template or link in /etc/cron.d/hourly, /etc/cron.d/daily, /etc/cron.weekly or /etc/cron.monthly respectively.

All the modules act the same way.

Values:

* ensure: absent or present
* type: can be either link or template.
* script: name of file to link or template file to use to create a file.

Example 1: Using anacron::daily module or dailies:

	capture_daily_metrics:
	  ensure: present
	  type: link
	  script: /usr/local/sbin/capture_daily_metrics
	  
Example 2:

	tmpwatch:
	  ensure: present
	  type: template
	  script: /var/lib/puppet/templates/cron.daily/tmpwatch.erb
	  
The template /var/lib/puppet/templates/cron.daily/tmpwatch.erb:

	for d in /var/var/{cache/man,catman}/{cat?,X11R6/cat?,local/cat?}
	do
	  if [ -d "$d" ]
	  then
	     /usr/sbin/tmpwatch "$flags" -f 30d "$d"
	  fi
	done
	
## Notes

* Do not specify resources that are managed by other Puppet modules otherwise
  you will get conflict errors.

* As with many default types you can often specify a 'target' parameter to
  specify a different configuration filename or value to change.

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/gearboxscott/gearboxscott-anacron
