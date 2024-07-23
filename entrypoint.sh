#!/bin/bash

# Fetch the application dependencies and compile them
mix deps.get

#compile dependencies
mix deps.compile

# Compile the project
mix compile

# Start the Phoenix server
exec mix phx.server
