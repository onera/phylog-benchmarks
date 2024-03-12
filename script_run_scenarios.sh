#!/bin/bash

RUN_DIR=runs

echo "--> compilation"
./script_compile_interference-benchmarks.sh

# Excution en isolation
echo "--> Execution en isolation"
./script_run_interference-benchmarks.sh $1

# CPU versus CPU
echo "--> CPU versus CPU"
./${RUN_DIR}/run2_cpu_vs_fcpu.sh $1
./${RUN_DIR}/run3_cpu_vs_fcpu_fcpu.sh $1
./${RUN_DIR}/run4_cpu_vs_fcpu_fcpu_fcpu.sh $1

# CPU versus load
echo "--> CPU versus load"
./${RUN_DIR}/run2_cpu_vs_dload.sh $1 16 
./${RUN_DIR}/run3_cpu_vs_dload_dload.sh $1 16 16 
./${RUN_DIR}/run4_cpu_vs_dload_dload_dload.sh $1 16 16 16 

# CPU versus store
echo "--> CPU versus store"
./${RUN_DIR}/run2_cpu_vs_store.sh $1 16 
./${RUN_DIR}/run3_cpu_vs_store_store.sh $1 16 16 
./${RUN_DIR}/run4_cpu_vs_store_store_store.sh $1 16 16 16 

# Load versus CPU
echo "--> Load versus CPU"
./${RUN_DIR}/run2_load_vs_fcpu.sh $1

# Store versus CPU
echo "--> Store versus CPU"
./${RUN_DIR}/run2_store_vs_fcpu.sh $1

# Load versus load
echo "--> Load versus load"
./${RUN_DIR}/run2_load_vs_dload.sh $1 16 
./${RUN_DIR}/run2_load_vs_rload.sh $1 100
./${RUN_DIR}/run3_load_vs_dload_dload.sh $1 16 16 
./${RUN_DIR}/run3_load_vs_rload_rload.sh $1 100 100
./${RUN_DIR}/run4_load_vs_dload_dload_dload.sh $1 16 16 16 
./${RUN_DIR}/run4_load_vs_rload_rload_rload.sh $1 100 100 100

# Load versus Store
echo "--> Load versus store"
./${RUN_DIR}/run2_load_vs_store.sh $1 16 
./${RUN_DIR}/run3_load_vs_store_store.sh $1 16 16 
./${RUN_DIR}/run4_load_vs_store_store_store.sh $1 16 16 16 

# Store versus Store
echo "--> Store versus store"
./${RUN_DIR}/run2_store_vs_store.sh $1 16 
./${RUN_DIR}/run3_store_vs_store_store.sh $1 16 16 
./${RUN_DIR}/run4_store_vs_store_store_store.sh $1 16 16 16 

# Store versus Load
echo "--> Store versus load"
./${RUN_DIR}/run2_store_vs_dload.sh $1 16 
./${RUN_DIR}/run2_store_vs_rload.sh $1 100
./${RUN_DIR}/run3_store_vs_dload_dload.sh $1 16 16 
./${RUN_DIR}/run3_store_vs_rload_rload.sh $1 100 100
./${RUN_DIR}/run4_store_vs_dload_dload_dload.sh $1 16 16 16 
./${RUN_DIR}/run4_store_vs_rload_rload_rload.sh $1 100 100 100


