# Main function to spawn target number of axes
# Will attempt up to max_spawn_attempts (computed from axes_count * 10)

# Check if we've spawned enough axes
execute if score axes_spawned axe_counter >= axes_target axe_counter run return 1

# Check if we've exceeded max attempts
execute if score spawn_attempts axe_counter >= max_spawn_attempts axe_counter run say Failed to spawn all axes - not enough valid locations
execute if score spawn_attempts axe_counter >= max_spawn_attempts axe_counter run return 0

# Try to spawn an axe
scoreboard players add spawn_attempts axe_counter 1
function trackbreak:spawn_axes/try_spawn

# Recursively call until target reached
function trackbreak:spawn_axes/spawn_axes_main