# Envoking phase-specific functions
execute if score phase pumpkin_counter matches 1..2 run function trackbreak:gameplay/main_game
execute if score phase pumpkin_counter matches 3 run function trackbreak:gameplay/phase_two

# Gate management in the beginning of the game
scoreboard players set in_gates gate_counter 0
execute as @a[tag=!oct_hunter, x=-7062,y=75,z=7933,dx=4,dy=4,dz=4] run scoreboard players add in_gates gate_counter 1

scoreboard players operation § gate_waiting_players = count_gnomes pumpkin_counter
scoreboard players operation § gate_waiting_players -= in_gates gate_counter 


# 0 -> 1; close outer gate
execute if score in_gates gate_counter = count_gnomes pumpkin_counter if score gate_state gate_counter matches 0 run fill -7060 76 7932 -7061 77 7932 minecraft:iron_bars
execute if score in_gates gate_counter = count_gnomes pumpkin_counter if score gate_state gate_counter matches 0 run scoreboard objectives setdisplay sidebar pies_until_axes
execute if score in_gates gate_counter = count_gnomes pumpkin_counter if score gate_state gate_counter matches 0 run scoreboard players set gate_state gate_counter 1

# state 1
execute if score gate_state gate_counter matches 1 run function trackbreak:gate_countdown

# state 2
# zone for exiting the gates
scoreboard players set in_gates2 gate_counter 0
execute as @a[tag=!oct_hunter, x=-7061,y=75,z=7932,dx=5,dy=5,dz=5] run scoreboard players add in_gates2 gate_counter 1

# state 2 -> 3; all players left the gate, close inner gate
execute if score in_gates2 gate_counter matches 0 if score gate_state gate_counter matches 2 run fill -7062 76 7937 -7059 77 7937 minecraft:iron_bars
execute if score in_gates2 gate_counter matches 0 if score gate_state gate_counter matches 2 run scoreboard players set gate_state gate_counter 3


# Camera room management
function trackbreak:camera_manager/main

# Mirror management
execute as @a store result score @s player_x run data get entity @s Pos[0] 10
scoreboard players set @a neg_player_z 0
execute as @a run scoreboard players operation @s neg_player_z -= @s player_z
scoreboard players set @a neg_player_x 0
execute as @a run scoreboard players operation @s neg_player_x -= @s player_x

execute as @a store result score @s player_y run data get entity @s Pos[1] 10
execute as @a store result score @s player_z run data get entity @s Pos[2] 10

execute as @a store result score @s player_view run data get entity @s Rotation[0]
scoreboard players set @a neg_player_view 180
execute as @a run scoreboard players operation @s neg_player_view -= @s player_view

execute as @a store result score @s player_view_y run data get entity @s Rotation[1]

