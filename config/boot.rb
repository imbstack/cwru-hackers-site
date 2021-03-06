# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined?(PADRINO_ROOT)
# Load Bundler
require 'rubygems'
require 'bundler'
# Only have default and environment gems
Bundler.setup(:default, PADRINO_ENV.to_sym)
# Only require default and environment gems
Bundler.require(:default, PADRINO_ENV.to_sym)
puts "=> Located #{Padrino.bundle} Gemfile for #{Padrino.env}"
APP_KEYS = YAML.load(File.open "config/keys.yml")

##
# Add your before load hooks here
#
Padrino.before_load do
	Sinatra::Application.public= "#{PADRINO_ROOT}/public"

        ActiveSupport.on_load :active_record do
          require 'carrierwave/orm/activerecord'
        end

	CarrierWave.configure do |config| 
		config.root = "#{Dir.pwd}/public/" 
	end 
end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!
