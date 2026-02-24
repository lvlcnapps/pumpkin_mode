item replace block -7027 85 7960 container.0 with iron_axe[custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]]
item replace block -7060 101 7991 container.0 with iron_axe[custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]]
item replace block -7047 74 7995 container.0 with iron_axe[custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]]
item replace block -7083 77 7971 container.0 with iron_axe[custom_name=[{"text":"TOPOR9000","italic":false}],lore=[[{"text":"super TOPOR from GOD","italic":false}]],item_name=[{"text":"topor","italic":false}],enchantments={efficiency:10},can_break=[{blocks:pumpkin}]]

scoreboard players set phase pumpkin_counter 2

# hide axes countdown scoreboard
scoreboard objectives setdisplay sidebar

# Title & sound
playsound minecraft:item.trident.return master @a
title @a title {"text":"Вперёд за ТОПОРАМИ!","color":"yellow"}