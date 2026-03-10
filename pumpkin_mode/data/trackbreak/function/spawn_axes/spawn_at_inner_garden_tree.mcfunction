# Attempt to spawn axe at inner_garden_tree
execute if score inner_garden_tree axe_available matches 1 run summon minecraft:interaction -7047 86 7965 {Tags:["get_axe"]}
execute if score inner_garden_tree axe_available matches 1 run summon item_display -7047 86.5 7965 {Tags:["axe_pickup_display"],item:{id:"minecraft:iron_axe"},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute if score inner_garden_tree axe_available matches 1 run summon minecraft:text_display -7047 87 7965 {text:["",{color:"#ffff55",text:"Нажми "},{color:"#55ff55",text:"[ПКМ]"},"\nчтобы забрать\n",{color:"#55ffff",text:"топор"}],billboard:center,Tags:["axe_pickup_text"]}
execute if score inner_garden_tree axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1
execute if score inner_garden_tree axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_inner_garden_tree