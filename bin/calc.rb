require './lib/calc_json.rb'

# Run like:
# ruby bin/calc.rb examples/settling_velocity particle_density=2600.0 fluid_density=999.7 radius=0.001 viscosity=1.307
# ruby bin/calc.rb examples/gravitational_force planetary_body=Pluto mass=10

schema_path = ARGV[0];

inputs = Hash[ARGV.slice(1..-1).map{|x| x.split('=') }]

model       = CalcJSON::Model.load_from_schema(schema_path)
calculation = model.calculation(inputs)

calculation.outputs.each do |result|
  puts "#{result.definition.name} = #{result.value} #{result.unit.symbol}"
end



