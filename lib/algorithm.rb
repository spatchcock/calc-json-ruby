module CalcJSON

	class Algorithm

    attr_reader :raw_js, :definitions

    def initialize(js, definitions)
    	@raw_js      = js
    	@definitions = definitions
    end

    def wrapped_js(options)
      js = "calculation = function() {"

      @definitions.each { |d| js += "\n   var #{d.label};" }

  	  options.each do |key, value|
  	  	type = @definitions.find {|d| d.label == key.to_s }.type 
  	    js += "\n   #{key.to_s} = #{encode_input(value,type)};"
      end

      js += "\n   #{@raw_js}"
      js += "\n   return {"
    
      @definitions.each do |d| 
        js += "\n    \"#{d.label}\" : #{d.label}"
        js += "," unless d == @definitions.last
      end

      js += "\n  }"
      js += "\n}"

      js
    end

    def encode_input(value,type)
    	case type
	  	when 'text'    then "\"#{value}\""
  	  when 'decimal' then "parseFloat(#{value})"
  	  when 'integer' then "parseInt(#{value})"
  	  else
  	    value
  	  end
  	end

    def call(options)
    	js = wrapped_js(options)
    	js_function = ExecJS.compile(js)
    	# second argument possible for providing js function arguments
    	# but all arguments already initialized in #setup
    	js_function.call("calculation") 
    end

  end

end