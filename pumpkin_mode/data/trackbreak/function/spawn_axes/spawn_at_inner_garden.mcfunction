# Attempt to spawn axe at inner_garden
tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"Trying to spawn axe at inner_garden...","color":"white"}]
execute if score inner_garden axe_available matches 1 run summon minecraft:interaction -7045 78 7969 {Tags:["get_axe"]}
execute if score inner_garden axe_available matches 1 run summon item_display -7045 78.5 7969 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score inner_garden axe_available matches 1 run summon minecraft:text_display -7045 79 7969 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score inner_garden axe_available matches 1 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✓ Successfully spawned axe at inner_garden ","color":"green"},{"text":"(-7045, 78, 7969)","color":"aqua"}]
execute if score inner_garden axe_available matches 0 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✗ Location inner_garden unavailable","color":"red"}]
execute if score inner_garden axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score inner_garden axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_inner_garden