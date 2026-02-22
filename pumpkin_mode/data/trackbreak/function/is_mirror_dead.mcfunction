execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID run return 1
# say killed nigga
scoreboard players set @s is_mirroring 0
#kill @s
say dead