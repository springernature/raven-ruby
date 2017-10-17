module Raven
  module Rails
    module ControllerMethods
      def capture_message(message, options = {})
        puts " -raven- capture_message #{message}"
        Raven::Rack.capture_message(message, request.env, options)
      end

      def capture_exception(exception, options = {})
        puts " -raven- capture_exception #{exception}"
        Raven::Rack.capture_exception(exception, request.env, options)
      end
    end
  end
end
