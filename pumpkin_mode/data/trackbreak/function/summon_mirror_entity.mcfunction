scoreboard players operation @s UUID = @p[tag=hold_player] UUID
item replace entity @s armor.head from entity @p[tag=hold_player] armor.head
item replace entity @s armor.chest from entity @p[tag=hold_player] armor.chest
item replace entity @s armor.legs from entity @p[tag=hold_player] armor.legs
item replace entity @s armor.feet from entity @p[tag=hold_player] armor.feet
tag @s add mirror_entity
# data modify entity @s Invulnerable set value 1b
data modify entity @s NoGravity set value 1b
effect give @s minecraft:invisibility infinite 1 true
attribute @s minecraft:scale base set 0.5
#execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["pornot"]}