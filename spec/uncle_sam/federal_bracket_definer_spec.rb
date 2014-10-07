require './lib/uncle_sam/federal_bracket_definer'

describe UncleSam::FederalBracketDefiner do
  describe '#rate' do
    it 'returns a percentage as a float' do
      definer = UncleSam::FederalBracketDefiner.new(:single, 36250.00)
      expect(definer.rate).to eq(0.15)
      definer.taxable_income = 146400.01
      definer.filing_status = :married_filing_jointly
      expect(definer.rate).to eq(0.28)
      definer.taxable_income = 100000000.0
      expect(definer.rate).to eq(0.396)
    end
  end
end
