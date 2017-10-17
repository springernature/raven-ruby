require 'raven'
require 'rails'

module Raven
  class Railtie < ::Rails::Railtie
    initializer "raven.use_rack_middleware" do |app|
      app.config.middleware.insert 0, "Raven::Rack"
    end

    config.after_initialize do
      puts " -raven- config.after_initialize"
      Raven.configure(true) do |config|
        config.logger ||= ::Rails.logger
        config.project_root ||= ::Rails.root
        puts " -raven- config: #{config}"
      end

      Raven::Rails.initialize

      if defined?(::ActionDispatch::DebugExceptions)
        puts " -raven- DebugExceptions requiring debug_exceptions_catcher middleware"
        require 'raven/rails/middleware/debug_exceptions_catcher'
        ::ActionDispatch::DebugExceptions.send(:include, Raven::Rails::Middleware::DebugExceptionsCatcher)
      elsif defined?(::ActionDispatch::ShowExceptions)
        puts " -raven- ShowExceptions requiring debug_exceptions_catcher middleware"
        require 'raven/rails/middleware/debug_exceptions_catcher'
        ::ActionDispatch::ShowExceptions.send(:include, Raven::Rails::Middleware::DebugExceptionsCatcher)
      end
    end
  end
end
