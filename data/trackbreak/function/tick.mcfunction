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

execute as @a[x=650, y=73, z=-426, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!oct_hunter] run function trackbreak:make_mirror
execute as @a[x=648, y=73, z=-426, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

execute as @a[x=650, y=73, z=-398, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!hunter] run function trackbreak:make_mirror
execute as @a[x=648, y=73, z=-398, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

execute as @a[x=650, y=78, z=-407, dx=0, dy=1, dz=0, scores={is_mirroring=0}, tag=!hunter] run function trackbreak:make_mirror
execute as @a[x=648, y=78, z=-407, dx=0, dy=1, dz=0, scores={is_mirroring=1}] run function trackbreak:kill_mirror

execute as @a[scores={is_mirroring=1..}] run function trackbreak:is_mirror_dead
execute in minecraft:overworld as @a[scores={is_mirroring=1..}] run function trackbreak:tick_mirror

execute at @a[scores={death_handler=1..}] run summon mannequin ~ ~ ~ {Tags:["cadaver"],pose:sleeping,attributes:[{id:scale,base:0.5f}]}
execute as @a[scores={death_handler=1..}] run function trackbreak:kill_mirror
scoreboard players set @a death_handler 0

execute as @a[tag=hunter] at @s anchored eyes if block ^ ^ ^1 minecraft:pumpkin run execute positioned ^ ^ ^1 run function trackbreak:dfs_pumpkin

function trackbreak:golems_check

execute as @a[x=633,y=45,z=-423,dx=0,dy=0,dz=0] run tp @s 608 55 -423 ~ ~

execute as @n[tag=pr_room] on target at @s run playsound minecraft:block.vault.insert_item master @s 624 89 -395
execute as @n[tag=pr_room] on target run tp @s 624 89 -395
execute if data entity @n[tag=pr_room] interaction run data remove entity @n[tag=pr_room] interaction

execute as @n[tag=pr_room_esc] on target at @s run playsound minecraft:block.vault.insert_item_fail master @s 626.0 82.00 -394.0
execute as @n[tag=pr_room_esc] on target run tp @s 626.0 82.00 -394.0 180 0
execute if data entity @n[tag=pr_room_esc] interaction run data remove entity @n[tag=pr_room_esc] interaction

function trackbreak:fill_witcher

execute if block 626 73 -421 minecraft:water run setblock 625 77 -423 minecraft:end_stone_brick_wall[waterlogged=false]
execute if block 627 74 -424 air run setblock 625 77 -423 minecraft:end_stone_brick_wall[waterlogged=true]

execute if score state witcher_quest_state matches 1 if block 640 74 -430 fire run scoreboard players set state witcher_quest_state 2
execute if score state witcher_quest_state matches 2 if block 640 74 -430 air run scoreboard players set state witcher_quest_state 3
execute if score state witcher_quest_state matches 2 if block 640 74 -430 water run scoreboard players set state witcher_quest_state 3
execute if score state witcher_quest_state matches 3 if block 640 74 -430 minecraft:leaf_litter[segment_amount=4] run scoreboard players set state witcher_quest_state 4
execute if score state witcher_quest_state matches 4 if block 640 74 -430 minecraft:water run scoreboard players set state witcher_quest_state 5

execute if score state witcher_quest_state matches 5.. run setblock 638 74 -430 air

execute if score state witcher_quest_state matches 2.. run setblock 635 76 -431 minecraft:air
execute if score state witcher_quest_state matches 3.. run setblock 635 76 -432 minecraft:air
execute if score state witcher_quest_state matches 4.. run setblock 635 76 -433 minecraft:air
execute if score state witcher_quest_state matches 5.. run setblock 635 76 -434 minecraft:air