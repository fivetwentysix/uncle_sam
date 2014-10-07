require './lib/uncle_sam/federal_tax_calculator'

describe UncleSam::FederalTaxCalculator do
  describe '#rate' do
    it 'returns a percentage as a float' do
      definer = UncleSam::FederalTaxCalculator.new(:single, 36250.00)
      expect(definer.rate).to eq(0.15)
      definer.taxable_income = 146400.01
      definer.filing_status = :married_filing_jointly
      expect(definer.rate).to eq(0.28)
      definer.taxable_income = 100000000.0
      expect(definer.rate).to eq(0.396)
    end
  end

  describe '#federal_tax' do
    it 'iterates through each bracket summing the total payable federal tax'
  end
end
