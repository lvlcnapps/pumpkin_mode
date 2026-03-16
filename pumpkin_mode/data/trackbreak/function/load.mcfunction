scoreboard objectives add pumpkin_breaks minecraft.mined:minecraft.pumpkin
scoreboard players set @a pumpkin_breaks 0
scoreboard players set @a is_mirroring 0

# Initialize out of map counter
scoreboard objectives add outbound_counter dummy
scoreboard objectives add outbound_last dummy

say "Pumpkin Mode! ver 1.1"