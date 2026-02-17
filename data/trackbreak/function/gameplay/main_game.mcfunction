function trackbreak:gameplay/count_pies

team join specs @a[scores={death_handler = 1..}]
gamemode spectator @a[scores={death_handler = 1..}]
scoreboard players set @a[scores={death_handler = 1..}] death_handler 0

execute as @a[tag=oct_hunter] at @s if entity @a[tag=!oct_hunter, distance=..20, team=!specs] run effect give @s minecraft:saturation 2

effect give @a[scores={check_fake = 1..}] minecraft:glowing 2 1
scoreboard players set @a[scores={check_fake = 1..}] check_fake 0

effect give @a[scores={check_shulker = 1..}] minecraft:glowing 2 1
scoreboard players set @a[scores={check_shulker = 1..}] check_shulker 0

scoreboard players set dead pumpkin_counter 0
execute as @a[team=specs,tag=!oct_hunter] run scoreboard players add dead pumpkin_counter 1
scoreboard players operation dead pumpkin_counter -= count_gnomes pumpkin_counter
execute if score end pumpkin_counter matches 0 if score dead pumpkin_counter matches 0 run function trackbreak:gameplay/hunter_win