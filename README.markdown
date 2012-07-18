## calcJSON-ruby

Parse and execute calcJSON data in Ruby.

Licensed under the BSD 3-Clause license (See LICENSE.txt for details)

Author: Andrew Berkeley

Copyright: Copyright (c) 2012 Andrew Berkeley

## Example

```ruby

	require './lib/calc_json.rb'

	schema_path = "data/settling_velocity"

	options     = { 
	  'particle_density' => 2600.0, 
	  'fluid_density' => 999.7, 
	  'acceleration' => 9.8, 
	  'radius' => 0.001, 
	  'viscosity' => 1.307 
	}

	model       = CalcJSON::Model.load_from_schema(schema_path)
	calculation = model.calculation(options)
	result      = calculation.velocity

	puts "settling velocity = #{result.value} #{result.unit.symbol}"
```