#!/usr/bin/env python3
"""
Generator for Minecraft datapack code to spawn axes at non-adjacent locations.
Reads CSV adjacency matrix and generates functions for distributed axe spawning.
"""

import csv
import random
from typing import List, Dict, Set, Tuple


def parse_csv_adjacency(csv_filepath: str) -> Tuple[List[str], Dict[str, Set[str]]]:
    """
    Parse CSV adjacency matrix to get locations and their adjacencies.
    
    Args:
        csv_filepath: Path to the CSV file with adjacency matrix
        
    Returns:
        Tuple of (location_names, adjacency_dict)
        adjacency_dict maps location_name -> set of adjacent location names
    """
    locations = []
    adjacency = {}
    
    with open(csv_filepath, 'r') as f:
        reader = csv.reader(f)
        header = next(reader)
        locations = header[1:]  # Skip first empty column
        
        for row in reader:
            if not row:
                continue
            location = row[0]
            adjacency[location] = set()
            
            for i, cell in enumerate(row[1:], 0):
                if cell.strip().upper() == 'X':
                    adjacency[location].add(locations[i])
    
    return locations, adjacency


def parse_coordinates(filepath: str) -> Dict[str, Tuple[int, int, int]]:
    """
    Parse coordinate file and return mapping of location name to coordinates.
    
    Args:
        filepath: Path to the file containing tag coordinates
        
    Returns:
        Dictionary mapping location name to (x, y, z) coordinates
    """
    coordinates = {}
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split()
            if len(parts) >= 4:
                tag_name = parts[0]
                x, y, z = int(float(parts[1])), int(float(parts[2])), int(float(parts[3]))
                coordinates[tag_name] = (x, y, z)
    return coordinates


