# require 'bundler/setup'
require 'pathname'
require 'yaml'
require 'json_spec/cucumber'
require 'jsonpath'


def find_config_file(filename)
  root = Pathname.pwd
  while not root.root?
    root.find do |path|
      if path.file? and path.basename.to_s == filename
        return path.to_s
      end
    end
    root = root.parent
  end
  raise 'Configuration file ' #{filename}' not found!'
end


def load_config_file(filename)
  config_file = find_config_file filename
  config = YAML.load_file(config_file)
  # $app_context = config['app']['rootPath']
  return config
end

AfterConfiguration do |config|
  # read config file
  configuration = load_config_file('config.yml')
  # Load application configuration parameters
  $app_user = configuration['app']['user']
  $app_password = configuration['app']['password']
  $app_host = configuration['app']['host']
  # $app_port = configuration['app']['port']
  $app_root = configuration['app']['rootPath']
end
