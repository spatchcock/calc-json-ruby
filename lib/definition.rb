module CalcJSON

	class Definition

  	VALID_PROPERTIES = [
	   'name',
	   'type',
	   'label',
	   'description',
	   'unit',
	   'default',
	   'choices',
	   'role',
	   'tags'
	  ]
  
    VALID_PROPERTIES.each do |property|
      attr_accessor property.to_sym
    end

    def initialize(options={})
      options.each do |key,value|
        self.instance_variable_set("@#{key.to_s}".to_sym,value)
      end
    end

  	def is_data?
      role == 'parameter' || is_context?
    end

    def is_context?
      role == 'context'
    end

  end

end