# Attempt to spawn axe at church
execute if score church axe_available matches 1 run summon minecraft:interaction -7077 78 7976 {Tags:["get_axe"]}
execute if score church axe_available matches 1 run summon item_display -7077 78.5 7976 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score church axe_available matches 1 run summon minecraft:text_display -7077 79 7976 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score church axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score church axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_church