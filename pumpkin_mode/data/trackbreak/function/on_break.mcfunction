scoreboard players set @s pumpkin_breaks 0
tellraw @s {"text":"[on_break] pumpkin break detected — triggering DFS","color":"gold"}

execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^1 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^2 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^3 run function trackbreak:dfs_pumpkin

execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^1 ^ ^1 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^1 ^ ^2 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^1 ^ ^3 run function trackbreak:dfs_pumpkin

execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^1 ^1 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^1 ^2 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^1 ^3 run function trackbreak:dfs_pumpkin


execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^-1 ^ ^1 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^-1 ^ ^2 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^-1 ^ ^3 run function trackbreak:dfs_pumpkin

execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^-1 ^1 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^-1 ^2 run function trackbreak:dfs_pumpkin
execute as @a[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^-1 ^3 run function trackbreak:dfs_pumpkin