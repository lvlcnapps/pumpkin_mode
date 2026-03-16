scoreboard players set phase pumpkin_counter 3
scoreboard objectives setdisplay sidebar display_ph_2

title @a title {"text":"ВЫБИРАЙТЕСЬ","bold":true,"color":"red"}
title @a subtitle {"text":"Выйдите за пределы особняка","color":"light_purple"}

fill -7062 76 7937 -7059 77 7937 air
fill -7098 76 7975 -7098 78 7977 air

execute as @a at @s run playsound minecraft:block.bell.use master @s ~ ~ ~ 1 1

bossbar set minecraft:bb1 style progress
bossbar set minecraft:bb1 name "До конца игры:"
bossbar set minecraft:bb1 max 1600
bossbar set minecraft:bb1 color red

scoreboard players set p2_count pumpkin_counter 1600
