#!/usr/bin/env python3
"""
Script to parse 3D coordinates and create a proximity-based graph.
Outputs the graph as an adjacency matrix in CSV format.
"""

import csv
import math
from typing import List, Tuple, Dict


def parse_coordinates(filepath: str) -> List[Tuple[str, Tuple[float, float, float]]]:
    """
    Parse the coordinate file and return a list of (tag_name, (x, y, z)) tuples.
    
    Args:
        filepath: Path to the file containing tag coordinates
        
    Returns:
        List of tuples containing tag names and their 3D coordinates
    """
    coordinates = []
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split()
            if len(parts) >= 4:
                tag_name = parts[0]
                x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
                coordinates.append((tag_name, (x, y, z)))
    return coordinates


def euclidean_distance(point1: Tuple[float, float, float], 
                       point2: Tuple[float, float, float]) -> float:
    """
    Calculate the Euclidean distance between two 3D points.
    
    Args:
        point1: First point (x, y, z)
        point2: Second point (x, y, z)
        
    Returns:
        Euclidean distance between the points
    """
    return math.sqrt(
        (point1[0] - point2[0])**2 + 
        (point1[1] - point2[1])**2 + 
        (point1[2] - point2[2])**2
    )


def create_proximity_graph(coordinates: List[Tuple[str, Tuple[float, float, float]]], 
                          threshold: float) -> List[List[bool]]:
    """
    Create a proximity-based graph using a distance threshold.
    
    Args:
        coordinates: List of (tag_name, (x, y, z)) tuples
        threshold: Maximum distance for two vertices to be connected
        
    Returns:
        Adjacency matrix as a 2D list of booleans
    """
    n = len(coordinates)
    adjacency_matrix = [[False] * n for _ in range(n)]
    
    for i in range(n):
        for j in range(i + 1, n):  # Only calculate upper triangle (undirected graph)
            dist = euclidean_distance(coordinates[i][1], coordinates[j][1])
            if dist <= threshold:
                adjacency_matrix[i][j] = True
                adjacency_matrix[j][i] = True  # Symmetric for undirected graph
    
    return adjacency_matrix


def create_knn_graph(coordinates: List[Tuple[str, Tuple[float, float, float]]], 
                     k: int) -> List[List[bool]]:
    """
    Create a graph using k-nearest neighbors algorithm.
    Each vertex connects to its k nearest neighbors.
    
    Args:
        coordinates: List of (tag_name, (x, y, z)) tuples
        k: Number of nearest neighbors to connect to each vertex
        
    Returns:
        Adjacency matrix as a 2D list of booleans
    """
    n = len(coordinates)
    adjacency_matrix = [[False] * n for _ in range(n)]
    k = min(k, n - 1)  # Ensure k doesn't exceed available vertices
    
    for i in range(n):
        # Calculate distances from vertex i to all other vertices
        distances = []
        for j in range(n):
            if i != j:
                dist = euclidean_distance(coordinates[i][1], coordinates[j][1])
                distances.append((dist, j))
        
        # Sort by distance and get k nearest neighbors
        distances.sort()
        for _, j in distances[:k]:
            adjacency_matrix[i][j] = True
            adjacency_matrix[j][i] = True  # Make it symmetric for undirected graph
    
    return adjacency_matrix


