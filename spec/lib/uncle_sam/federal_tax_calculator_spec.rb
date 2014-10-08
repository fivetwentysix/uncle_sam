require 'uncle_sam/federal_tax_calculator'

describe UncleSam::FederalTaxCalculator do
  describe '#amount' do
    it 'iterates through each bracket summing the total payable federal tax' do
      calculator = UncleSam::FederalTaxCalculator.new(:single, 30000)
      expect(calculator.amount).to eq(4053.75)
      calculator = UncleSam::FederalTaxCalculator.new(:head_of_household, 12750)
      expect(calculator.amount).to eq(1275.00)
      calculator = UncleSam::FederalTaxCalculator.new(:head_of_household, 4000)
      expect(calculator.amount).to eq(400.00)
    end
  end
end
