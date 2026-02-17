execute store result score player_count pumpkin_counter run random value 1..11

execute if score player_count pumpkin_counter matches 1 store result score player_test cosmo_counter run data get storage minecraft:data array[0] 1
execute if score player_count pumpkin_counter matches 1 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 1 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (red)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40238","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-662073347,1607614868,-1528156711,-1436011716],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTdkNWViMGFlYTVkNjFiYTNmZjQ5OTY0MTZhOTAwOTZhOWQ3NzYwOWViY2QzYjMwOGY5MDZhZTg4OGE0NWY2ZCJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=16711680]
execute if score player_count pumpkin_counter matches 1 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=16711680]
execute if score player_count pumpkin_counter matches 1 run execute store success storage minecraft:data array[0] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 1 run title @s actionbar {"text":"\u0412\u044b \u041a\u0440\u0430\u0441\u043d\u044b\u0439","color":"red"}

execute if score player_count pumpkin_counter matches 2 store result score player_test cosmo_counter run data get storage minecraft:data array[1] 1
execute if score player_count pumpkin_counter matches 2 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 2 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (green)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40237","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;352359622,925977922,-1873301266,377704229],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNGU2MzM0ODBkNGJmYmVhYTA0OWQwMTNlZDU3NDZkOWY1ZGY5NDk1ZDBiYWUxZDlhNzBkNWUyNjQ5YmMyNjRmIn19fQ=="}]}]
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=97293]
execute if score player_count pumpkin_counter matches 2 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=97293]
execute if score player_count pumpkin_counter matches 2 run execute store success storage minecraft:data array[1] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 2 run title @s actionbar {"text":"\u0412\u044b \u0417\u0435\u043b\u0435\u043d\u044b\u0439","color":"dark_green"}

execute if score player_count pumpkin_counter matches 3 store result score player_test cosmo_counter run data get storage minecraft:data array[2] 1
execute if score player_count pumpkin_counter matches 3 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 3 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (blue)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40236","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-803998778,-1982771594,-2005852933,-140769383],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjY3MGJjNWYwNDU4MzAwOTQwNTRhZWJjNzViMmVkMzdmYzU1ZjUyNGQ5NzlkODFlZjYxZjNkZTVjMjE3ZDBjYSJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=334014]
execute if score player_count pumpkin_counter matches 3 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=334014]
execute if score player_count pumpkin_counter matches 3 run execute store success storage minecraft:data array[2] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 3 run title @s actionbar {"text":"\u0412\u044b \u0421\u0438\u043d\u0438\u0439","color":"blue"}

execute if score player_count pumpkin_counter matches 4 store result score player_test cosmo_counter run data get storage minecraft:data array[3] 1
execute if score player_count pumpkin_counter matches 4 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 4 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (cyan)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40235","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-696027014,-374063041,-1925758743,1705160612],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2QzZWYxNTY0NjM2ODg5ZmUzYWNkM2JiMjY0ZWZkNzUyYzkwZDRjNmIyM2IwMGEzZWQ2YzJkN2Y1ZTgyMjc3NSJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=130043]
execute if score player_count pumpkin_counter matches 4 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=130043]
execute if score player_count pumpkin_counter matches 4 run execute store success storage minecraft:data array[3] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 4 run title @s actionbar {"text":"\u0412\u044b \u0413\u043e\u043b\u0443\u0431\u043e\u0439","color":"aqua"}

execute if score player_count pumpkin_counter matches 5 store result score player_test cosmo_counter run data get storage minecraft:data array[4] 1
execute if score player_count pumpkin_counter matches 5 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 5 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (lime)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40234","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;1626608579,-254852869,-1265071778,1690781561],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZTU4ZTU2Yzc2NWUzNDQyM2FkMjg3Nzg0MGFiN2M1Njg4YjQ0OTM5YzUzN2MyMDIzNjNhNGYxYjViNzU4MGRjOCJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=7528961]
execute if score player_count pumpkin_counter matches 5 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=7528961]
execute if score player_count pumpkin_counter matches 5 run execute store success storage minecraft:data array[4] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 5 run title @s actionbar {"text":"\u0412\u044b \u041b\u0430\u0439\u043c\u043e\u0432\u044b\u0439","color":"green"}

execute if score player_count pumpkin_counter matches 6 store result score player_test cosmo_counter run data get storage minecraft:data array[5] 1
execute if score player_count pumpkin_counter matches 6 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 6 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (yellow)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40233","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-399735754,737297530,-1105082921,-759756120],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYWI2YjEyYzFiODYyYjY4OTM2ZThhZWU3YTI0OGMzZTI1MmU4OGIxZmNmZjA1NzAwZmNlMWM5NTkxMjBhMjI5ZCJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=16770839]
execute if score player_count pumpkin_counter matches 6 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=16770839]
execute if score player_count pumpkin_counter matches 6 run execute store success storage minecraft:data array[5] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 6 run title @s actionbar {"text":"\u0412\u044b \u0416\u0435\u043b\u0442\u044b\u0439","color":"yellow"}

