execute if score phase pumpkin_counter matches 1..2 run function trackbreak:gameplay/main_game
execute if score phase pumpkin_counter matches 3 run function trackbreak:gameplay/phase_two

function trackbreak:camera_manager/main

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

# execute as @a[x=-7036,y=85,z=7960, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!oct_hunter] run function trackbreak:make_mirror
# execute as @a[x=-7038,y=85,z=7960, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror
# 
# execute as @a[x=-7036,y=85,z=7988, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!oct_hunter] run function trackbreak:make_mirror
# execute as @a[x=-7038,y=85,z=7988, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror
# 
# execute as @a[x=-7036,y=90,z=7979, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!oct_hunter] run function trackbreak:make_mirror
# execute as @a[x=-7038,y=90,z=7979, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

#execute as @a[scores={is_mirroring=1..}] run function trackbreak:is_mirror_dead
#execute in minecraft:overworld as @a[scores={is_mirroring=1..}] run function trackbreak:tick_mirror

execute at @a[scores={death_handler=1..}] run summon mannequin ~ ~ ~ {Tags:["cadaver"],pose:sleeping,attributes:[{id:scale,base:0.5f}]}
execute as @a[scores={death_handler=1..}] run function trackbreak:kill_mirror
scoreboard players set @a death_handler 0

execute as @a[tag=hunter] at @s anchored eyes if block ^ ^ ^1 minecraft:pumpkin run execute positioned ^ ^ ^1 run function trackbreak:dfs_pumpkin

function trackbreak:golems_check

execute as @a[x=-7053,y=57,z=7963,dx=0,dy=0,dz=0] run tp @s -7078 67 7963 ~ ~

execute as @e[tag=add_pies] on target run execute as @s run scoreboard players add act_target pumpkin_counter 1
execute as @e[tag=add_pies] run data remove entity @s interaction

execute as @e[tag=remove_pies] on target run execute as @s run scoreboard players remove act_target pumpkin_counter 1
execute as @e[tag=remove_pies] run data remove entity @s interaction

execute as @n[tag=start_button] on target run function trackbreak:gameplay/start_game
execute if data entity @n[tag=start_button] interaction run data remove entity @n[tag=start_button] interaction

execute as @n[tag=pr_room] on target at @s run playsound minecraft:block.vault.insert_item master @s -7062 101 7991
execute as @n[tag=pr_room] on target run tp @s -7062 101 7991
execute if data entity @n[tag=pr_room] interaction run data remove entity @n[tag=pr_room] interaction

execute as @n[tag=pr_room_esc] on target at @s run playsound minecraft:block.vault.insert_item_fail master @s -7060.0 94.0 7991.0
execute as @n[tag=pr_room_esc] on target run tp @s -7060.0 94.0 7991.0 180 0
execute if data entity @n[tag=pr_room_esc] interaction run data remove entity @n[tag=pr_room_esc] interaction

function trackbreak:fill_witcher

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

scoreboard players enable @a[tag=admin] admin
execute as @a[scores={admin=1..}] run dialog show @s trackbreak:admin
scoreboard players set @a[scores={admin=1..}] admin 0

execute if entity @p[tag=oct_hunter,x=-7067,y=82,z=8000, dx=12, dy=7, dz=-18] run scoreboard players set cam1 cam_radar 1
execute if score cam1 cam_radar matches 1.. run setblock -7051 80 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam1 cam_radar matches 0 run setblock -7051 80 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam1 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7034,y=82,z=7965,dx=-17,dy=-5,dz=11] run scoreboard players set cam2 cam_radar 1
execute if score cam2 cam_radar matches 1.. run setblock -7050 80 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam2 cam_radar matches 0 run setblock -7050 80 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam2 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7070,y=75,z=7970,dx=-22,dy=17,dz=-28] run scoreboard players set cam3 cam_radar 1
execute if score cam3 cam_radar matches 1.. run setblock -7049 80 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam3 cam_radar matches 0 run setblock -7049 80 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam3 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7062,y=77,z=7959,dx=8,dy=6,dz=29] run scoreboard players set cam4 cam_radar 1
execute if score cam4 cam_radar matches 1.. run setblock -7051 79 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam4 cam_radar matches 0 run setblock -7051 79 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam4 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7052,y=85,z=7971,dx=-15,dy=3,dz=9] run scoreboard players set cam5 cam_radar 1
execute if score cam5 cam_radar matches 1.. run setblock -7050 79 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam5 cam_radar matches 0 run setblock -7050 79 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam5 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7043,y=73,z=7986,dx=-9,dy=4,dz=10] run scoreboard players set cam6 cam_radar 1
execute if score cam6 cam_radar matches 1.. run setblock -7049 79 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam6 cam_radar matches 0 run setblock -7049 79 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam6 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7026,y=85,z=7964,dx=-10,dy=5,dz=20] run scoreboard players set cam7 cam_radar 1
execute if score cam7 cam_radar matches 1.. run setblock -7051 78 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam7 cam_radar matches 0 run setblock -7051 78 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam7 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7070,y=78,z=7980,dx=-12,dy=2,dz=-8] run scoreboard players set cam8 cam_radar 1
execute if score cam8 cam_radar matches 1.. run setblock -7050 78 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam8 cam_radar matches 0 run setblock -7050 78 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam8 cam_radar 0

execute if entity @p[tag=oct_hunter,x=-7084,y=98,z=8001,dx=59,dy=7,dz=-51] run scoreboard players set cam9 cam_radar 1
execute if score cam9 cam_radar matches 1.. run setblock -7049 78 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (включен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMzgzYjgyMmNmMmU1MDE0YzIwMTgxN2U3ZjZmZTExYjA2Y2MyMzFjZTE1YTBhNmI3ZDdkODYzMTMyZTYzMmFjNCJ9fX0="}]}}
execute if score cam9 cam_radar matches 0 run setblock -7049 78 7949 minecraft:player_head[rotation=8]{custom_name:'{"text":"Компьютер (выключен)","color":"gold","underlined":true,"bold":true,"italic":false}',profile:{id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTViMzRjNmNlZTY4NGQ3MTcxNGIzYTFjNzExNTExY2JkNjkyNDQ3ODIwYmM5YTExMzYyOGMxZDM1ODA0ODI1ZSJ9fX0="}]}}
scoreboard players set cam9 cam_radar 0

execute in minecraft:overworld run data modify block -7076 79 7887 front_text.messages set value [["Количество"],["пирогов для"],["победы:"],[{"score":{"name":"act_target","objective":"pumpkin_counter"}}]]