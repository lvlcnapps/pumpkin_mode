# Main function to spawn 5 axes
# Will attempt up to 50 times

# Check if we've spawned enough axes
execute if score axes_spawned axe_counter matches 5.. run return 1

# Check if we've exceeded max attempts
execute if score spawn_attempts axe_counter matches 50.. run say Failed to spawn all axes - not enough valid locations
execute if score spawn_attempts axe_counter matches 50.. run return 0

# Try to spawn an axe
scoreboard players add spawn_attempts axe_counter 1
function trackbreak:spawn_axes/try_spawn

# Recursively call until target reached
function trackbreak:spawn_axes/spawn_axes_main