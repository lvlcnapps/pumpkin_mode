# Attempt to spawn axe at garden_corner
execute if score garden_corner axe_available matches 1 run summon minecraft:interaction -7090 76 7998 {Tags:["get_axe"]}
execute if score garden_corner axe_available matches 1 run summon item_display -7090 76.5 7998 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score garden_corner axe_available matches 1 run summon minecraft:text_display -7090 77 7998 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score garden_corner axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score garden_corner axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_garden_corner