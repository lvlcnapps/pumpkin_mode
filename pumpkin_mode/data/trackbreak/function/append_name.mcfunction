data modify block -7055 98 7879 front_text.messages set value [[{"selector":"@p[tag=!oct_hunter,scores={logged=0}]"}],"","",""]
scoreboard players set @p[tag=!oct_hunter,scores={logged=0}] logged 1
data modify storage stats:database current_game.gnomes append from block -7055 98 7879 front_text.messages[0].extra[1]