function trackbreak:spawn_axes/setup
function trackbreak:spawn_axes/start_spawn

scoreboard players set phase pumpkin_counter 2

# hide axes countdown scoreboard
scoreboard objectives setdisplay sidebar

# Title & sound
playsound minecraft:item.trident.return master @a
title @a title {"text":"Вперёд за ТОПОРАМИ!","color":"yellow"}