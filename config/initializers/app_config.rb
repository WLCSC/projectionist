require 'drb'
raw_config = File.read("#{Rails.root}/config/app_config.yml")
APP_CONFIG = YAML.load(raw_config)['proctor'].symbolize_keys
DRb.start_service nil, nil
