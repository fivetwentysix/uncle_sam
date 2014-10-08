require './lib/uncle_sam/federal_tax_calculator'

describe UncleSam::FederalTaxCalculator do
  describe '#rate' do
    xit 'returns a percentage as a float' do
      calculator = UncleSam::FederalTaxCalculator.new(:single, 36250.00)
      expect(calculator.rate).to eq(0.15)
      calculator.taxable_income = 146400.01
      calculator.filing_status = :married_filing_jointly
      expect(calculator.rate).to eq(0.28)
      calculator.taxable_income = 100000000.0
      expect(calculator.rate).to eq(0.396)
    end
  end

  describe '#amount' do
    it 'iterates through each bracket summing the total payable federal tax' do
      calculator = UncleSam::FederalTaxCalculator.new(:single, 30000)
      expect(calculator.amount).to eq(4053.75)
    end
  end
end
