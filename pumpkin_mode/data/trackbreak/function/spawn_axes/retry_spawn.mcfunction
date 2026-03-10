# Retry full spawn process until target is reached
# Hard limit: 10 retries

# Success condition
execute if score axes_spawned axe_counter >= axes_target axe_counter run return 1

# Stop when retry limit is reached
execute if score spawn_retries axe_counter matches 10.. run say Failed to spawn all axes after 10 retries
execute if score spawn_retries axe_counter matches 10.. run return 0

# Start next retry attempt
scoreboard players add spawn_retries axe_counter 1
function trackbreak:spawn_axes/init_axe_spawns
scoreboard players set spawn_attempts axe_counter 0
function trackbreak:spawn_axes/spawn_axes_main

# Continue retry loop if still not enough axes
function trackbreak:spawn_axes/retry_spawn