execute as @a[gamemode=adventure, x=-7036,y=85,z=7960, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!oct_hunter] run function trackbreak:make_mirror
execute as @a[gamemode=adventure, x=-7038,y=85,z=7960, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

execute as @a[gamemode=adventure, x=-7036,y=85,z=7988, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!oct_hunter] run function trackbreak:make_mirror
execute as @a[gamemode=adventure, x=-7038,y=85,z=7988, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

execute as @a[gamemode=adventure, x=-7026,y=83,z=7960, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror
execute as @a[gamemode=adventure, x=-7026,y=83,z=7988, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

execute as @a[scores={is_mirroring=1..}] run function trackbreak:is_mirror_dead
execute in minecraft:overworld as @a[scores={is_mirroring=1..}] run function trackbreak:tick_mirror

# Handle pumpkin breaking
execute as @a[scores={pumpkin_breaks=1..}] run function trackbreak:on_break

# Handle golems, DEPRECATED
function trackbreak:golems_check

# Teleport to fontain. TODO: isolate into room-specific function
execute as @a[gamemode=adventure, x=-7053,y=57,z=7963,dx=0,dy=0,dz=0] run tp @s -7078 67 7963 ~ ~

# 
execute as @e[tag=add_pies] on target run execute as @s run scoreboard players add act_target pumpkin_counter 1
execute as @e[tag=add_pies] run data remove entity @s interaction

execute as @e[tag=remove_pies] on target run execute as @s run scoreboard players remove act_target pumpkin_counter 1
execute as @e[tag=remove_pies] run data remove entity @s interaction

execute as @e[tag=add_pies_axes] on target run execute as @s run scoreboard players add cond_ph_2 pumpkin_counter 1
execute as @e[tag=add_pies_axes] run data remove entity @s interaction

execute as @e[tag=remove_pies_axes] on target run execute as @s run scoreboard players remove cond_ph_2 pumpkin_counter 1
execute as @e[tag=remove_pies_axes] run data remove entity @s interaction

execute as @e[tag=axes_count_add] on target run execute as @s run scoreboard players add axes_count pumpkin_counter 1
execute as @e[tag=axes_count_add] run data remove entity @s interaction

execute as @e[tag=axes_count_remove] on target run execute as @s run scoreboard players remove axes_count pumpkin_counter 1
execute as @e[tag=axes_count_remove] run data remove entity @s interaction

execute as @e[tag=toggle_easy_mode] on target run execute as @s run function trackbreak:toggle_easy_mode
execute as @e[tag=toggle_easy_mode] run data remove entity @s interaction

execute as @e[tag=sit_1] on target run execute as @s run ride @s mount @n[type=minecraft:interaction, tag=sit_1]
execute as @e[tag=sit_1] run data remove entity @s interaction

execute as @e[tag=sit_2] on target run execute as @s run ride @s mount @n[type=minecraft:interaction, tag=sit_2]
execute as @e[tag=sit_2] run data remove entity @s interaction

execute as @n[tag=start_button] on target run function trackbreak:gameplay/start_game
execute if data entity @n[tag=start_button] interaction run data remove entity @n[tag=start_button] interaction

execute as @n[tag=pr_room] on target at @s run playsound minecraft:block.vault.insert_item master @s -7062 101 7991
execute as @n[tag=pr_room] on target run tp @s -7062 101 7991
execute if data entity @n[tag=pr_room] interaction run data remove entity @n[tag=pr_room] interaction

execute as @n[tag=pr_room_esc] on target at @s run playsound minecraft:block.vault.insert_item_fail master @s -7060.0 94.0 7991.0
execute as @n[tag=pr_room_esc] on target run tp @s -7060.0 94.0 7991.0 180 0
execute if data entity @n[tag=pr_room_esc] interaction run data remove entity @n[tag=pr_room_esc] interaction

execute as @e[tag=rand_hunter] on target run function trackbreak:gameplay/rand_hunter
execute as @e[tag=rand_hunter] run data remove entity @s interaction

execute as @e[tag=console] on target if entity @s[tag=admin] run trigger admin
execute as @e[tag=console] run data remove entity @s interaction

# Whitcher quest management. TODO: isolate into separate function
execute as @e[tag=get_axe] at @s on target run execute as @s[tag=oct_hunter] run data remove entity @n[tag=get_axe] interaction
execute as @e[tag=get_axe] on target run give @s iron_axe[custom_data={axe:1}, custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]]
execute as @e[tag=get_axe] if data entity @s interaction at @s run kill @n[tag=axe_pickup_display]
execute as @e[tag=get_axe] if data entity @s interaction at @s run kill @n[tag=axe_pickup_text]
execute as @e[tag=get_axe] if data entity @s interaction run kill @s

execute as @e[tag=axe_pickup_display] at @s run tp @s ~ ~ ~ ~3 ~
execute as @e[tag=axe_pickup_display] run scoreboard players add @s axe_bobbing 1
execute as @e[tag=axe_pickup_display] at @s if score @s axe_bobbing matches 1..20 run tp @s ~ ~0.01 ~
execute as @e[tag=axe_pickup_display] at @s if score @s axe_bobbing matches 21..40 run tp @s ~ ~-0.01 ~
execute as @e[tag=axe_pickup_display] if score @s axe_bobbing matches 40.. run scoreboard players set @s axe_bobbing 0

execute as @p[scores={dropped_axe=1..}] at @n[type=item, nbt={Item:{components:{"minecraft:custom_data":{axe:1}}}}] run function trackbreak:gameplay/spawn_axe
kill @n[type=item, nbt={Item:{components:{"minecraft:custom_data":{axe:1}}}}]
scoreboard players set @a dropped_axe 0

function trackbreak:fill_witcher

# Torches 

particle minecraft:flame -7022 79 7984 0.1 0.2 0.1 0.001 2
particle minecraft:flame -7020 79 7984 0.1 0.2 0.1 0.001 2

# execute if block -7060 85 7965 minecraft:water run setblock -7061 89 7963 minecraft:end_stone_brick_wall[waterlogged=false]
# execute if block -7059 86 7962 air run setblock -7061 89 7963 minecraft:end_stone_brick_wall[waterlogged=true]

execute if score state witcher_quest_state matches 1 if block -7046 86 7956 fire run scoreboard players set state witcher_quest_state 2
execute if score state witcher_quest_state matches 2 if block -7046 86 7956 air run scoreboard players set state witcher_quest_state 3
execute if score state witcher_quest_state matches 2 if block -7046 86 7956 water run scoreboard players set state witcher_quest_state 3
execute if score state witcher_quest_state matches 3 if block -7046 86 7956 minecraft:leaf_litter[segment_amount=4] run scoreboard players set state witcher_quest_state 4
execute if score state witcher_quest_state matches 4 if block -7046 86 7956 minecraft:water run scoreboard players set state witcher_quest_state 5

execute if score state witcher_quest_state matches 5.. run setblock -7048 86 7956 air

execute if score state witcher_quest_state matches 2.. run setblock -7051 88 7955 minecraft:air
execute if score state witcher_quest_state matches 3.. run setblock -7051 88 7954 minecraft:air
execute if score state witcher_quest_state matches 4.. run setblock -7051 88 7953 minecraft:air
execute if score state witcher_quest_state matches 5.. run setblock -7051 88 7952 minecraft:air

# ?????
scoreboard players enable @a[tag=admin] admin
execute as @a[scores={admin=1..}] run dialog show @s trackbreak:admin
scoreboard players set @a[scores={admin=1..}] admin 0

execute as @a if score @s svetov_open matches 1.. run setblock -7045 87 7990 air destroy
execute as @a if score @s svetov_open matches 1.. run scoreboard players set @a svetov_open 0

item replace block -7050 85 7985 container.0 with minecraft:music_disc_ward
item replace block -7050 85 7985 container.1 with minecraft:music_disc_lava_chicken
item replace block -7050 85 7985 container.2 with minecraft:music_disc_pigstep

item replace block -7051 86 7985 container.0 with minecraft:music_disc_tears
item replace block -7051 86 7985 container.1 with minecraft:music_disc_blocks
item replace block -7051 86 7985 container.2 with minecraft:music_disc_13

execute as @p[tag=oct_hunter, x=-7018, y=61, z=7928, dx=-100, dy=65, dz=100] if predicate trackbreak:is_on_ground run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=0]

# Forbiden zones management
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7017,y=77,z=7968,dx=6,dy=-15,dz=28,scores={outbound_counter=0}] run scoreboard players add @s outbound_counter 1
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7024,y=77,z=7991,dx=7,dy=13,dz=1,scores={outbound_counter=0}] run scoreboard players add @s outbound_counter 1
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7016,y=77,z=7969,dx=-5,dy=-4,dz=-20,scores={outbound_counter=0}] run scoreboard players add @s outbound_counter 1
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7021,y=75,z=7953,dx=-5,dy=5,dz=-2,scores={outbound_counter=0}] run scoreboard players add @s outbound_counter 1

