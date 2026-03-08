# Start spawning 5 axes
function trackbreak:spawn_axes/init_axe_spawns
scoreboard players set spawn_attempts axe_counter 0
tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"Starting axe spawn process...","color":"yellow"}]
function trackbreak:spawn_axes/spawn_axes_main
tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"Spawned ","color":"yellow"},{"score":{"name":"axes_spawned","objective":"axe_counter"},"color":"green"},{"text":" axes in ","color":"yellow"},{"score":{"name":"spawn_attempts","objective":"axe_counter"},"color":"aqua"},{"text":" attempts","color":"yellow"}]