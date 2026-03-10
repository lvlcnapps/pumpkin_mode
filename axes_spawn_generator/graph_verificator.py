#!/usr/bin/env python3
"""Exhaustive verifier for axe spawn outcomes on a conflict graph from CSV.

Given an adjacency matrix CSV and a requested number of axes, this script explores
all possible outcomes of the spawn algorithm via recursive search.
"""

import argparse
import csv
import json
from collections import defaultdict
from functools import lru_cache
from typing import Dict, List, Tuple


def iter_set_bits(mask: int):
    """Yield set bit indices in ascending order."""
    while mask:
        lsb = mask & -mask
        yield lsb.bit_length() - 1
        mask ^= lsb


def popcount(x: int) -> int:
    """Return number of set bits."""
    return x.bit_count()


def unique_names_with_mapping(raw_names: List[str]) -> Tuple[List[str], List[str]]:
    """Create unique internal names while preserving base names.

    Example:
      ["ocean_room", "ocean_room"] -> ["ocean_room", "ocean_room#2"]
    """
    counts: Dict[str, int] = defaultdict(int)
    internal = []
    base = []
    for name in raw_names:
        counts[name] += 1
        idx = counts[name]
        if idx == 1:
            internal_name = name
        else:
            internal_name = f"{name}#{idx}"
        internal.append(internal_name)
        base.append(name)
    return internal, base


def parse_csv_graph(csv_path: str) -> Tuple[List[str], List[str], List[int]]:
    """Parse adjacency CSV into internal names, base names, and neighbor bitmasks."""
    with open(csv_path, "r", newline="") as f:
        rows = list(csv.reader(f))

    if not rows:
        raise ValueError("CSV is empty")

    header = rows[0]
    if len(header) < 2:
        raise ValueError("CSV header must contain at least one location column")

    raw_names = header[1:]
    names, base_names = unique_names_with_mapping(raw_names)
    n = len(names)

    if len(rows) - 1 < n:
        raise ValueError(
            f"CSV has {len(rows) - 1} data rows but {n} location columns"
        )

    neighbors = [0] * n

    for i in range(n):
        row = rows[i + 1]
        # Row format: [row_name, cell0, cell1, ...]
        cells = row[1:] if len(row) > 1 else []
        if len(cells) < n:
            cells = cells + [""] * (n - len(cells))
        elif len(cells) > n:
            cells = cells[:n]

        mask = 0
        for j, cell in enumerate(cells):
            if cell.strip().upper() == "X":
                mask |= 1 << j
        neighbors[i] = mask

    # Force undirected symmetry and remove self-edges from neighbor masks.
    for i in range(n):
        for j in range(n):
            ij = (neighbors[i] >> j) & 1
            ji = (neighbors[j] >> i) & 1
            if ij or ji:
                neighbors[i] |= 1 << j
                neighbors[j] |= 1 << i

    for i in range(n):
        neighbors[i] &= ~(1 << i)

    return names, base_names, neighbors


def compute_exact_outcomes(
    neighbors: List[int],
    axes_to_spawn: int,
    include_partials: bool,
) -> Dict[int, int]:
    """Return map: outcome_mask -> number_of_paths_reaching_it.

    outcome_mask contains selected vertices for one terminal result.
    If include_partials=False, only exact-size outcomes (size == axes_to_spawn)
    are returned. If include_partials=True, dead-end partial outcomes are included.
    """
    n = len(neighbors)
    full_available = (1 << n) - 1

    @lru_cache(maxsize=None)
    def dfs(available_mask: int, remaining: int) -> Tuple[Tuple[int, int], ...]:
        if remaining == 0:
            return ((0, 1),)

        if available_mask == 0:
            if include_partials:
                return ((0, 1),)
            return tuple()

        merged: Dict[int, int] = defaultdict(int)

        for v in iter_set_bits(available_mask):
            blocked = (1 << v) | neighbors[v]
            next_available = available_mask & ~blocked
            sub = dfs(next_available, remaining - 1)
            for submask, cnt in sub:
                merged[submask | (1 << v)] += cnt

        if not merged:
            return tuple()
        return tuple(sorted(merged.items()))

    return dict(dfs(full_available, axes_to_spawn))


