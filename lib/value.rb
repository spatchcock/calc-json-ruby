module CalcJSON

  class Value

  	attr_reader :value, :unit, :definition
    
    def initialize(value,definition)
    	@value      = value
    	@definition = definition
    	@unit       = Quantify::Unit.for(definition.unit)
    end

    def method_missing(method,*args,&block)
    	if @definition.respond_to?(method)
    		@definition.call(method)
    	else
    		super
    	end      
    end

  end
end