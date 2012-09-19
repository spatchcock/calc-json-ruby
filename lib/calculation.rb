module CalcJSON

  class Calculation

    def initialize(model,options)
      @model = model
      options.each do |key,value|
      	definition = @model.definitions.find {|definition| definition.label == key.to_s}
        self.instance_variable_set("@#{key.to_s}".to_sym, Value.new(value,definition))
      end
    end

    def outputs
      @model.definitions.select{|definition| definition.role == 'output'}.map{|definition| self.send(definition.label.to_sym)}
    end

    def method_missing(method,*args,&block)
    	if self.instance_variables.include?("@#{method.to_s}".to_sym)
    		self.instance_variable_get("@#{method.to_s}".to_sym)
    	else
    		super
    	end      
    end
    
  end
end