execute if score player_count pumpkin_counter matches 7 store result score player_test cosmo_counter run data get storage minecraft:data array[6] 1
execute if score player_count pumpkin_counter matches 7 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 7 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (orange)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40232","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-1915375372,1659324148,-1498952255,-1886087925],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDkxMGUzMDQ0MWNiODI5YjRlZThjYTFjMDQ0NGMxZmFjNmQ5NGFjZTVhNWMxN2NlNDZkNGVmNmNkOTNiMjNhOSJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=16735255]
execute if score player_count pumpkin_counter matches 7 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=16735255]
execute if score player_count pumpkin_counter matches 7 run execute store success storage minecraft:data array[6] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 7 run title @s actionbar {"text":"\u0412\u044b \u041e\u0440\u0430\u043d\u0436\u0435\u0432\u044b\u0439","color":"gold"}

execute if score player_count pumpkin_counter matches 8 store result score player_test cosmo_counter run data get storage minecraft:data array[7] 1
execute if score player_count pumpkin_counter matches 8 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 8 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (purple)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40231","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-710794232,-1977333220,-1238059903,1602584400],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNjhiODE4Njc3YmUzYzIwNzk5MzcxMzdmNTBkNTU1YzE2MTcwM2QwN2U5OWNjNzA4YjhiNWY0MTEyOTM4MjgxIn19fQ=="}]}]
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=6554056]
execute if score player_count pumpkin_counter matches 8 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=6554056]
execute if score player_count pumpkin_counter matches 8 run execute store success storage minecraft:data array[7] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 8 run title @s actionbar {"text":"\u0412\u044b \u0424\u0438\u043e\u043b\u0435\u0442\u043e\u0432\u044b\u0439","color":"dark_purple"}

execute if score player_count pumpkin_counter matches 9 store result score player_test cosmo_counter run data get storage minecraft:data array[8] 1
execute if score player_count pumpkin_counter matches 9 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 9 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (pink)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40228","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-1967961106,970212208,-1679270626,-248816416],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZmViMjBiOTM0NTNhODIwMThlMmQ0MDYzYjA4NDAzNWE1ZmU1NWE4YTE3NWRhNGNlMWFkYmM2ZWM0MGViZTI3MiJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=16658924]
execute if score player_count pumpkin_counter matches 9 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=16658924]
execute if score player_count pumpkin_counter matches 9 run execute store success storage minecraft:data array[8] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 9 run title @s actionbar {"text":"\u0412\u044b \u0420\u043e\u0437\u043e\u0432\u044b\u0439","color":"light_purple"}

execute if score player_count pumpkin_counter matches 10 store result score player_test cosmo_counter run data get storage minecraft:data array[9] 1
execute if score player_count pumpkin_counter matches 10 if score player_test cosmo_counter matches 1 run execute as @s run function trackbreak:gameplay/color_gnomes
execute if score player_count pumpkin_counter matches 10 if score player_test cosmo_counter matches 1 run return run none
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (brown)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40227","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;-1313882652,-408862150,-1735908917,44419283],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYzM1OWNjMWI0NjhiYmE1MTcwN2QwYjZlNGQyMjlkYTU1MGJjZDhiY2JkNGZjZmYyNzIwNTQwYTg1NjgxYjE3YiJ9fX0="}]}]
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=7481610]
execute if score player_count pumpkin_counter matches 10 run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=7481610]
execute if score player_count pumpkin_counter matches 10 run execute store success storage minecraft:data array[9] int 1 run scoreboard players get true cosmo_counter
execute if score player_count pumpkin_counter matches 10 run title @s actionbar {"text":"\u0412\u044b \u041a\u043e\u0440\u0438\u0447\u043d\u0435\u0432\u044b\u0439","color":"dark_red"}

execute if score player_count pumpkin_counter > player_max pumpkin_counter run item replace entity @s armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Crewmate (black)","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 40230","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],profile={id:[I;1576472881,-1426570003,-2127915164,-1373457821],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMjRlOTViZGQ1MTUxMjIyNTYxMzcwYmI2N2FkNGJiMDM2NjQxMGY5MTg2ZGQwMGNhNGQ0NWM2ZmViODQxOWVhYyJ9fX0="}]}]
execute if score player_count pumpkin_counter > player_max pumpkin_counter run item replace entity @s armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=0]
execute if score player_count pumpkin_counter > player_max pumpkin_counter run item replace entity @s armor.legs with minecraft:leather_leggings[minecraft:dyed_color=0]
execute if score player_count pumpkin_counter > player_max pumpkin_counter run title @s actionbar {"text":"\u0412\u044b \u0427\u0435\u0440\u043d\u044b\u0439","color":"black"}

# scoreboard players add player_count cosmo_counter 1