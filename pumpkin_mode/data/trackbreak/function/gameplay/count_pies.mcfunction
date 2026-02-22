execute in minecraft:overworld if data block -7051 76 7945 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7082 76 7959 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7083 77 7971 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7072 78 7989 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7092 72 7995 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7051 78 7966 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7046 70 7966 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7048 85 7956 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7029 75 7960 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7046 87 7950 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7026 78 7984 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7047 74 7995 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7045 82 7978 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7065 78 7963 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7082 78 7976 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7061 78 8000 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7065 91 7999 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7066 86 7976 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7060 84 7962 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7031 85 7973 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7031 85 7975 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7027 85 7960 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7038 90 7979 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7046 91 7954 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7059 90 7980 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7071 95 7958 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7060 101 7991 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7082 89 7979 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7062 72 7965 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7081 89 7981 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1
execute in minecraft:overworld if data block -7021 77 7973 Items[{id:"minecraft:pumpkin_pie"}] run scoreboard players add data pumpkin_counter 1

scoreboard players operation count_pies pumpkin_counter = max pumpkin_counter
scoreboard players operation count_pies pumpkin_counter -= data pumpkin_counter
scoreboard players operation data pumpkin_counter -= target pumpkin_counter
execute store result bossbar minecraft:bb1 value run scoreboard players get data pumpkin_counter

execute if score end pumpkin_counter = false pumpkin_counter if score data pumpkin_counter = false pumpkin_counter run function trackbreak:gameplay/start_phase_two
scoreboard players set data pumpkin_counter 0