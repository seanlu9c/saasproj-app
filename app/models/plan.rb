class Plan
  ## this is not sub-class from ACTIVE RECORD base 
  ## >> not intend as a  table
  
  PLANS = [:free, :premium]
  ## CONSTANT is all in CAP
  
  def self.options
    PLANS.map { |plan| [plan.capitalize, plan] }
    ## map to modi all element in array; 
    ## HERE is just capitalize it
  end
  
end
