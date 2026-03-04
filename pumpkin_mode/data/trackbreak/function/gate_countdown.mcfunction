execute if score gate_countdown gate_counter matches 60 run title @a title {"text":"3","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 40 run title @a title {"text":"2","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 20 run title @a title {"text":"1","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 0 run title @a title {"text":"Go!","color":"yellow","bold":true}
execute if score gate_countdown gate_counter matches 0 run scoreboard players set gate_state gate_counter 2
scoreboard players remove gate_countdown gate_counter 1