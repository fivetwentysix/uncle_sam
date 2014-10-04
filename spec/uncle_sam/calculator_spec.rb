module UncleSam

  # Source: http://en.wikipedia.org/wiki/Standard_deduction
  FILING_STATUS_OPTIONS = {
    :single                       => 6200.0,
    :married_filing_jointly       => 12400.0,
    :married_filing_separately    => 6200.0,
    :head_of_household            => 9100.0,
    :qualifying_surviving_spouse  => 12400
  }

  UnknownFilingStatusError = Class.new(Exception)

  class Calculator
    attr_reader :remaining_income, :filing_status

    def initialize(net_income, filing_status)
      @remaining_income = net_income
      @filing_status    = filing_status

      raise UnknownFilingStatusError if filing_status_is_invalid?
    end

    def make_standard_deductions
      @remaining_income -= FILING_STATUS_OPTIONS[filing_status]
    end

    private

    def filing_status_is_invalid?
      FILING_STATUS_OPTIONS[filing_status].nil?
    end
  end
end

describe UncleSam::Calculator do
  let(:average_net_income) { 51939.00 }

  describe '#make_standard_deductions' do
    it 'deducts the matching amount from the net income' do
      calculator = UncleSam::Calculator.new(average_net_income, :single)
      calculator.make_standard_deductions
      expect(calculator.remaining_income).to eq(average_net_income - UncleSam::FILING_STATUS_OPTIONS[:single])
    end
  end

  it 'rejects unknown filing status values' do
    expect do
      UncleSam::Calculator.new(average_net_income, :invalid_value)
    end.to raise_error(UncleSam::UnknownFilingStatusError)
  end
end
