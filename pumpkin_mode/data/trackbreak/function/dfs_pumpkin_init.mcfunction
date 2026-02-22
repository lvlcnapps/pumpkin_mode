# run dfs
setblock ~ ~ ~ minecraft:air destroy
execute positioned ~1 ~ ~ run function trackbreak:dfs_pumpkin
execute positioned ~-1 ~ ~ run function trackbreak:dfs_pumpkin
execute positioned ~ ~1 ~ run function trackbreak:dfs_pumpkin
execute positioned ~ ~-1 ~ run function trackbreak:dfs_pumpkin
execute positioned ~ ~ ~1 run function trackbreak:dfs_pumpkin
execute positioned ~ ~ ~-1 run function trackbreak:dfs_pumpkin