# State of the gate. Needed to track that all players have reached the gate
# before starting the game. 
# 0 - init, inner gate closed, outer open
# 1 - all players in the gate, countdown started, inner gate closed, outer closed
# 2 - countdown timeout, inner gate open, outer closed
# 3 - all players left the gate, all gates closed
scoreboard objectives add gate_counter dummy
scoreboard players set gate_state gate_counter 0
scoreboard players set gate_countdown gate_counter 60
# close inner gate
fill -7062 76 7937 -7059 77 7937 minecraft:iron_bars
# open outer gate
fill -7060 76 7932 -7061 77 7932 minecraft:air

# "Waiting for" sidabar
scoreboard objectives add gate_waiting_players dummy {"text":"Waiting:","color":"red"}
scoreboard objectives setdisplay sidebar gate_waiting_players