def generate_init_function(locations: List[str], output_dir: str):
    """
    Generate function to initialize availability mask.
    All locations start as available (value=1).
    """
    content = [
        "# Initialize availability mask for axe spawn locations",
        "# 1 = available, 0 = unavailable",
        ""
    ]
    
    for loc in locations:
        content.append(f"scoreboard players set {loc} axe_available 1")
    
    content.append("")
    content.append("# Reset spawn counter")
    content.append("scoreboard players set axes_spawned axe_counter 0")
    
    with open(f"{output_dir}/init_axe_spawns.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_adjacency_data(locations: List[str], adjacency: Dict[str, Set[str]], output_dir: str):
    """
    Generate function that marks a location and its adjacent locations as unavailable.
    Creates one function per location.
    """
    for loc in locations:
        content = [
            f"# Mark {loc} and adjacent locations as unavailable",
            f"scoreboard players set {loc} axe_available 0",
            ""
        ]
        
        if loc in adjacency and adjacency[loc]:
            content.append(f"# Mark adjacent locations")
            for adj_loc in sorted(adjacency[loc]):
                content.append(f"scoreboard players set {adj_loc} axe_available 0")
        
        # Clean location name for filename (replace spaces with underscores)
        safe_loc = loc.replace(' ', '_').replace('-', '_')
        with open(f"{output_dir}/mark_unavailable_{safe_loc}.mcfunction", 'w') as f:
            f.write('\n'.join(content))


def generate_spawn_location_functions(locations: List[str], coordinates: Dict[str, Tuple[int, int, int]], 
                                     output_dir: str, debug_enabled: bool = False):
    """
    Generate functions to spawn axe at specific locations.
    Each function checks if location is available, spawns axe, and marks area unavailable.
    """
    for loc in locations:
        if loc not in coordinates:
            print(f"Warning: No coordinates found for {loc}")
            continue
        
        x, y, z = coordinates[loc]
        safe_loc = loc.replace(' ', '_').replace('-', '_')
        
        content = [
            f"# Attempt to spawn axe at {loc}",
        ]
        
        if debug_enabled:
            content.append(f"tellraw @a [{{\"text\":\"[DEBUG] \",\"color\":\"gray\"}},{{\"text\":\"Trying to spawn axe at {loc}...\",\"color\":\"white\"}}]")
        
        content.extend([
            f"execute if score {loc} axe_available matches 1 run summon minecraft:interaction {x} {y} {z} {{Tags:[\"get_axe\"]}}",
            f"execute if score {loc} axe_available matches 1 run summon item_display {x} {y+0.5} {z} {{Tags:[\"axe_pickup_display\"],item:{{id:\"minecraft:iron_axe\"}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}}}",
            f"execute if score {loc} axe_available matches 1 run summon minecraft:text_display {x} {y+1} {z} {{text:[\"\",{{color:\"#ffff55\",text:\"Нажми \"}},{{color:\"#55ff55\",text:\"[ПКМ]\"}},\"\\nчтобы забрать\\n\",{{color:\"#55ffff\",text:\"топор\"}}],billboard:center,Tags:[\"axe_pickup_text\"]}}",
        ])
        
        if debug_enabled:
            content.append(f"execute if score {loc} axe_available matches 1 run tellraw @a [{{\"text\":\"[DEBUG] \",\"color\":\"gray\"}},{{\"text\":\"✓ Successfully spawned axe at {loc} \",\"color\":\"green\"}},{{\"text\":\"({x}, {y}, {z})\",\"color\":\"aqua\"}}]")
            content.append(f"execute if score {loc} axe_available matches 0 run tellraw @a [{{\"text\":\"[DEBUG] \",\"color\":\"gray\"}},{{\"text\":\"✗ Location {loc} unavailable\",\"color\":\"red\"}}]")
        
        content.extend([
            f"execute if score {loc} axe_available matches 1 run scoreboard players add axes_spawned axe_counter 1",
            f"execute if score {loc} axe_available matches 1 run function trackbreak:spawn_axes/mark_unavailable_{safe_loc}",
        ])
        
        with open(f"{output_dir}/spawn_at_{safe_loc}.mcfunction", 'w') as f:
            f.write('\n'.join(content))


def generate_random_spawn_function(locations: List[str], output_dir: str):
    """
    Generate function that randomly picks a location and tries to spawn an axe.
    Uses Minecraft's random number generation.
    """
    content = [
        "# Generate random number from 0 to N-1 where N is number of locations",
        f"scoreboard players set #max random {len(locations)}",
        "function trackbreak:spawn_axes/random_number",
        "",
        "# Try to spawn at randomly selected location",
    ]
    
    for i, loc in enumerate(locations):
        safe_loc = loc.replace(' ', '_').replace('-', '_')
        content.append(f"execute if score #result random matches {i} run function trackbreak:spawn_axes/spawn_at_{safe_loc}")
    
    with open(f"{output_dir}/try_spawn.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_random_number_function(output_dir: str):
    """
    Generate helper function for random number generation.
    Uses UUID for randomness.
    """
    content = [
        "# Generate random number between 0 and #max",
        "summon minecraft:area_effect_cloud ~ ~ ~ {Tags:[\"random_uuid\"]}",
        "execute store result score #result random run data get entity @e[type=minecraft:area_effect_cloud,tag=random_uuid,limit=1] UUID[0]",
        "kill @e[type=minecraft:area_effect_cloud,tag=random_uuid]",
        "scoreboard players operation #result random %= #max random",
        "# Make result positive if negative",
        "execute if score #result random matches ..-1 run scoreboard players operation #result random *= #-1 constants",
    ]
    
    with open(f"{output_dir}/random_number.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_main_spawn_function(target_axes: int, output_dir: str):
    """
    Generate main function that spawns specified number of axes.
    Iteratively tries to spawn until target is reached or max attempts exceeded.
    """
    content = [
        f"# Main function to spawn {target_axes} axes",
        f"# Will attempt up to {target_axes * 10} times",
        "",
        "# Check if we've spawned enough axes",
        f"execute if score axes_spawned axe_counter matches {target_axes}.. run return 1",
        "",
        "# Check if we've exceeded max attempts",
        f"execute if score spawn_attempts axe_counter matches {target_axes * 10}.. run say Failed to spawn all axes - not enough valid locations",
        f"execute if score spawn_attempts axe_counter matches {target_axes * 10}.. run return 0",
        "",
        "# Try to spawn an axe",
        "scoreboard players add spawn_attempts axe_counter 1",
        "function trackbreak:spawn_axes/try_spawn",
        "",
        "# Recursively call until target reached",
        "function trackbreak:spawn_axes/spawn_axes_main",
    ]
    
    with open(f"{output_dir}/spawn_axes_main.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_setup_function(output_dir: str):
    """
    Generate setup function to create scoreboards.
    """
    content = [
        "# Setup scoreboards for axe spawning system",
        "scoreboard objectives add axe_available dummy",
        "scoreboard objectives add axe_counter dummy",
        "scoreboard objectives add random dummy",
        "scoreboard objectives add constants dummy",
        "",
        "# Set constants",
        "scoreboard players set #-1 constants -1",
    ]
    
    with open(f"{output_dir}/setup.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_start_function(target_axes: int, output_dir: str, debug_enabled: bool = False):
    """
    Generate convenience function to start the spawn process.
    """
    content = [
        f"# Start spawning {target_axes} axes",
        "function trackbreak:spawn_axes/init_axe_spawns",
        "scoreboard players set spawn_attempts axe_counter 0",
    ]
    
    if debug_enabled:
        content.append("tellraw @a [{\"text\":\"[DEBUG] \",\"color\":\"gray\"},{\"text\":\"Starting axe spawn process...\",\"color\":\"yellow\"}]")
    
    content.extend([
        "function trackbreak:spawn_axes/spawn_axes_main",
    ])
    
    if debug_enabled:
        content.append("tellraw @a [{\"text\":\"[DEBUG] \",\"color\":\"gray\"},{\"text\":\"Spawned \",\"color\":\"yellow\"},{\"score\":{\"name\":\"axes_spawned\",\"objective\":\"axe_counter\"},\"color\":\"green\"},{\"text\":\" axes in \",\"color\":\"yellow\"},{\"score\":{\"name\":\"spawn_attempts\",\"objective\":\"axe_counter\"},\"color\":\"aqua\"},{\"text\":\" attempts\",\"color\":\"yellow\"}]")
    else:
        content.append("tellraw @a [{\"text\":\"Spawned axes: \",\"extra\":[{\"score\":{\"name\":\"axes_spawned\",\"objective\":\"axe_counter\"}}]}]")
    
    with open(f"{output_dir}/start_spawn.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def main():
    """
    Main function to generate all datapack functions.
    """
    # ==================== CONFIGURATION ====================
    # Input files
    csv_file = 'proximity_graph.csv'  # or 'proximity_graph_threshold.csv'
    coords_file = 'axe_locations.tmp'
    
    # Output directory (datapack function folder)
    output_directory = '../pumpkin_mode/data/trackbreak/function/spawn_axes'
    
    # Spawn settings
    target_axes_count = 5  # Number of axes to spawn
    
    # Debug mode - shows detailed spawn messages
    debug_enabled = True  # Set to False to disable debug messages
    # =======================================================
    
    import os
    os.makedirs(output_directory, exist_ok=True)
    
    print(f"Reading adjacency matrix from {csv_file}...")
    locations, adjacency = parse_csv_adjacency(csv_file)
    print(f"Found {len(locations)} locations")
    
    print(f"\nReading coordinates from {coords_file}...")
    coordinates = parse_coordinates(coords_file)
    print(f"Found {len(coordinates)} coordinate entries")
    
    print(f"\nGenerating datapack functions to {output_directory}/...")
    print(f"Debug mode: {'ENABLED' if debug_enabled else 'DISABLED'}")
    
    print("  - setup.mcfunction")
    generate_setup_function(output_directory)
    
    print("  - init_axe_spawns.mcfunction")
    generate_init_function(locations, output_directory)
    
    print(f"  - {len(locations)} mark_unavailable_*.mcfunction files")
    generate_adjacency_data(locations, adjacency, output_directory)
    
    print(f"  - {len(locations)} spawn_at_*.mcfunction files")
    generate_spawn_location_functions(locations, coordinates, output_directory, debug_enabled)
    
    print("  - random_number.mcfunction")
    generate_random_number_function(output_directory)
    
    print("  - try_spawn.mcfunction")
    generate_random_spawn_function(locations, output_directory)
    
    print("  - spawn_axes_main.mcfunction")
    generate_main_spawn_function(target_axes_count, output_directory)
    
    print("  - start_spawn.mcfunction")
    generate_start_function(target_axes_count, output_directory, debug_enabled)
    
    print(f"\n{'='*70}")
    print("Done! Generated all datapack functions.")
    print(f"{'='*70}")
    print(f"\nFunctions generated in:")
    print(f"  {output_directory}")
    print(f"\nTo use in Minecraft:")
    print(f"  1. Run once: /function trackbreak:spawn_axes/setup")
    print(f"  2. To spawn axes: /function trackbreak:spawn_axes/start_spawn")
    print(f"\nConfiguration:")
    print(f"  - Input CSV: {csv_file}")
    print(f"  - Locations: {len(locations)}")
    print(f"  - Target axes: {target_axes_count}")
    print(f"  - Max attempts: {target_axes_count * 10}")
    print(f"  - Debug mode: {'ENABLED' if debug_enabled else 'DISABLED'}")
    print(f"\nTo use in Minecraft:")
    print(f"1. Run once: /function trackbreak:spawn_axes/setup")
    print(f"2. To spawn axes: /function trackbreak:spawn_axes/start_spawn")
    print(f"\nConfiguration:")
    print(f"  - Input CSV: {csv_file}")
    print(f"  - Locations: {len(locations)}")
    print(f"  - Target axes: {target_axes_count}")
    print(f"  - Max attempts: {target_axes_count * 10}")


if __name__ == "__main__":
    main()
