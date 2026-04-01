scoreboard players set @s pumpkin_breaks 0
tellraw @s {"text":"[on_break] pumpkin break detected — triggering DFS","color":"gold"}

execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^ run function trackbreak:dfs_pumpkin_init
execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^1 run function trackbreak:dfs_pumpkin_init
execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^2 run function trackbreak:dfs_pumpkin_init
execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^3 run function trackbreak:dfs_pumpkin_init
execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^4 run function trackbreak:dfs_pumpkin_init
execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^5 run function trackbreak:dfs_pumpkin_init
execute as @s[gamemode=adventure] at @s anchored eyes run execute positioned ^ ^ ^6 run function trackbreak:dfs_pumpkin_init