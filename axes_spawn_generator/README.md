# Axes Spawn Generator & Verification Tools

Tools for generating Minecraft datapack code that spawns axes at non-adjacent locations, with exhaustive verification and probability analysis.

## Files

### Core Scripts

**`graph_generator.py`** — Build proximity graphs from raw coordinates  
- Input: `axe_locations.tmp` (tag name, x, y, z per line)
- Output: `proximity_graph_*.csv`, `proximity_graph_*.dot`
- Modes: 
  - `threshold` — connect by distance threshold (e.g., 20 units)
  - `knn` — k-nearest neighbors (default: k=5)

**`datapack_generator.py`** — Generate Minecraft spawning functions  
- Input: `proximity_graph_*.csv` (adjacency matrix)
- Output: `../pumpkin_mode/data/trackbreak/function/spawn_axes/` (58 `.mcfunction` files)
- Features:
  - Recursive spawn logic with availability masking
  - Dynamic target from scoreboard value `axes_count` in objective `pumpkin_counter` (ex `/scoreboard players set axes_count pumpkin_counter 2`)
  - Debug messages (toggleable via `debug_enabled` flag)
  - Retries full spawn process if deadlock occurs (hard limit: 10 retries)

**`graph_verificator.py`** — Exhaustive outcome analysis  
- Input: `proximity_graph_*.csv`, target axes count
- Output: console summary + optional JSON report
- Capabilities:
  - All possible final outcomes (unordered sets)
  - Max achievable axes on conflict graph
  - Per-room spawn probability (with retry-on-deadlock semantics)
  - Path counting per outcome variant

## Usage

### 1. Generate Proximity Graph

```bash
python3 graph_generator.py
```

Editable config in `main()`:
- `threshold` — distance threshold (default: 20.0)
- `k_neighbors` — k-NN count (default: 5)
- Outputs: `.csv` matrix + `.dot` visualization

### 2. Generate Datapack Functions

```bash
python3 datapack_generator.py
```

Config in `main()`:
- `csv_file` — choose `proximity_graph_knn.csv` or `proximity_graph_threshold.csv`
- `debug_enabled` — show spawn debug messages (default: True)

Outputs 58 files to `../pumpkin_mode/data/trackbreak/function/spawn_axes/`

**Minecraft setup and usage:**
```
/function trackbreak:spawn_axes/setup
scoreboard players set axes_count pumpkin_counter 10
/function trackbreak:spawn_axes/start_spawn
```

What these commands do:
- `setup` creates required objectives and constants used by the spawn system.
- `axes_count pumpkin_counter` defines how many axes to spawn for the next run.
- `start_spawn` copies `axes_count -> axes_target`, runs spawn attempts, and retries from scratch if needed.

Runtime behavior in Minecraft:
- Per retry, the system attempts to place axes until target is reached or max attempts is hit.
- If target was not reached, it reinitializes availability and retries.
- Retry limit is `10`; after that it reports failure.
- Final chat output reports spawned axes and retry count.

### 3. Verify Outcomes & Probabilities

```bash
# All possible 5-axe outcomes
python3 graph_verificator.py --csv proximity_graph_knn.csv --axes 5 --show-limit 10

# With per-room probabilities (retry on deadlock)
python3 graph_verificator.py --csv proximity_graph_knn.csv --axes 5 \
  --distribution --top-rooms 15 --show-limit 5

# Save full results to JSON
python3 graph_verificator.py --csv proximity_graph_knn.csv --axes 5 \
  --distribution --json-out results.json
```

**Flags:**
- `--csv <file>` — input adjacency matrix (required)
- `--axes <n>` — target axes to spawn (required)
- `--distribution` — compute & print room spawn probabilities
- `--top-rooms <n>` — limit room list (default: 15)
- `--show-limit <n>` — sample outcomes to display (default: 20)
- `--include-partials` — include dead-end partial outcomes
- `--json-out <file>` — save JSON report

## Algorithm

### Spawn Process (Datapack)

1. Initialize all locations as available
2. Randomly pick an available location
3. Spawn axe there; mark location + adjacent as unavailable
4. Repeat until target reached or no more available locations
5. Retry entire process if deadlock before reaching target (up to 10 retries)

### Verification (Exhaustive Search)

- DFS explores all possible random choices as branches
- Memoization by `(available_mask, remaining_axes)`
- Returns: all distinct final sets + path counts per set

### Probability Computation

- Each available location has uniform 1/n pick probability
- Failed branches (deadlock) restart entire process
- Final distribution is **conditioned on successful runs**
- Reports P(room appears in successful outcome)

## Example Output

```
Verification summary
  CSV: proximity_graph_knn.csv
  Requested axes: 5
  Vertices: 28
  Max spawnable axes: 8
  Exact-k feasible: True
  Exact-k distinct outcomes: 2965
  Exact-k total paths: 355800

Probability summary (retry on deadlock):
  Success probability for exact-k run: 99.9%
  Top 5 rooms by P(room appears in successful run):
     1. gate1              23.8%
     2. princess           22.8%
     3. orange_room        22.4%
     4. blue_garden        22.3%
     5. terentiy_room      21.8%
```

## Data Files

- `axe_locations.tmp` — raw coordinates
- `proximity_graph_knn.csv` — k-NN adjacency (28 locations × 28)
- `proximity_graph_knn.dot` — Graphviz format for visualization
- Other variants: `threshold`, `igor` CSVs for different graph configurations
