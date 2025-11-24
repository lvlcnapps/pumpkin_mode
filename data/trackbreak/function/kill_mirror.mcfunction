execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID as @n[tag=mirror_entity] run kill @s
scoreboard players set @s is_mirroring 0

# say killed mirror entity