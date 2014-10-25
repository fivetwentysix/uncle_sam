require 'uncle_sam/taxable_income_calculator'

describe UncleSam::TaxableIncomeCalculator do
  let(:average_net_income) { 51939.00 }
  let(:calculator) { UncleSam::TaxableIncomeCalculator.new(average_net_income) }

  describe '#make_standard_deductions(filing_status)' do
    it 'deducts the matching amount from the net income' do
      calculator.make_standard_deductions(:single)
      expect(calculator.taxable_income).to eq(average_net_income - UncleSam::FILING_STATUS_STANDARD_DEDUCTION_AMOUNTS[:single])
    end

    it 'rejects unknown filing status values' do
      expect do
        calculator.make_standard_deductions(:invalid_value)
      end.to raise_error(UncleSam::UnknownFilingStatusError)
    end
  end

  describe '#make_other_standard_deductions(blind, senior, dependent)' do
    context 'when the taxpayer is single' do
      it 'makes a deduction for every case that is true' do
        calculator.make_other_standard_deductions # defaults should be false
        calculator.make_other_standard_deductions(true, true, true)
        calculator.make_other_standard_deductions(false, true, false)

        expected_result = average_net_income - UncleSam::OTHER_STANDARD_DEDUCTION_AMOUNT[:single] * 4
        expect(calculator.taxable_income).to eq(expected_result)
      end
    end

    context 'when the taxpayer is filing jointly' do
      it 'makes a deduction for every case that is true' do
        allow(calculator).to receive(:filing_status) { :married_filing_jointly }
        calculator.make_other_standard_deductions # defaults should be false
        calculator.make_other_standard_deductions(true, true, true)
        calculator.make_other_standard_deductions(false, true, false)

        expected_result = average_net_income - UncleSam::OTHER_STANDARD_DEDUCTION_AMOUNT[:married_filing_jointly] * 4
        expect(calculator.taxable_income).to eq(expected_result)
      end
    end
  end

  describe '#make_personal_tax_exemptions' do
    before { calculator.filing_status = :single }
    it 'deducts the personal exemption amount from the taxable income' do
      calculator.make_personal_tax_exemptions
      expect(calculator.taxable_income).to eq(average_net_income - UncleSam::PERSONAL_EXEMPTION_AMOUNT)
    end

    it 'phases out by %2 for each threshold amount if your AGI is above a certain amount' do
      calculator.taxable_income = 255500.0
      calculator.make_personal_tax_exemptions
      exemption = UncleSam::PERSONAL_EXEMPTION_AMOUNT * 
        UncleSam::PERSONAL_EXEMPTION_PHASE_MODIFIER *
        UncleSam::PERSONAL_EXEMPTION_PHASE_MODIFIER
      expect(calculator.taxable_income).to eq(255500.0 - exemption)
    end
  end
end
