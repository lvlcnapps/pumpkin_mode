# Attempt to spawn axe at mirror_left
tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"Trying to spawn axe at mirror_left...","color":"white"}]
execute if score mirror_left axe_available matches 1 run summon minecraft:interaction -7031 85 7970 {Tags:["get_axe"]}
execute if score mirror_left axe_available matches 1 run summon item_display -7031 85.5 7970 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score mirror_left axe_available matches 1 run summon minecraft:text_display -7031 86 7970 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score mirror_left axe_available matches 1 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✓ Successfully spawned axe at mirror_left ","color":"green"},{"text":"(-7031, 85, 7970)","color":"aqua"}]
execute if score mirror_left axe_available matches 0 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✗ Location mirror_left unavailable","color":"red"}]
execute if score mirror_left axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score mirror_left axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_mirror_left