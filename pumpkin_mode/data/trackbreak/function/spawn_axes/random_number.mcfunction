# Generate random number between 0 and #max
summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["random_uuid"]}
execute store result score #result random run data get entity @e[type=minecraft:area_effect_cloud,tag=random_uuid,limit=1] UUID[0]
kill @e[type=minecraft:area_effect_cloud,tag=random_uuid]
scoreboard players operation #result random %= #max random
# Make result positive if negative
execute if score #result random matches ..-1 run scoreboard players operation #result random *= #-1 constants