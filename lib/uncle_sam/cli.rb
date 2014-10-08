require 'yaml'
require 'uncle_sam/commands'

module UncleSam
  class CLI
    def self.run(*args)
      UncleSam::Commands::Usage.new.execute
    end
  end
end
