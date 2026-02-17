execute as @a[tag=cuckold] at @s on vehicle if entity @s[tag=camera] run scoreboard players set @p penis_size 1

execute if score @p[tag=cuckold] cam_change matches 10.. run scoreboard players set @p[tag=cuckold] cam_change 1

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=1, penis_size = 1..}] at @n[tag=cam1] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=1, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam1] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=1, penis_size = 1..}] mount @n[tag=cam1]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=1, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=2, penis_size = 1..}] at @n[tag=cam2] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=2, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam2] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=2, penis_size = 1..}] mount @n[tag=cam2]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=2, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=3, penis_size = 1..}] at @n[tag=cam3] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=3, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam3] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=3, penis_size = 1..}] mount @n[tag=cam3]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=3, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=4, penis_size = 1..}] at @n[tag=cam4] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=4, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam4] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=4, penis_size = 1..}] mount @n[tag=cam4]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=4, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=5, penis_size = 1..}] at @n[tag=cam5] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=5, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam5] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=5, penis_size = 1..}] mount @n[tag=cam5]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=5, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=6, penis_size = 1..}] at @n[tag=cam6] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=6, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam6] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=6, penis_size = 1..}] mount @n[tag=cam6]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=6, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=7, penis_size = 1..}] at @n[tag=cam7] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=7, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam7] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=7, penis_size = 1..}] mount @n[tag=cam7]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=7, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=8, penis_size = 1..}] at @n[tag=cam8] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=8, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam8] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=8, penis_size = 1..}] mount @n[tag=cam8]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=8, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=9, penis_size = 1..}] at @n[tag=cam9] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
execute as @a[tag=cuckold, scores={cam_change=9, penis_size = 1..}] at @s on vehicle unless entity @s[tag=cam9] run ride @p dismount
ride @p[tag=cuckold, scores={cam_change=9, penis_size = 1..}] mount @n[tag=cam9]
execute as @a[tag=cuckold, scores={cam_trig = 1.., cam_change=9, penis_size = 1..}] run scoreboard players set @a cam_trig 0

execute if score @p[tag=cuckold] penis_size matches 0 run function trackbreak:camera_manager/dismount
scoreboard players set @a penis_size 0

# execute as @n[tag=ride_1] on target at @s run playsound minecraft:block.vault.insert_item master @s -7062 101 7991
execute as @n[tag=ride_1] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:1}
execute if data entity @n[tag=ride_1] interaction run data remove entity @n[tag=ride_1] interaction

execute as @n[tag=ride_2] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:2}
execute if data entity @n[tag=ride_2] interaction run data remove entity @n[tag=ride_2] interaction

execute as @n[tag=ride_3] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:3}
execute if data entity @n[tag=ride_3] interaction run data remove entity @n[tag=ride_3] interaction

execute as @n[tag=ride_4] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:4}
execute if data entity @n[tag=ride_4] interaction run data remove entity @n[tag=ride_4] interaction

execute as @n[tag=ride_5] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:5}
execute if data entity @n[tag=ride_5] interaction run data remove entity @n[tag=ride_5] interaction

execute as @n[tag=ride_6] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:6}
execute if data entity @n[tag=ride_6] interaction run data remove entity @n[tag=ride_6] interaction

execute as @n[tag=ride_7] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:7}
execute if data entity @n[tag=ride_7] interaction run data remove entity @n[tag=ride_7] interaction

execute as @n[tag=ride_8] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:8}
execute if data entity @n[tag=ride_8] interaction run data remove entity @n[tag=ride_8] interaction

execute as @n[tag=ride_9] on target at @s run execute as @p unless entity @p[tag=cuckold] run function trackbreak:camera_manager/ride {id:9}
execute if data entity @n[tag=ride_9] interaction run data remove entity @n[tag=ride_9] interaction

execute as @p[tag=cuckold] unless entity @n[tag=body] run kill @s