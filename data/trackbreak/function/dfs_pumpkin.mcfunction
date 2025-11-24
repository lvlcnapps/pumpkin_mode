# run dfs
execute unless block ~ ~ ~ minecraft:pumpkin run return 1
particle minecraft:explosion ~ ~ ~
playsound minecraft:entity.dragon_fireball.explode block @a ~ ~ ~ 3
setblock ~ ~ ~ minecraft:air destroy
execute positioned ~1 ~ ~ run function trackbreak:dfs_pumpkin
execute positioned ~-1 ~ ~ run function trackbreak:dfs_pumpkin
execute positioned ~ ~1 ~ run function trackbreak:dfs_pumpkin
execute positioned ~ ~-1 ~ run function trackbreak:dfs_pumpkin
execute positioned ~ ~ ~1 run function trackbreak:dfs_pumpkin
execute positioned ~ ~ ~-1 run function trackbreak:dfs_pumpkin