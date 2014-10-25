module UncleSam
  module Commands
    class Calculate < Command
      attr_reader :net_income, :filing_status

      def initialize(net_income, filing_status)
        @net_income, @filing_status = net_income, filing_status
      end

      def execute
        print_statement(calculate)
      end

      def calculate
        { 
          federal_tax: federal_tax
        }
      end

      def print_statement(results)
        print :statement, net_income
      end

      private

      def federal_tax
        UncleSam::FederalTaxCalculator.new(filing_status, net_income).amount
      end
    end
  end
end
