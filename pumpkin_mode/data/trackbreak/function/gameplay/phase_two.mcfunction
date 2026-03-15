team join specs @a[scores={death_handler = 1..}]
gamemode spectator @a[scores={death_handler = 1..}]
execute at @a[scores={death_handler=1..}] run summon mannequin ~ ~ ~ {Tags:["cadaver"],pose:sleeping,attributes:[{id:scale,base:0.5f}]}
execute as @a[scores={death_handler=1..}] run function trackbreak:kill_mirror
execute as @a if items entity @s[scores={death_handler=1..}] container.* iron_axe[custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]] at @s run function trackbreak:gameplay/spawn_axe
execute as @a if items entity @s[scores={death_handler=1..}] weapon.offhand iron_axe[custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]] at @s run function trackbreak:gameplay/spawn_axe
scoreboard players set @a[scores={death_handler = 1..}] death_handler 0

execute as @a[tag=oct_hunter] at @s if entity @a[tag=!oct_hunter, distance=..20, team=!specs] run effect give @s minecraft:saturation 2

execute unless score p2_count pumpkin_counter matches -1 run scoreboard players remove p2_count pumpkin_counter 1
execute store result bossbar minecraft:bb1 value run scoreboard players get p2_count pumpkin_counter

scoreboard players set dead pumpkin_counter 0
execute as @a[team=specs,tag=!oct_hunter] run scoreboard players add dead pumpkin_counter 1
scoreboard players operation dead pumpkin_counter -= count_gnomes pumpkin_counter
execute if score end pumpkin_counter matches 0 if score dead pumpkin_counter matches 0 run function trackbreak:gameplay/end_game

execute as @a[gamemode=adventure, x=-7059, y=76, z=7936, dx=-3, dy=2, dz=-1] run function trackbreak:gameplay/release
execute as @a[gamemode=adventure, x=-7099, y=76, z=7975, dx=-1, dy=2, dz=2] run function trackbreak:gameplay/release

execute if score p2_count pumpkin_counter matches 0 run function trackbreak:gameplay/end_game