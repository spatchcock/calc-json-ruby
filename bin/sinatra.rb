require 'sinatra'
require './lib/calc_json.rb'

# Request:
# http://localhost:4567/models/settling_velocity?particle_density=2600.0&fluid_density=999.7&radius=0.001&viscosity=1.307
# http://localhost:4567/models/gravitational_force?planetary_body=Pluto&mass=10

get '/models/:model' do
  schema_path = 'examples/' + params[:model]
  
  inputs = params.select{ |k,v| !["splat", "captures"].include?(k) && !params["captures"].include?(v)}
  puts inputs.inspect
  
  model       = CalcJSON::Model.load_from_schema(schema_path)
  calculation = model.calculation(inputs)

  results = calculation.outputs.map do |result|
    [result.definition.label, "#{result.value} #{result.unit.symbol}"]
  end

  Hash[results].to_json
  
end








