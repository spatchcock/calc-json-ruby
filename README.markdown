## calcJSON-ruby

Parse and execute calcJSON data in Ruby.

Licensed under the BSD 3-Clause license (See LICENSE.txt for details)

Author: Andrew Berkeley

Copyright: Copyright (c) 2012 Andrew Berkeley

## Example

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