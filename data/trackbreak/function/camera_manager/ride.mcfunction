tag @s add cuckold
execute at @p[tag=cuckold] run summon mannequin ~ ~ ~ {profile:"@s",pose:crouching,Tags:["body"],active_effects:[{id:invisibility,duration:-1,amplifier:1,show_particles:0b}],equipment:{head:{id:leather_helmet},chest:{id:leather_chestplate},legs:{id:leather_leggings},feet:{id:leather_boots}},drop_chances:{head:0f,chest:0f,legs:0f,feet:0f}}
execute at @p[tag=cuckold] run tp @n[tag=body] ~ ~ ~ ~ ~
clear @p[tag=cuckold] minecraft:player_head
clear @p[tag=cuckold] #minecraft:enchantable/armor
give @p[tag=cuckold] minecraft:warped_fungus_on_a_stick
$execute at @n[tag=cam$(id)] run tp @p[tag=cuckold] ~ ~ ~ ~ ~
$scoreboard players set @p[tag=cuckold] cam_change $(id)
$ride @p[tag=cuckold] mount @n[tag=cam$(id)]