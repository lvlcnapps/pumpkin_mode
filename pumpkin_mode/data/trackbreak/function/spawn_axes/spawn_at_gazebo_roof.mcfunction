# Attempt to spawn axe at gazebo_roof
tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"Trying to spawn axe at gazebo_roof...","color":"white"}]
execute if score gazebo_roof axe_available matches 1 run summon minecraft:interaction -7074 86 7989 {Tags:["get_axe"]}
execute if score gazebo_roof axe_available matches 1 run summon item_display -7074 86.5 7989 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score gazebo_roof axe_available matches 1 run summon minecraft:text_display -7074 87 7989 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score gazebo_roof axe_available matches 1 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✓ Successfully spawned axe at gazebo_roof ","color":"green"},{"text":"(-7074, 86, 7989)","color":"aqua"}]
execute if score gazebo_roof axe_available matches 0 run tellraw @a [{"text":"[DEBUG] ","color":"gray"},{"text":"✗ Location gazebo_roof unavailable","color":"red"}]
execute if score gazebo_roof axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score gazebo_roof axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_gazebo_roof