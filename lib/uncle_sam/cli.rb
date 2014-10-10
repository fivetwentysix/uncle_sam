require 'uncle_sam/commands'

module UncleSam
  class CLI
    def self.run(args)
      net_income = args[0].to_f
      filing_status = (args[1] || :single).to_sym

      if net_income > 0
        UncleSam::Commands::Calculate.new(net_income, filing_status).execute
      else
        UncleSam::Commands::Usage.new.execute
      end
    end
  end
end
