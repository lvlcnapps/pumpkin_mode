execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID run return 1
scoreboard players set @s is_mirroring 0
say is dead
kill @s