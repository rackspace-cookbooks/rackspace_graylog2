default['rackspace_graylog2']['web_version']        = '0.20.1'
default['rackspace_graylog2']['web_home']           = '/opt/graylog2-web-interface'
default['rackspace_graylog2']['web_user']           = 'graylog2-web'
default['rackspace_graylog2']['web_service_name']   = 'graylog2-web-interface'
default['rackspace_graylog2']['web_group']          = 'graylog2'
default['rackspace_graylog2']['web_context']        = '/' # NOTE: should start and end with a / Only root currently supported, see: https://github.com/Graylog2/graylog2-web-interface/issues/588
default['rackspace_graylog2']['web_mem']            = 256
default['rackspace_graylog2']['web_tz']             = 'Europe/Amsterdam'
