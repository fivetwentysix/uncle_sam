require 'yaml'

module UncleSam
  module Commands
    class Command
      def print(key)
        puts fetch_message(key)
      end

      def fetch_message(key)
        messages[key]
      end
      
      private

      def messages
        @messages ||= YAML.load(raw_messages_data)
      end

      def raw_messages_data
        File.open(File.dirname(__FILE__) + '/../../../messages.yml').read
      end
    end
  end
end