execute as @a[scores={outbound_counter=1..}] run scoreboard players add @s outbound_counter 1

execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7017,y=77,z=7968,dx=6,dy=-15,dz=28] run effect give @s minecraft:slowness 1 3
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7024,y=77,z=7991,dx=7,dy=13,dz=1] run effect give @s minecraft:slowness 1 3
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7016,y=77,z=7969,dx=-5,dy=-4,dz=-20] run effect give @s minecraft:slowness 1 3
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7021,y=75,z=7953,dx=-5,dy=5,dz=-2] run effect give @s minecraft:slowness 1 3

execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7017,y=77,z=7968,dx=6,dy=-15,dz=28] run scoreboard players set @s outbound_last 1
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7024,y=77,z=7991,dx=7,dy=13,dz=1] run scoreboard players set @s outbound_last 2
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7016,y=77,z=7969,dx=-5,dy=-4,dz=-20] run scoreboard players set @s outbound_last 3
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7021,y=75,z=7953,dx=-5,dy=5,dz=-2] run scoreboard players set @s outbound_last 4

execute as @a[tag=!oct_hunter,gamemode=adventure,scores={outbound_counter=40..,outbound_last=1}] run execute positioned -7020 78 7975 run function trackbreak:tp_and_nausea
execute as @a[tag=!oct_hunter,gamemode=adventure,scores={outbound_counter=40..,outbound_last=2}] run execute positioned -7019 77 7989 run function trackbreak:tp_and_nausea
execute as @a[tag=!oct_hunter,gamemode=adventure,scores={outbound_counter=40..,outbound_last=3}] run execute positioned -7023 76 7962 run function trackbreak:tp_and_nausea
execute as @a[tag=!oct_hunter,gamemode=adventure,scores={outbound_counter=40..,outbound_last=4}] run execute positioned -7023 76 7955 run function trackbreak:tp_and_nausea

execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7019,y=77,z=7971,dx=-5,dy=6,dz=18] run scoreboard players set @s outbound_counter 0
execute as @a[tag=!oct_hunter,gamemode=adventure,x=-7024,y=79,z=7970,dx=2,dy=-3,dz=-16] run scoreboard players set @s outbound_counter 0

# Radar code, generated automatically. TODO: isolate into separate function
execute if entity @p[tag=oct_hunter,x=-7067,y=82,z=8000, dx=12, dy=7, dz=-18] run scoreboard players set cam1 cam_radar 1
execute if score cam1 cam_radar matches 1.. run setblock -7051 80 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam1 cam_radar matches 0 run setblock -7051 80 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam1 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7034,y=82,z=7965,dx=-17,dy=-5,dz=11] run scoreboard players set cam2 cam_radar 1
execute if score cam2 cam_radar matches 1.. run setblock -7050 80 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam2 cam_radar matches 0 run setblock -7050 80 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam2 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7070,y=75,z=7970,dx=-22,dy=17,dz=-28] run scoreboard players set cam3 cam_radar 1
execute if score cam3 cam_radar matches 1.. run setblock -7049 80 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam3 cam_radar matches 0 run setblock -7049 80 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam3 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7062,y=77,z=7959,dx=8,dy=6,dz=29] run scoreboard players set cam4 cam_radar 1
execute if score cam4 cam_radar matches 1.. run setblock -7051 79 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam4 cam_radar matches 0 run setblock -7051 79 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam4 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7052,y=85,z=7971,dx=-15,dy=3,dz=9] run scoreboard players set cam5 cam_radar 1
execute if score cam5 cam_radar matches 1.. run setblock -7050 79 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam5 cam_radar matches 0 run setblock -7050 79 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam5 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7043,y=73,z=7986,dx=-9,dy=4,dz=10] run scoreboard players set cam6 cam_radar 1
execute if score cam6 cam_radar matches 1.. run setblock -7049 79 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam6 cam_radar matches 0 run setblock -7049 79 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam6 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7026,y=85,z=7964,dx=-10,dy=5,dz=20] run scoreboard players set cam7 cam_radar 1
execute if score cam7 cam_radar matches 1.. run setblock -7051 78 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam7 cam_radar matches 0 run setblock -7051 78 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam7 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7070,y=78,z=7980,dx=-12,dy=2,dz=-8] run scoreboard players set cam8 cam_radar 1
execute if score cam8 cam_radar matches 1.. run setblock -7050 78 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam8 cam_radar matches 0 run setblock -7050 78 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam8 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7084,y=98,z=8001,dx=59,dy=7,dz=-51] run scoreboard players set cam9 cam_radar 1
execute if score cam9 cam_radar matches 1.. run setblock -7049 78 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam9 cam_radar matches 0 run setblock -7049 78 7952 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam9 cam_radar 0

execute as @a[tag=!oct_hunter] on attacker run effect give @s minecraft:glowing 1 1 true

execute as @e[tag=test_hb] at @s run function trackbreak:hb_set
execute unless entity @p[gamemode=adventure,tag=!oct_hunter,scores={hb_sys=0}] run scoreboard players set @a hb_sys 0

execute as @e[tag=test_hb] at @s on attacker run execute if entity @s[tag=oct_hunter] run function trackbreak:hb_hit

# Lobby management
execute in minecraft:overworld run data modify block -7076 79 7887 front_text.messages set value [["Количество"],["пирогов для"],["победы:"],[{"score":{"name":"act_target","objective":"pumpkin_counter"}}]]
execute in minecraft:overworld run data modify block -7076 80 7887 front_text.messages set value [["Количество"],["пирогов для"],["топоров:"],[{"score":{"name":"cond_ph_2","objective":"pumpkin_counter"}}]]
execute in minecraft:overworld run data modify block -7074 79 7889 front_text.messages set value [["Количество"],["топоров в"],["игре:"],[{"score":{"name":"axes_count","objective":"pumpkin_counter"}}]]
execute if score easy_mode pumpkin_counter matches 0 in minecraft:overworld run data modify block -7078 79 7891 front_text.messages set value [["Легкий режим"],["для хантера"],[{"text":"[OFF]", "color":"red"}],["Переключить===>"]]
execute if score easy_mode pumpkin_counter matches 1 in minecraft:overworld run data modify block -7078 79 7891 front_text.messages set value [["Легкий режим"],["для хантера"],[{"text":"[ON]", "color":"green"}],["Переключить===>"]]