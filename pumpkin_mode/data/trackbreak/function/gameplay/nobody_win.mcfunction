scoreboard players set win_type pumpkin_counter 2

function trackbreak:logger/log_current

scoreboard players set end pumpkin_counter 1

title @a title {"text":"Никто не победил!","color":"red"}

schedule function trackbreak:gameplay/restart_game 5s