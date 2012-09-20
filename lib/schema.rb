require 'csv'

module CalcJSON

  class Schema

    def self.load(name)
      raise unless File.exists?("#{name}.json")

      json = JSON.parse(File.read("#{name}.json"))
      js   = File.read("#{name}.js") rescue json['algorithm']
      data = CSV.read("#{name}.csv", :headers => true).map{|x| {'values' => x.to_hash}} rescue json['data']

      Model.new(json,js,data)
    end

  end

end




