# PHYLOG Benchmarks suite

Micro-benchmark library for hardware platform evaluation under the PHYLOG project.
The benchmarks aim for specific resource and access types. Those correspond to different kind of transactions in the system, e.g. load to the main memory.

Each benchmark is available as both a victim and an aggressor. Victims collect repeated measurements over a pre-determined number of accesses. Aggressors perform a continuous stream of accesses until interrupted. A victim is thus ran concurrently with 1 or more aggressors to assess their impact on its behaviour.


## Usage

The `script_run_scenarios.sh` script at the root of the repository compiles all benchmarks, then runs a number of scenarios confronting different configurations of aggressors and victims. Measurements are collected per scenario per processor under the "Results/" directory.
```
./scripts_run_scenarios.sh PROCESSOR
```

The script assumes it is running on target, under a GNU/Linux OS, and with all utilities required to compile the benchmarks. They should be adapted for other environments, e.g. OS, bare-metal, cross compilation...

## Benchmarks

The library currently offers different families of benchmarks, with variants accordingly organised under the `benchmarks/` directory: 
- CPU benchmarks focus on intra-core resources, performing various computations;
- Load benchmarks focus on memory resources, loading data from the main memory through various patterns;
- Store benchmarks focus on memory resources, writing data to the main memory through various patterns.

The core body of each benchmark is defined in a separate function and source file, all using the same name. Entry points for the victim and aggressor variants are defined in separate source files, prefixed with respectively with `aggressor_` and `victim_`. As an example consider the `add_load_microbenchmark` function implemented in `benchmarks/Load/add_load_microbenchmark/add_load_microbenchmark.c`, with the `aggressor_add_load_microbenchmark.c` and `victim_add_load_microbenchmark.c` entry points.


## Configuration

Benchmark are configured through macros in the `include/parameters.h` header:
- `TIMECHOICE` (default: `CLOCK`): Choice for the time source. Only `CLOCK` is supported at the moment. Consider adding methods tailored to your platform, e.g. using performance monitoring counters (see `include/get_counters.h`).

- `REPEAT` (default: `20`): Minimal number of repetitions (and collected measurements) per victim execution 

- `PI_COMPUTATION_DEPTH` (default: `100000`): Depth of the PI computation for the related benchmark (CPU Benchmark)

- `VALUE_TO_FACTORIZE` (default: `21603`): Value to decompose for the prime number factorization (CPU Benchmark)

- `SIZE` (default: `1048576` 8MB): Size of the array used by the load and store micro-benchmarks. Different sizes might restrict accesses to different layers of the memory hierarchy: private caches, shared caches, or main memory.

- `STRIDE_MAX` (default: `2048`): Maximal value of stride used by the load and store micro-benchmarks (must be a power of 2). `REPEAT` measurements will be performed for each value of stride from 1 to `STRIDE_MAX`.

Platform configuration is provided by the `scripts/var_generique.sh`. In particular one should identify the number of cores available for each possible host.


## Organisation

- `benchmarks/`: Implementation of the different benchmarks and supporting scripts for compilation and execution.
- `include/`: Shared headers for configuration parameters and functions.
- `runs/`: Scripts to run the default scenarios.
- `script_clean_interference-benchmarks.sh`: Cleanup all compilation artefacts.
- `script_compile_interference-benchmarks.sh`: Compile all benchmarks.
- `script_run_interference-benchmarks.sh`: Run all benchmarks in isolation.
- `script_run_scenarios.sh`: Run all default scenarios for all benchmarks.
- `scripts/`: Shared scripts and utility functions.
- `Results/`: Output path for collected measurement traces.


