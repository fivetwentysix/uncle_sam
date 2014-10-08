module UncleSam
  LARGE_NUMBER = 1000.0 ** 1000.0

  # Source: http://en.wikipedia.org/wiki/Income_tax_in_the_United_States
  FEDERAL_TAX_BRACKETS = {
    :single                      => {
      0.100 => 0.00..8925.00,
      0.150 => 8925.01..36250.00,
      0.250 => 36250.01..87850.00,
      0.280 => 87850.01..183250.00,
      0.330 => 183250.01..398350.00,
      0.350 => 398350.01..400000.00,
      0.396 => 400000.01..LARGE_NUMBER
    },
    :married_filing_jointly      => {
      0.100 => 0.0..17850.00,
      0.150 => 17850.01..72500.00,
      0.250 => 72500.01..146400.00,
      0.280 => 146400.01..223050.00,
      0.330 => 223050.01..398350.00,
      0.350 => 398350.01..400000.00,
      0.396 => 400000.01..LARGE_NUMBER
    },
    :married_filing_separately   => {
      0.100 => 0.00..8925.00,
      0.150 => 8925.01..36250.00,
      0.250 => 36250.01..73200.00,
      0.280 => 73201.01..111525.00,
      0.330 => 111525.01..199175.00,
      0.350 => 199175.01..225000.00,
      0.396 => 225000.01..LARGE_NUMBER
    },
    :head_of_household           => {
      0.100 => 0.00..12750.00,
      0.150 => 12750.01..48600.00,
      0.250 => 48600.01..125450.00,
      0.280 => 125450.01..203150.00,
      0.330 => 203150.01..398350.00,
      0.350 => 398350.01..425000.00,
      0.396 => 425000.01..LARGE_NUMBER
    }
  }

  class FederalTaxCalculator
    attr_accessor :filing_status, :taxable_income

    def initialize(filing_status, taxable_income)
      @filing_status, @taxable_income = filing_status, taxable_income
    end
    
    # def rate
    #   FEDERAL_TAX_BRACKETS[filing_status].each do |rate, range|
    #     return rate if range.include?(taxable_income)
    #   end
    # end
    
    def amount
      FEDERAL_TAX_BRACKETS[filing_status].map do |rate, bracket|
        amount_for_bracket = if @taxable_income >= bracket.max
          @taxable_income -= bracket.max
          bracket.max
        elsif @taxable_income <= 0
          0
        else
          amount = @taxable_income
          @taxable_income = 0
          amount
        end
        rate * amount_for_bracket
      end.inject(:+)
    end
  end
end
