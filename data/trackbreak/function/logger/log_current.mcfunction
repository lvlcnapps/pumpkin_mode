data modify storage stats:database current_game set value {}

execute store result storage stats:database current_game.log_ver int 1 run scoreboard players get log_ver pumpkin_counter
execute store result storage stats:database current_game.game_id int 1 run scoreboard players get game_id pumpkin_counter
execute store result storage stats:database current_game.max int 1 run scoreboard players get max pumpkin_counter
execute store result storage stats:database current_game.count_pies int 1 run scoreboard players get count_pies pumpkin_counter
execute store result storage stats:database current_game.win_type int 1 run scoreboard players get win_type pumpkin_counter
execute store result storage stats:database current_game.target int 1 run scoreboard players get act_target pumpkin_counter

execute positioned 0 0 0 as @a[tag=!oct_hunter] run function trackbreak:append_name

execute in minecraft:overworld run data modify block -7055 98 7879 front_text.messages set value [[{"selector":"@p[tag=oct_hunter]"}],"","",""]
data modify storage stats:database current_game.hunter append from block -7055 98 7879 front_text.messages[0].extra[1]

data modify storage stats:database History append from storage stats:database current_game

data remove storage stats:database current_game

scoreboard players set @a logged 0