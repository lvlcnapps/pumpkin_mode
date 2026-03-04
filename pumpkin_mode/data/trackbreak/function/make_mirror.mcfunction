tag @s add negr
execute in minecraft:overworld at @s summon minecraft:mannequin run function trackbreak:summon_mirror_entity
tag @s remove negr
scoreboard players set @s is_mirroring 1