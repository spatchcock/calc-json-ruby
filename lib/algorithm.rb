module CalcJSON

	class Algorithm

    attr_reader :raw_js, :definitions

    def initialize(js, definitions, contexts)
    	@raw_js      = js
    	@definitions = definitions
      @contexts    = contexts
    end

    def wrapped_js(options)
      js = "calculation = function() {"
      

      inputs = @definitions.select{|x| x.role == 'parameter' || x.role == 'variable'}
      outputs = @definitions.select{|x| x.role == 'output'}
      context_options = @definitions.select{|x| x.role == 'context'}

      (inputs+context_options).each do |d| 
        js += "\n   var #{d.label} = #{d.default || 'null'};"
      end
      
      if @contexts
        context = @contexts.find do |context|
          context_options.all? do |option|
            options[option.label] == context['values'][option.label] rescue false
          end
        end
        if context
          context['values'].each do |k,v|
            definition = @definitions.find {|d| d.label == k }
            if definition
              js += "\n   #{k} = #{encode_input(v, definition.type)};"
            end
          end
        end
      end

      inputs.each do |input|
        if options[input.label]
          type = @definitions.find {|d| d.label == input.label }.type 
          js += "\n   #{input.label} = #{encode_input(options[input.label],type)};"
        end
      end

      js += "\n   #{@raw_js}"
      js += "\n   return {"
    
      outputs.each do |d| 
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