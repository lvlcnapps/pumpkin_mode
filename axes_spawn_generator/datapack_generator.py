#!/usr/bin/env python3
"""
Generator for Minecraft datapack code to spawn axes at non-adjacent locations.
Reads CSV adjacency matrix and generates functions for distributed axe spawning.
"""

import csv
import random
from typing import List, Dict, Set, Tuple


DEBUG_MODE_OFF = 'off'
DEBUG_MODE_BRIEF = 'brief'
DEBUG_MODE_ALL = 'all'


def normalize_debug_mode(debug_mode: str) -> str:
    """
    Normalize configured debug mode and validate supported values.
    """
    normalized_mode = debug_mode.strip().lower()
    valid_modes = {DEBUG_MODE_OFF, DEBUG_MODE_BRIEF, DEBUG_MODE_ALL}
    if normalized_mode not in valid_modes:
        raise ValueError(
            f"Unsupported debug mode '{debug_mode}'. Expected one of: {', '.join(sorted(valid_modes))}"
        )
    return normalized_mode


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
                                     output_dir: str, debug_mode: str = DEBUG_MODE_OFF):
    """
    Generate functions to spawn axe at specific locations.
    Each function checks if location is available, spawns axe, and marks area unavailable.
    """
    debug_mode = normalize_debug_mode(debug_mode)

    for loc in locations:
        if loc not in coordinates:
            print(f"Warning: No coordinates found for {loc}")
            continue
        
        x, y, z = coordinates[loc]
        safe_loc = loc.replace(' ', '_').replace('-', '_')
        
        content = [
            f"# Attempt to spawn axe at {loc}",
        ]
        
        if debug_mode == DEBUG_MODE_ALL:
            content.append(f"tellraw @a [{{\"text\":\"[DEBUG] \",\"color\":\"gray\"}},{{\"text\":\"Trying to spawn axe at {loc}...\",\"color\":\"white\"}}]")
        
        content.extend([
            f"execute if score {loc} axe_available matches 1 run summon minecraft:interaction {x} {y} {z} {{Tags:[\"get_axe\"]}}",
            f"execute if score {loc} axe_available matches 1 run summon item_display {x} {y+0.5} {z} {{Tags:[\"axe_pickup_display\"],item:{{id:\"minecraft:iron_axe\"}},transformation:{{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}}}",
            f"execute if score {loc} axe_available matches 1 run summon minecraft:text_display {x} {y+1} {z} {{text:[\"\",{{color:\"#ffff55\",text:\"Нажми \"}},{{color:\"#55ff55\",text:\"[ПКМ]\"}},\"\\nчтобы забрать\\n\",{{color:\"#55ffff\",text:\"топор\"}}],billboard:center,Tags:[\"axe_pickup_text\"]}}",
        ])
        
        if debug_mode in {DEBUG_MODE_BRIEF, DEBUG_MODE_ALL}:
            content.append(f"execute if score {loc} axe_available matches 1 run tellraw @a [{{\"text\":\"[DEBUG] \",\"color\":\"gray\"}},{{\"text\":\"✓ Successfully spawned axe at {loc} \",\"color\":\"green\"}},{{\"text\":\"({x}, {y}, {z})\",\"color\":\"aqua\"}}]")
        if debug_mode == DEBUG_MODE_ALL:
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
    Uses Minecraft's native random command.
    """
    content = [
        f"# Pick a random location index from 0 to {len(locations) - 1}",
        f"execute store result score #result random run random value 0..{len(locations) - 1}",
        "",
        "# Try to spawn at randomly selected location",
    ]
    
    for i, loc in enumerate(locations):
        safe_loc = loc.replace(' ', '_').replace('-', '_')
        content.append(f"execute if score #result random matches {i} run function trackbreak:spawn_axes/spawn_at_{safe_loc}")
    
    with open(f"{output_dir}/try_spawn.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_main_spawn_function(output_dir: str):
    """
    Generate main function that spawns axes until dynamic target is reached.
    Target and max attempts are read from scoreboard values prepared in start function.
    """
    content = [
        "# Main function to spawn target number of axes",
        "# Will attempt up to max_spawn_attempts (computed from axes_count * 10)",
        "",
        "# Check if we've spawned enough axes",
        "execute if score axes_spawned axe_counter >= axes_target axe_counter run return 1",
        "",
        "# Check if we've exceeded max attempts",
        "execute if score spawn_attempts axe_counter >= max_spawn_attempts axe_counter run say Failed to spawn all axes - not enough valid locations",
        "execute if score spawn_attempts axe_counter >= max_spawn_attempts axe_counter run return 0",
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


def generate_retry_spawn_function(output_dir: str, debug_mode: str = DEBUG_MODE_OFF):
    """
    Generate retry wrapper around spawn_axes_main.
    Retries full spawn process up to 10 times if target was not reached.
    """
    debug_mode = normalize_debug_mode(debug_mode)

    content = [
        "# Retry full spawn process until target is reached",
        "# Hard limit: 10 retries",
        "",
        "# Success condition",
        "execute if score axes_spawned axe_counter >= axes_target axe_counter run return 1",
        "",
        "# Stop when retry limit is reached",
        "execute if score spawn_retries axe_counter matches 10.. run say Failed to spawn all axes after 10 retries",
        "execute if score spawn_retries axe_counter matches 10.. run return 0",
        "",
        "# Start next retry attempt",
        "scoreboard players add spawn_retries axe_counter 1",
    ]

    if debug_mode == DEBUG_MODE_ALL:
        content.append("tellraw @a [{\"text\":\"[DEBUG] \",\"color\":\"gray\"},{\"text\":\"Retry attempt #\",\"color\":\"yellow\"},{\"score\":{\"name\":\"spawn_retries\",\"objective\":\"axe_counter\"},\"color\":\"aqua\"}]")

    content.extend([
        "function trackbreak:spawn_axes/init_axe_spawns",
        "scoreboard players set spawn_attempts axe_counter 0",
        "function trackbreak:spawn_axes/spawn_axes_main",
        "",
        "# Continue retry loop if still not enough axes",
        "function trackbreak:spawn_axes/retry_spawn",
    ])

    with open(f"{output_dir}/retry_spawn.mcfunction", 'w') as f:
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
        "scoreboard players set #10 constants 10",
    ]
    
    with open(f"{output_dir}/setup.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def generate_start_function(output_dir: str, debug_mode: str = DEBUG_MODE_OFF):
    """
    Generate convenience function to start the spawn process.
    """
    debug_mode = normalize_debug_mode(debug_mode)

    content = [
        "# Start spawning axes using scoreboard value axes_count in pumpkin_counter",
        "scoreboard players operation axes_target axe_counter = axes_count pumpkin_counter",
        "scoreboard players operation max_spawn_attempts axe_counter = axes_target axe_counter",
        "scoreboard players operation max_spawn_attempts axe_counter *= #10 constants",
        "scoreboard players set spawn_retries axe_counter 0",
    ]
    
    if debug_mode == DEBUG_MODE_ALL:
        content.append("tellraw @a [{\"text\":\"[DEBUG] \",\"color\":\"gray\"},{\"text\":\"Starting axe spawn process for target: \",\"color\":\"yellow\"},{\"score\":{\"name\":\"axes_target\",\"objective\":\"axe_counter\"},\"color\":\"aqua\"}]")

    content.extend([
        "# Initialize availability and counters for first attempt",
        "function trackbreak:spawn_axes/init_axe_spawns",
        "scoreboard players set spawn_attempts axe_counter 0",
        "function trackbreak:spawn_axes/spawn_axes_main",
        "",
        "# Retry if first attempt did not reach target",
        "function trackbreak:spawn_axes/retry_spawn",
    ])
    
    if debug_mode == DEBUG_MODE_ALL:
        content.append("tellraw @a [{\"text\":\"[DEBUG] \",\"color\":\"gray\"},{\"text\":\"Spawned \",\"color\":\"yellow\"},{\"score\":{\"name\":\"axes_spawned\",\"objective\":\"axe_counter\"},\"color\":\"green\"},{\"text\":\" axes after retries: \",\"color\":\"yellow\"},{\"score\":{\"name\":\"spawn_retries\",\"objective\":\"axe_counter\"},\"color\":\"aqua\"}]")
    else:
        content.append("tellraw @a [{\"text\":\"Spawned axes: \",\"extra\":[{\"score\":{\"name\":\"axes_spawned\",\"objective\":\"axe_counter\"}}]},{\"text\":\" (retries: \",\"color\":\"gray\"},{\"score\":{\"name\":\"spawn_retries\",\"objective\":\"axe_counter\"},\"color\":\"gray\"},{\"text\":\")\",\"color\":\"gray\"}]")
    
    with open(f"{output_dir}/start_spawn.mcfunction", 'w') as f:
        f.write('\n'.join(content))


def main():
    """
    Main function to generate all datapack functions.
    """
    # ==================== CONFIGURATION ====================
    # Input files
    csv_file = 'proximity_graph_igor_new.csv'  # or 'proximity_graph_threshold.csv'
    coords_file = 'axe_locations.tmp'
    
    # Output directory (datapack function folder)
    output_directory = '../pumpkin_mode/data/trackbreak/function/spawn_axes'
    
    # Spawn settings are now dynamic:
    # axes_count in pumpkin_counter defines how many axes to spawn
    
    # Debug mode options: 'off', 'brief', 'all'
    #  - off: disable debug messages
    #  - brief: log only successful spawn attempts
    #  - all: verbose logs for start, retries, successes, and failed attempts
    debug_mode = DEBUG_MODE_OFF
    # =======================================================

    debug_mode = normalize_debug_mode(debug_mode)
    
    import os
    os.makedirs(output_directory, exist_ok=True)
    
    print(f"Reading adjacency matrix from {csv_file}...")
    locations, adjacency = parse_csv_adjacency(csv_file)
    print(f"Found {len(locations)} locations")
    
    print(f"\nReading coordinates from {coords_file}...")
    coordinates = parse_coordinates(coords_file)
    print(f"Found {len(coordinates)} coordinate entries")
    
    print(f"\nGenerating datapack functions to {output_directory}/...")
    print(f"Debug mode: {debug_mode.upper()}")
    
    print("  - setup.mcfunction")
    generate_setup_function(output_directory)
    
    print("  - init_axe_spawns.mcfunction")
    generate_init_function(locations, output_directory)
    
    print(f"  - {len(locations)} mark_unavailable_*.mcfunction files")
    generate_adjacency_data(locations, adjacency, output_directory)
    
    print(f"  - {len(locations)} spawn_at_*.mcfunction files")
    generate_spawn_location_functions(locations, coordinates, output_directory, debug_mode)
    
    print("  - try_spawn.mcfunction")
    generate_random_spawn_function(locations, output_directory)
    
    print("  - spawn_axes_main.mcfunction")
    generate_main_spawn_function(output_directory)

    print("  - retry_spawn.mcfunction")
    generate_retry_spawn_function(output_directory, debug_mode)
    
    print("  - start_spawn.mcfunction")
    generate_start_function(output_directory, debug_mode)
    
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
    print("  - Target axes: scoreboard player axes_count in objective pumpkin_counter")
    print("  - Max attempts: target * 10")
    print(f"  - Debug mode: {debug_mode}")
    print(f"\nTo use in Minecraft:")
    print(f"1. Run once: /function trackbreak:spawn_axes/setup")
    print(f"2. Set target: /scoreboard players set axes_count pumpkin_counter <count>")
    print(f"3. To spawn axes: /function trackbreak:spawn_axes/start_spawn")
    print(f"\nConfiguration:")
    print(f"  - Input CSV: {csv_file}")
    print(f"  - Locations: {len(locations)}")
    print("  - Target axes: scoreboard player axes_count in objective pumpkin_counter")
    print("  - Max attempts: target * 10")
    print(f"  - Debug mode: {debug_mode}")


if __name__ == "__main__":
    main()
