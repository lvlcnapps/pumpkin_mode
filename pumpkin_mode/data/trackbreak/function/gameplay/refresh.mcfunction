say refreshing game...

execute as @a run attribute @s minecraft:scale base set 1
gamemode adventure @a
execute in minecraft:overworld run tp @a -7078 78 7896
execute in minecraft:overworld run spawnpoint @a 313 283 65
tag @a remove oct_hunter
team join boots @a
effect clear @a
clear @a

scoreboard players set data pumpkin_counter 0
scoreboard players set phase pumpkin_counter 1
scoreboard players set player_count pumpkin_counter 1
# scoreboard players display numberformat Спасшихся: display_ph_2 styled {"color":"red"}
# scoreboard objectives setdisplay sidebar dsds
data modify storage minecraft:data array set value [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
scoreboard players set p2_count pumpkin_counter -1

bossbar set minecraft:bb1 max 20
bossbar set minecraft:bb1 style notched_20
bossbar set minecraft:bb1 name "Собери пироги!"
bossbar set minecraft:bb1 color green

# Pies until axes sidebar
scoreboard objectives add pies_until_axes dummy {"text":"Axes in:","color":"gold"}
scoreboard objectives setdisplay sidebar pies_until_axes