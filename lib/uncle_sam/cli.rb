require 'yaml'

module UncleSam
  class CLI
    def self.run(*args)
      print(:usage)
    end

    def self.print(key)
      puts message(key)
    end
    
    def self.message(key)
      messages[key]
    end

    private

    def self.messages
      @messages ||= YAML.load(raw_messages_data)
    end

    def self.raw_messages_data
      File.open('./messages.yml').read
    end
  end
end
