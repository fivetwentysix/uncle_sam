require 'uncle_sam'

describe UncleSam::Commands::Calculate do
  let(:amount) { 120000.0 }
  let(:filing_status) { :single }
  let(:command) { UncleSam::Commands::Calculate.new(amount, filing_status) }

  describe '#execute' do
    it 'performs tax calculations and prints a message' do
      example_calculations = 'example'
      expect(command).to receive(:calculate) { example_calculations }
      expect(command).to receive(:print_statement).with(example_calculations)
      command.execute
    end
  end

  describe '#calculate' do
    let(:federal_tax_calculator) { double(UncleSam::FederalTaxCalculator, amount: 100) }

    it 'returns the federal tax amount' do
      expect(UncleSam::FederalTaxCalculator).to receive(:new).with(filing_status, amount) do
        federal_tax_calculator
      end
      results = command.calculate
      expect(results[:federal_tax]).to eq(100)
    end
  end

  describe '#print_statement' do
    it 'should print the net income' do
      results = command.calculate
      expect(command).to receive(:print).with(:statement, amount)
      command.print_statement(results)
    end
  end
end