def export_graph_to_csv(coordinates: List[Tuple[str, Tuple[float, float, float]]], 
                       adjacency_matrix: List[List[bool]], 
                       output_filepath: str):
    """
    Export the adjacency matrix to a CSV file with 'X' for connections.
    
    Args:
        coordinates: List of (tag_name, (x, y, z)) tuples
        adjacency_matrix: Adjacency matrix as a 2D list of booleans
        output_filepath: Path to the output CSV file
    """
    tag_names = [coord[0] for coord in coordinates]
    
    with open(output_filepath, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        
        # Write header row
        writer.writerow([''] + tag_names)
        
        # Write data rows
        for i, tag_name in enumerate(tag_names):
            row = [tag_name]
            for j in range(len(tag_names)):
                if adjacency_matrix[i][j]:
                    row.append('X')
                else:
                    row.append('')
            writer.writerow(row)


def export_graph_to_dot(coordinates: List[Tuple[str, Tuple[float, float, float]]], 
                        adjacency_matrix: List[List[bool]], 
                        output_filepath: str):
    """
    Export the graph to DOT format (Graphviz).
    
    Args:
        coordinates: List of (tag_name, (x, y, z)) tuples
        adjacency_matrix: Adjacency matrix as a 2D list of booleans
        output_filepath: Path to the output DOT file
    """
    tag_names = [coord[0] for coord in coordinates]
    
    with open(output_filepath, 'w') as dotfile:
        dotfile.write("graph proximity_graph {\n")
        dotfile.write("  rankdir=LR;\n")
        dotfile.write("  node [shape=box, style=rounded];\n\n")
        
        # Write nodes
        for i, tag_name in enumerate(tag_names):
            x, y, z = coordinates[i][1]
            label = f"{tag_name}\\n({x:.0f}, {y:.0f}, {z:.0f})"
            dotfile.write(f'  "{tag_name}" [label="{label}"];\n')
        
        dotfile.write("\n")
        
        # Write edges (only once for undirected graph)
        edges_written = set()
        for i in range(len(tag_names)):
            for j in range(i + 1, len(tag_names)):
                if adjacency_matrix[i][j]:
                    edge_key = tuple(sorted([tag_names[i], tag_names[j]]))
                    if edge_key not in edges_written:
                        dotfile.write(f'  "{tag_names[i]}" -- "{tag_names[j]}";\n')
                        edges_written.add(edge_key)
        
        dotfile.write("}\n")


def main():
    """
    Main function to parse coordinates, create graph, and export to CSV and DOT formats.
    Supports both threshold-based and k-nearest neighbors approaches.
    """
    # Configuration
    input_file = 'axe_locations.tmp'
    
    # Choose between two modes:
    # MODE 1: Distance threshold
    use_threshold_mode = True
    threshold = 20.0  # Distance threshold for connections
    
    # MODE 2: K-nearest neighbors
    use_knn_mode = True
    k_neighbors = 5  # Number of nearest neighbors
    
    print(f"Parsing coordinates from {input_file}...")
    coordinates = parse_coordinates(input_file)
    print(f"Found {len(coordinates)} locations")
    
    # --- THRESHOLD MODE ---
    if use_threshold_mode:
        print(f"\n{'='*60}")
        print(f"THRESHOLD MODE (threshold={threshold})")
        print(f"{'='*60}")
        
        adjacency_matrix = create_proximity_graph(coordinates, threshold)
        total_connections = sum(sum(row) for row in adjacency_matrix) // 2
        
        csv_output = 'proximity_graph_threshold.csv'
        dot_output = 'proximity_graph_threshold.dot'
        
        print(f"Created {total_connections} connections")
        print(f"Exporting to {csv_output}...")
        export_graph_to_csv(coordinates, adjacency_matrix, csv_output)
        print(f"Exporting to {dot_output}...")
        export_graph_to_dot(coordinates, adjacency_matrix, dot_output)
        
        print(f"\nThreshold Mode Statistics:")
        print(f"  Vertices: {len(coordinates)}")
        print(f"  Edges: {total_connections}")
        print(f"  Threshold: {threshold}")
        print(f"  Average connections per vertex: {total_connections * 2 / len(coordinates):.2f}")
    
    # --- K-NEAREST NEIGHBORS MODE ---
    if use_knn_mode:
        print(f"\n{'='*60}")
        print(f"K-NEAREST NEIGHBORS MODE (k={k_neighbors})")
        print(f"{'='*60}")
        
        adjacency_matrix = create_knn_graph(coordinates, k_neighbors)
        total_connections = sum(sum(row) for row in adjacency_matrix) // 2
        
        csv_output = 'proximity_graph_knn.csv'
        dot_output = 'proximity_graph_knn.dot'
        
        print(f"Created {total_connections} connections")
        print(f"Exporting to {csv_output}...")
        export_graph_to_csv(coordinates, adjacency_matrix, csv_output)
        print(f"Exporting to {dot_output}...")
        export_graph_to_dot(coordinates, adjacency_matrix, dot_output)
        
        print(f"\nK-NN Mode Statistics:")
        print(f"  Vertices: {len(coordinates)}")
        print(f"  Edges: {total_connections}")
        print(f"  K (nearest neighbors): {k_neighbors}")
        print(f"  Average connections per vertex: {total_connections * 2 / len(coordinates):.2f}")
    
    print(f"\n{'='*60}")
    print("Done!")
    print(f"{'='*60}")


if __name__ == "__main__":
    main()
