# Attempt to spawn axe at corridor
tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"Trying to spawn axe at corridor...","color":"white"}]
execute if score corridor axe_available matches 1 run summon minecraft:interaction -7065 82 7976 {Tags:["get_axe"]}
execute if score corridor axe_available matches 1 run summon item_display -7065 82.5 7976 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score corridor axe_available matches 1 run summon minecraft:text_display -7065 83 7976 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score corridor axe_available matches 1 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✓ Successfully spawned axe at corridor ","color":"green"},{"text":"(-7065, 82, 7976)","color":"aqua"}]
execute if score corridor axe_available matches 0 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✗ Location corridor unavailable","color":"red"}]
execute if score corridor axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score corridor axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_corridor