def max_spawnable_axes(neighbors: List[int]) -> int:
    """Compute maximum independent set size for conflict graph (exact)."""
    n = len(neighbors)
    full_available = (1 << n) - 1

    @lru_cache(maxsize=None)
    def best(available_mask: int) -> int:
        if available_mask == 0:
            return 0

        # Branch on one vertex.
        lsb = available_mask & -available_mask
        v = lsb.bit_length() - 1

        # Option 1: skip v
        skip = best(available_mask & ~(1 << v))

        # Option 2: take v (remove v and its neighbors)
        take_available = available_mask & ~((1 << v) | neighbors[v])
        take = 1 + best(take_available)

        return max(skip, take)

    return best(full_available)


def decode_outcome(mask: int, names: List[str]) -> List[str]:
    """Convert bitmask outcome to sorted list of vertex names."""
    result = [names[i] for i in iter_set_bits(mask)]
    result.sort()
    return result


def compute_room_distribution(neighbors: List[int], axes_to_spawn: int) -> dict:
    """Compute per-room spawn probabilities with retry-on-deadlock semantics.

    Model:
    - At each step, choose uniformly among currently available locations.
    - If deadlock happens before placing all requested axes, that run is discarded.
    - Distribution is conditioned on successful runs that place exactly axes_to_spawn.
    """
    n = len(neighbors)
    full_available = (1 << n) - 1

    @lru_cache(maxsize=None)
    def dp(available_mask: int, remaining: int) -> Tuple[float, Tuple[float, ...]]:
        if remaining == 0:
            return 1.0, tuple(0.0 for _ in range(n))

        choices = list(iter_set_bits(available_mask))
        if not choices:
            return 0.0, tuple(0.0 for _ in range(n))

        p_choice = 1.0 / len(choices)
        success_prob = 0.0
        room_mass = [0.0] * n

        for v in choices:
            blocked = (1 << v) | neighbors[v]
            next_available = available_mask & ~blocked
            child_success, child_mass = dp(next_available, remaining - 1)

            branch_success = p_choice * child_success
            success_prob += branch_success

            # Mass contribution inherited from descendants.
            for i in range(n):
                room_mass[i] += p_choice * child_mass[i]

            # Current selected room contributes whenever this branch succeeds.
            room_mass[v] += branch_success

        return success_prob, tuple(room_mass)

    success_prob, room_mass_uncond = dp(full_available, axes_to_spawn)

    if success_prob == 0.0:
        room_prob = [0.0] * n
    else:
        room_prob = [m / success_prob for m in room_mass_uncond]

    return {
        "success_exact_k": success_prob,
        "room_probability": room_prob,
    }


def run_verification(
    csv_path: str,
    axes_to_spawn: int,
    include_partials: bool,
    compute_distribution: bool,
) -> dict:
    """Run exhaustive verification and return structured results."""
    names, base_names, neighbors = parse_csv_graph(csv_path)

    if axes_to_spawn < 0:
        raise ValueError("axes_to_spawn must be >= 0")

    max_axes = max_spawnable_axes(neighbors)
    outcomes = compute_exact_outcomes(neighbors, axes_to_spawn, include_partials)

    outcomes_by_size: Dict[int, List[dict]] = defaultdict(list)
    for mask, path_count in outcomes.items():
        size = popcount(mask)
        outcomes_by_size[size].append(
            {
                "mask": mask,
                "path_count": path_count,
                "locations": decode_outcome(mask, names),
            }
        )

    for size in outcomes_by_size:
        outcomes_by_size[size].sort(key=lambda x: x["locations"])

    exact_k_count = len(outcomes_by_size.get(axes_to_spawn, []))
    exact_k_paths = sum(x["path_count"] for x in outcomes_by_size.get(axes_to_spawn, []))

    result = {
        "input": {
            "csv_path": csv_path,
            "axes_to_spawn": axes_to_spawn,
            "include_partials": include_partials,
        },
        "graph": {
            "vertex_count": len(names),
            "names": names,
            "base_names": base_names,
            "has_duplicate_base_names": len(set(base_names)) != len(base_names),
        },
        "summary": {
            "max_spawnable_axes": max_axes,
            "exact_k_feasible": axes_to_spawn <= max_axes,
            "exact_k_distinct_outcomes": exact_k_count,
            "exact_k_total_paths": exact_k_paths,
            "sizes_found": sorted(outcomes_by_size.keys()),
        },
        "outcomes_by_size": dict(outcomes_by_size),
    }

    if compute_distribution:
        dist = compute_room_distribution(neighbors, axes_to_spawn)
        result["probability"] = {
            "success_exact_k": dist["success_exact_k"],
            "room_any": {
                names[i]: dist["room_probability"][i] for i in range(len(names))
            },
        }

    return result


