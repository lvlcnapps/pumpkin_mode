scoreboard players set win_type pumpkin_counter 1

function trackbreak:logger/log_current

scoreboard players set end pumpkin_counter 1

title @a title {"text":"Победа Ботинков!","color":"green"}

scoreboard players add @a[tag=!oct_hunter] stats_total_wins 1
scoreboard players add @a[tag=!oct_hunter] stats_gnome_wins 1

schedule function trackbreak:gameplay/restart_game 5s