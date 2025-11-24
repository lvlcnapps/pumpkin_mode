execute at @e[tag=mirror_entity] store result score @n[tag=mirror_entity] player_y if score @n[tag=mirror_entity] UUID = @s UUID run scoreboard players get @s player_y
execute at @e[tag=mirror_entity] store result score @n[tag=mirror_entity] player_x if score @n[tag=mirror_entity] UUID = @s UUID run scoreboard players get @s player_x

execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID as @n[tag=mirror_entity] run execute store result entity @s Pos[1] double 0.1 run scoreboard players get @s player_y
execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID as @n[tag=mirror_entity] run execute store result entity @s Pos[0] double 0.1 run scoreboard players get @s player_x

execute at @e[tag=mirror_entity] store result score @n[tag=mirror_entity] player_z if score @n[tag=mirror_entity] UUID = @s UUID run scoreboard players get @s neg_player_z
execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID as @n[tag=mirror_entity] run scoreboard players remove @s player_z 8230
execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID as @n[tag=mirror_entity] run execute store result entity @s Pos[2] double 0.1 run scoreboard players get @s player_z

# tellraw @s ["",{"text":"Coordinates: x = "},{"score":{"name":"@s","objective":"player_x"}},{"text":" , y = "},{"score":{"name":"@s","objective":"player_y"}},{"text":" , z = "},{"score":{"name":"@s","objective":"player_z"}},{"text":" "}]

execute at @e[tag=mirror_entity] store result score @n[tag=mirror_entity] player_view if score @n[tag=mirror_entity] UUID = @s UUID run scoreboard players get @s neg_player_view
execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID as @n[tag=mirror_entity] run execute store result entity @s Rotation[0] float 1.0 run scoreboard players get @s player_view

execute at @e[tag=mirror_entity] store result score @n[tag=mirror_entity] player_view_y if score @n[tag=mirror_entity] UUID = @s UUID run scoreboard players get @s player_view_y
execute as @e[tag=mirror_entity] run execute store result entity @s Rotation[1] float 1.0 run scoreboard players get @s player_view_y

execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID if predicate trackbreak:is_sneaking as @n[tag=mirror_entity] run data modify entity @s pose set value crouching
execute at @e[tag=mirror_entity] if score @n[tag=mirror_entity] UUID = @s UUID unless predicate trackbreak:is_sneaking as @n[tag=mirror_entity] run data modify entity @s pose set value standing