def print_summary(result: dict, show_limit: int, show_distribution: bool, top_rooms: int):
    """Print compact human-readable summary."""
    info = result["input"]
    graph = result["graph"]
    summary = result["summary"]

    print("Verification summary")
    print(f"  CSV: {info['csv_path']}")
    print(f"  Requested axes: {info['axes_to_spawn']}")
    print(f"  Include partials: {info['include_partials']}")
    print(f"  Vertices: {graph['vertex_count']}")
    print(f"  Duplicate base names: {graph['has_duplicate_base_names']}")
    print(f"  Max spawnable axes: {summary['max_spawnable_axes']}")
    print(f"  Exact-k feasible: {summary['exact_k_feasible']}")
    print(f"  Exact-k distinct outcomes: {summary['exact_k_distinct_outcomes']}")
    print(f"  Exact-k total paths: {summary['exact_k_total_paths']}")
    print(f"  Outcome sizes found: {summary['sizes_found']}")

    k = info["axes_to_spawn"]
    outcomes_k = result["outcomes_by_size"].get(k, [])

    if outcomes_k:
        print(f"\nSample exact-k outcomes (up to {show_limit}):")
        for i, item in enumerate(outcomes_k[:show_limit], start=1):
            locs = ", ".join(item["locations"])
            print(f"  {i}. paths={item['path_count']} :: [{locs}]")
    else:
        print("\nNo exact-k outcomes found.")

    if show_distribution and "probability" in result:
        prob = result["probability"]
        print("\nProbability summary (retry on deadlock):")
        print(
            "  Success probability for exact-k run: "
            f"{prob['success_exact_k'] * 100:.1f}%"
        )

        items = list(prob["room_any"].items())
        items.sort(key=lambda x: x[1], reverse=True)

        print(f"  Top {min(top_rooms, len(items))} rooms by P(room appears in successful run):")
        
        # Calculate column widths for alignment
        top_items = items[:top_rooms]
        max_room_len = max(len(room) for room, _ in top_items) if top_items else 0
        
        for i, (room, p) in enumerate(items[:top_rooms], start=1):
            print(f"    {i:2d}. {room:<{max_room_len}}  {p * 100:5.1f}%")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Exhaustively verify all possible axe spawn outcomes from a CSV graph."
    )
    parser.add_argument("--csv", required=True, help="Path to adjacency CSV")
    parser.add_argument("--axes", required=True, type=int, help="Number of axes to spawn")
    parser.add_argument(
        "--include-partials",
        action="store_true",
        help="Include dead-end partial outcomes if exact-k cannot be completed",
    )
    parser.add_argument(
        "--json-out",
        default="",
        help="Optional output file path for full JSON report",
    )
    parser.add_argument(
        "--show-limit",
        type=int,
        default=20,
        help="How many exact-k outcomes to print in console summary",
    )
    parser.add_argument(
        "--distribution",
        action="store_true",
        help="Compute and print per-room spawn probability distribution",
    )
    parser.add_argument(
        "--top-rooms",
        type=int,
        default=15,
        help="How many rooms to print in distribution summary",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    result = run_verification(
        csv_path=args.csv,
        axes_to_spawn=args.axes,
        include_partials=args.include_partials,
        compute_distribution=args.distribution,
    )

    print_summary(
        result,
        show_limit=args.show_limit,
        show_distribution=args.distribution,
        top_rooms=args.top_rooms,
    )

    if args.json_out:
        with open(args.json_out, "w", encoding="utf-8") as f:
            json.dump(result, f, indent=2, ensure_ascii=False)
        print(f"\nWrote JSON report: {args.json_out}")


if __name__ == "__main__":
    main()
