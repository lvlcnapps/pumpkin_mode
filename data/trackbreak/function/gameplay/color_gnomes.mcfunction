execute store result score player_count pumpkin_counter run random value 1..11

execute if score player_count pumpkin_counter matches 1 store result score player_test pumpkin_counter run data get storage minecraft:data array[0] 1
execute if score player_count pumpkin_counter matches 1 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 1 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=11546150]
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=11546150]
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=11546150]
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=11546150]
execute if score player_count pumpkin_counter matches 1 run execute store success storage minecraft:data array[0] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 1 run title @s actionbar {"text":"\u0412\u044b \u041a\u0440\u0430\u0441\u043d\u044b\u0439","color":"red"}

execute if score player_count pumpkin_counter matches 2 store result score player_test pumpkin_counter run data get storage minecraft:data array[1] 1
execute if score player_count pumpkin_counter matches 2 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 2 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=6192150]
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=6192150]
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=6192150]
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=6192150]
execute if score player_count pumpkin_counter matches 2 run execute store success storage minecraft:data array[1] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 2 run title @s actionbar {"text":"\u0412\u044b \u0417\u0435\u043b\u0435\u043d\u044b\u0439","color":"dark_green"}

execute if score player_count pumpkin_counter matches 3 store result score player_test pumpkin_counter run data get storage minecraft:data array[2] 1
execute if score player_count pumpkin_counter matches 3 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 3 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=3949738]
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=3949738]
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=3949738]
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=3949738]
execute if score player_count pumpkin_counter matches 3 run execute store success storage minecraft:data array[2] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 3 run title @s actionbar {"text":"\u0412\u044b \u0421\u0438\u043d\u0438\u0439","color":"blue"}

execute if score player_count pumpkin_counter matches 4 store result score player_test pumpkin_counter run data get storage minecraft:data array[3] 1
execute if score player_count pumpkin_counter matches 4 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 4 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=1481884]
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=1481884]
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=1481884]
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=1481884]
execute if score player_count pumpkin_counter matches 4 run execute store success storage minecraft:data array[3] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 4 run title @s actionbar {"text":"\u0412\u044b \u0413\u043e\u043b\u0443\u0431\u043e\u0439","color":"aqua"}

execute if score player_count pumpkin_counter matches 5 store result score player_test pumpkin_counter run data get storage minecraft:data array[4] 1
execute if score player_count pumpkin_counter matches 5 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 5 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=8439583]
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=8439583]
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=8439583]
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=8439583]
execute if score player_count pumpkin_counter matches 5 run execute store success storage minecraft:data array[4] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 5 run title @s actionbar {"text":"\u0412\u044b \u041b\u0430\u0439\u043c\u043e\u0432\u044b\u0439","color":"green"}

execute if score player_count pumpkin_counter matches 6 store result score player_test pumpkin_counter run data get storage minecraft:data array[5] 1
execute if score player_count pumpkin_counter matches 6 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 6 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=16701501]
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=16701501]
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=16701501]
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=16701501]
execute if score player_count pumpkin_counter matches 6 run execute store success storage minecraft:data array[5] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 6 run title @s actionbar {"text":"\u0412\u044b \u0416\u0435\u043b\u0442\u044b\u0439","color":"yellow"}

execute if score player_count pumpkin_counter matches 7 store result score player_test pumpkin_counter run data get storage minecraft:data array[6] 1
execute if score player_count pumpkin_counter matches 7 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 7 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=16351261]
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=16351261]
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=16351261]
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=16351261]
execute if score player_count pumpkin_counter matches 7 run execute store success storage minecraft:data array[6] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 7 run title @s actionbar {"text":"\u0412\u044b \u041e\u0440\u0430\u043d\u0436\u0435\u0432\u044b\u0439","color":"gold"}

execute if score player_count pumpkin_counter matches 8 store result score player_test pumpkin_counter run data get storage minecraft:data array[7] 1
execute if score player_count pumpkin_counter matches 8 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 8 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=8991416]
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=8991416]
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=8991416]
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=8991416]
execute if score player_count pumpkin_counter matches 8 run execute store success storage minecraft:data array[7] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 8 run title @s actionbar {"text":"\u0412\u044b \u0424\u0438\u043e\u043b\u0435\u0442\u043e\u0432\u044b\u0439","color":"dark_purple"}

execute if score player_count pumpkin_counter matches 9 store result score player_test pumpkin_counter run data get storage minecraft:data array[8] 1
execute if score player_count pumpkin_counter matches 9 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 9 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=13061821]
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=13061821]
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=13061821]
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=13061821]
execute if score player_count pumpkin_counter matches 9 run execute store success storage minecraft:data array[8] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 9 run title @s actionbar {"text":"\u0412\u044b \u0420\u043e\u0437\u043e\u0432\u044b\u0439","color":"light_purple"}

execute if score player_count pumpkin_counter matches 10 store result score player_test pumpkin_counter run data get storage minecraft:data array[9] 1
execute if score player_count pumpkin_counter matches 10 if score player_test pumpkin_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 10 if score player_test pumpkin_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.head with minecraft:leather_helmet[dyed_color=8606770]
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.chest with minecraft:leather_chestplate[dyed_color=8606770]
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.legs with minecraft:leather_leggings[dyed_color=8606770]
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.feet with minecraft:leather_boots[dyed_color=8606770]
execute if score player_count pumpkin_counter matches 10 run execute store success storage minecraft:data array[9] int 1 run scoreboard players get true pumpkin_counter
execute if score player_count pumpkin_counter matches 10 run title @s actionbar {"text":"\u0412\u044b \u041a\u043e\u0440\u0438\u0447\u043d\u0435\u0432\u044b\u0439","color":"dark_red"}

execute if score player_count pumpkin_counter matches 11.. run item replace entity @s armor.head with minecraft:leather_helmet[minecraft:dyed_color=0]
execute if score player_count pumpkin_counter matches 11.. run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=0]
execute if score player_count pumpkin_counter matches 11.. run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=0]
execute if score player_count pumpkin_counter matches 11.. run item replace entity @s armor.feet with minecraft:leather_boots[minecraft:dyed_color=0]
execute if score player_count pumpkin_counter matches 11.. run title @s actionbar {"text":"\u0412\u044b \u0427\u0435\u0440\u043d\u044b\u0439","color":"black"}

# scoreboard players add player_count cosmo_counter 1