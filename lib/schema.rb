module CalcJSON

  class Schema

    def self.load(name)
      raise unless File.exists?("#{name}.json")

      json = JSON.parse(File.read("#{name}.json"))
      js   = File.read("#{name}.js") rescue json['algorithm']

      Model.new(json,js)
    end

  end

end




