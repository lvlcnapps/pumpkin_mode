# Generate random number from 0 to N-1 where N is number of locations
scoreboard players set #max random 27
function trackbreak:spawn_axes/random_number

# Try to spawn at randomly selected location
execute if score #result random matches 0 run function trackbreak:spawn_axes/spawn_at_gazebo
execute if score #result random matches 1 run function trackbreak:spawn_axes/spawn_at_gazebo_roof
execute if score #result random matches 2 run function trackbreak:spawn_axes/spawn_at_gate2
execute if score #result random matches 3 run function trackbreak:spawn_axes/spawn_at_garden_corner
execute if score #result random matches 4 run function trackbreak:spawn_axes/spawn_at_orange_garden
execute if score #result random matches 5 run function trackbreak:spawn_axes/spawn_at_gate1
execute if score #result random matches 6 run function trackbreak:spawn_axes/spawn_at_corridor_room
execute if score #result random matches 7 run function trackbreak:spawn_axes/spawn_at_corridor
execute if score #result random matches 8 run function trackbreak:spawn_axes/spawn_at_church
execute if score #result random matches 9 run function trackbreak:spawn_axes/spawn_at_staircase
execute if score #result random matches 10 run function trackbreak:spawn_axes/spawn_at_svetov
execute if score #result random matches 11 run function trackbreak:spawn_axes/spawn_at_theatre
execute if score #result random matches 12 run function trackbreak:spawn_axes/spawn_at_ocean_room
execute if score #result random matches 13 run function trackbreak:spawn_axes/spawn_at_orange_room
execute if score #result random matches 14 run function trackbreak:spawn_axes/spawn_at_princess
execute if score #result random matches 15 run function trackbreak:spawn_axes/spawn_at_attic
execute if score #result random matches 16 run function trackbreak:spawn_axes/spawn_at_mirror_right
execute if score #result random matches 17 run function trackbreak:spawn_axes/spawn_at_mirror_left
execute if score #result random matches 18 run function trackbreak:spawn_axes/spawn_at_bridge
execute if score #result random matches 19 run function trackbreak:spawn_axes/spawn_at_blue_garden
execute if score #result random matches 20 run function trackbreak:spawn_axes/spawn_at_dining_room
execute if score #result random matches 21 run function trackbreak:spawn_axes/spawn_at_inner_garden
execute if score #result random matches 22 run function trackbreak:spawn_axes/spawn_at_witcher
execute if score #result random matches 23 run function trackbreak:spawn_axes/spawn_at_poitions_room
execute if score #result random matches 24 run function trackbreak:spawn_axes/spawn_at_inner_garden_tree
execute if score #result random matches 25 run function trackbreak:spawn_axes/spawn_at_terentiy_room
execute if score #result random matches 26 run function trackbreak:spawn_axes/spawn_at_protoss