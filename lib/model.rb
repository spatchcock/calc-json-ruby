module CalcJSON

	class Model

  	def self.load_from_schema(name)
      Schema.load(name)
  	end

    attr_accessor :name
    attr_accessor :label
    attr_accessor :definitions
    attr_accessor :filter
    attr_accessor :data
    attr_accessor :algorithm

    def initialize(json,js = nil)
      @name        = json['name']
      @label       = @name.downcase.gsub(" ","_") 
      @definitions = json['definitions'].map { |d| Definition.new(d) }
      @filter      = json['filter']
      @data        = json['data']
      @algorithm   = Algorithm.new(js || json['algorithm'], @definitions)
    end

    def calculation(options)
    	values = @algorithm.call(options)
    	Calculation.new(self,values)
    end
    
  end

end