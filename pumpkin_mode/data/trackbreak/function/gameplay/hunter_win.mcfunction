scoreboard players set win_type pumpkin_counter 0

function trackbreak:logger/log_current

scoreboard players set end pumpkin_counter 1

title @a title {"text":"Победа Хантера!","color":"red"}

schedule function trackbreak:gameplay/restart_game 5s