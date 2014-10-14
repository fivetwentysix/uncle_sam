module UncleSam
  # Source: http://en.wikipedia.org/wiki/Standard_deduction
  FILING_STATUS_STANDARD_DEDUCTION_AMOUNTS = {
    :single                      => 6200.0,
    :married_filing_jointly      => 12400.0,
    :married_filing_separately   => 6200.0,
    :head_of_household           => 9100.0,
    :qualifying_surviving_spouse => 12400
  }

  OTHER_STANDARD_DEDUCTION_AMOUNT = {
    :single                      => 1100.0,
    :married_filing_jointly      => 1400.0
  }



  UnknownFilingStatusError = Class.new(Exception)

  # Source: http://www.irs.gov/publications/p17/ch03.html
  PERSONAL_EXEMPTION_AMOUNT = 3900.0
  PERSONAL_EXEMPTION_THRESHOLDS = {
    :single                      => 250000,
    :married_filing_jointly      => 300000,
    :married_filing_separately   => 150000,
    :head_of_household           => 275000,
    :qualifying_surviving_spouse => 300000
  }

  class TaxableIncomeCalculator
    attr_reader :taxable_income, :filing_status

    def initialize(net_income)
      @taxable_income = net_income
    end

    def make_standard_deductions(filing_status)
      @filing_status = filing_status
      raise UnknownFilingStatusError if filing_status_is_invalid?

      @taxable_income -= FILING_STATUS_STANDARD_DEDUCTION_AMOUNTS[filing_status]
    end

    def make_other_standard_deductions(blind = false, senior = false, dependent = false)
      amount = other_standard_deduction_amount
      make_deduction(amount) if blind
      make_deduction(amount) if senior
      make_deduction(amount) if dependent
    end

    def make_personal_tax_exemptions
      make_deduction(UncleSam::PERSONAL_EXEMPTION_AMOUNT)
    end

    private

    def filing_jointly?
      filing_status == :married_filing_jointly
    end

    def filing_status_is_invalid?
      FILING_STATUS_STANDARD_DEDUCTION_AMOUNTS[filing_status].nil?
    end

    def other_standard_deduction_amount
      filing_jointly? ? OTHER_STANDARD_DEDUCTION_AMOUNT[:married_filing_jointly] : OTHER_STANDARD_DEDUCTION_AMOUNT[:single]
    end

    def make_deduction(amount)
      @taxable_income -= amount
    end
  end
end
