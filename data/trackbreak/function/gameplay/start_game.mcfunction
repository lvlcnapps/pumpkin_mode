tag @s add oct_hunter
team join hunter @a[tag=oct_hunter]
tp @s -7210 63 7981

execute as @a run attribute @s minecraft:safe_fall_distance base set 100

effect give @a[tag=oct_hunter] minecraft:strength infinite 50 true
effect give @a[tag=oct_hunter] minecraft:speed infinite 3 true
effect give @a[tag=oct_hunter] minecraft:dolphins_grace infinite 3 true
effect give @a[tag=oct_hunter] minecraft:jump_boost infinite 6 true
execute as @a[tag=!oct_hunter] run attribute @s minecraft:scale base set 0.5
execute as @a[tag=oct_hunter] run attribute @s minecraft:scale base set 1

effect give @a minecraft:invisibility infinite 1 true
gamemode adventure @a

scoreboard players set @a logged 0
scoreboard players set target pumpkin_counter 0
scoreboard players operation target pumpkin_counter += max pumpkin_counter
scoreboard players operation target pumpkin_counter -= act_target pumpkin_counter
# scoreboard objectives setdisplay sidebar pumpkin_disp_goal
scoreboard players add game_id pumpkin_counter 1
scoreboard players set count_gnomes pumpkin_counter 0
execute as @a[tag=!oct_hunter] run scoreboard players add count_gnomes pumpkin_counter 1
scoreboard players set @a stats_kills 0
scoreboard players set game_time pumpkin_counter 0
scoreboard players set count_pies pumpkin_counter 0
scoreboard players set end pumpkin_counter 0
# execute as @a[tag=!oct_hunter] run function cosmo:gameplay/color_amogus

item replace entity @a[tag=oct_hunter] armor.chest with minecraft:leather_chestplate[minecraft:dyed_color=0]
item replace entity @a[tag=oct_hunter] armor.legs with minecraft:leather_leggings[minecraft:dyed_color=0]
item replace entity @a[tag=oct_hunter] armor.feet with minecraft:leather_boots[minecraft:dyed_color=0]
item replace entity @a[tag=oct_hunter] armor.head with minecraft:player_head[minecraft:custom_name='{"text":"Ксеноморф","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"ID головы: 11937","color":"gray","italic":false}','{"text":"mcheads.ru","color":"blue","italic":false}'],profile={id:[I;2080793942,-524468218,-1541115779,1949756395],properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvM2M2OWJjMjBkOGQ4MzU5MjMxZjM5NTQ2MmUwNjU5YmNiM2Q2MmFkMjBhMjhmN2I1ZDU1YWVlYzg5Yzc3MzY4In19fQ=="}]}] 1
item replace entity @a[tag=oct_hunter] weapon.mainhand with minecraft:netherite_hoe[minecraft:custom_name='[{"text":"Культяпка","italic":false}]'] 1
item replace entity @a[tag=oct_hunter] weapon.offhand with minecraft:netherite_hoe[minecraft:custom_name='[{"text":"Культяпка","italic":false}]'] 1


item replace entity @a[tag=!oct_hunter] armor.chest with minecraft:leather_chestplate
item replace entity @a[tag=!oct_hunter] armor.legs with minecraft:leather_leggings
item replace entity @a[tag=!oct_hunter] armor.feet with minecraft:leather_boots
item replace entity @a[tag=!oct_hunter] armor.head with minecraft:leather_helmet

bossbar set minecraft:bb1 players sdsdcc2442
bossbar set minecraft:bb1 players @a