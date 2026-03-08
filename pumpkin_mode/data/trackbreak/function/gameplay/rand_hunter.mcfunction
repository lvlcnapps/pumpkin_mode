tag @r add chosen_one
effect give @p[tag=chosen_one] minecraft:glowing 3 1 true
title @a title ["Hunter is ",{"selector":"@p[tag=chosen_one]","bold":true,"color":"#ff0000"}]
tag @p[tag=chosen_one] remove chosen_one