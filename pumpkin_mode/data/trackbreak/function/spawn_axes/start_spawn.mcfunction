# Start spawning axes using scoreboard value axes_count in pumpkin_counter
scoreboard players operation axes_target axe_counter = axes_count pumpkin_counter
scoreboard players operation max_spawn_attempts axe_counter = axes_target axe_counter
scoreboard players operation max_spawn_attempts axe_counter *= #10 constants
scoreboard players set spawn_retries axe_counter 0
# Initialize availability and counters for first attempt
function trackbreak:spawn_axes/init_axe_spawns
scoreboard players set spawn_attempts axe_counter 0
function trackbreak:spawn_axes/spawn_axes_main

# Retry if first attempt did not reach target
function trackbreak:spawn_axes/retry_spawn
tellraw @a [{"text":"Spawned axes: ","extra":[{"score":{"name":"axes_spawned","objective":"axe_counter"}}]},{"text":" (retries: ","color":"gray"},{"score":{"name":"spawn_retries","objective":"axe_counter"},"color":"gray"},{"text":")","color":"gray"}]