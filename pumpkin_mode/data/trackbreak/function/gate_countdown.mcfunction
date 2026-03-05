execute if score gate_countdown gate_counter matches 60 run title @a title {"text":"3","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 40 run title @a title {"text":"2","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 20 run title @a title {"text":"1","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 0 run title @a title {"text":"Go!","color":"yellow","bold":true}

# 1 -> 2 transition: open inner gate
execute if score gate_countdown gate_counter matches 0 run fill -7062 76 7937 -7059 77 7937 minecraft:air
execute if score gate_countdown gate_counter matches 0 run scoreboard players set gate_state gate_counter 2

# decrease countdown
scoreboard players remove gate_countdown gate_counter 1