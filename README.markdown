## calcJSON-ruby

Parse and execute calcJSON data in Ruby.

Authors: Andrew Berkeley, James Smith (Floppy)

## Examples

Calculate the settling velocity of a particle in water based on the schema at examples/settling_velocity.json

```ruby

require './lib/calc_json.rb'

schema_path = "examples/settling_velocity"

options     = { 
  'particle_density' => 2600.0,            # typical density of sand
  'fluid_density' => 999.7,                # density of water
  'acceleration' => 9.8,                   # acceleration due to gravity
  'radius' => 0.001, 
  'viscosity' => 1.307                     # dynamic viscosity of water at 10C
}

model       = CalcJSON::Model.load_from_schema(schema_path)
calculation = model.calculation(options)
result      = calculation.velocity

puts "settling velocity = #{result.value} #{result.unit.symbol}"

```

Calculate the gravitational force on Earth based on the schema at examples/gravitational_force.json

```ruby

require './lib/calc_json.rb'

schema_path = "examples/gravitational_force"

options     = { 
  'mass' => 85,                            # some mass quantity
  'acceleration' => 9.8                    # acceleration due to gravity
}

model       = CalcJSON::Model.load_from_schema(schema_path)
calculation = model.calculation(options)
result      = calculation.force

puts "force = #{result.value} #{result.unit.symbol}"

```

## To do
* Browsing, filtering and retrieving data
* Using dataset entries in calculations
* Specifying units in calculations
* Support for dataset/model metadata 

## License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program (see the COPYING file).  If not, see
<http://www.gnu.org/licenses/>.
