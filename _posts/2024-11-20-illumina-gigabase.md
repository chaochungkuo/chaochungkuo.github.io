---
title: Calculating Gigabases of BCL runs
date: 2024-11-20
categories: [Bioinformatics, illumina]
tags: [illumina, bcl, python]  # TAG names should always be lowercase
published: true
---

These scripts aims to calculate the Gigabase output from all sequencers we have.

```python
from interop import py_interop_run, py_interop_run_metrics, py_interop_summary

def get_gigabase(bcl_path):
    # Define the path to the BCL folder's InterOp directory
    # bcl_path = "/data/raw/miseq1_M00818/241028_M00818_0944_000000000-LNHVH"

    # Step 1: Read Run Information
    run_info = py_interop_run.info()
    run_info.read(bcl_path)

    # Get total number of cycles from the run
    total_cycles = run_info.total_cycles()
    # print(f"Total Cycles: {total_cycles}")

    run_metrics = py_interop_run_metrics.run_metrics()
    run_metrics.read(bcl_path)
    summary = py_interop_summary.run_summary()
    py_interop_summary.summarize_run_metrics(run_metrics, summary)

    lanes = summary.lane_count()
    readNo = 0
    total_reads_pf = 0
    for lane in range(lanes):
        read = summary.at(readNo).at(lane)
        total_reads_pf += read.reads_pf()
    # print(total_reads_pf)

    gigabase = (total_cycles * total_reads_pf) / 1e9
    return(gigabase)

sequencers = ["miseq1_M00818", "miseq2_M04404", "miseq3_M00403", "nextseq_NB501289", "novaseq_A01742"]
raw_data_paths = ["/data/raw/", "/mnt/nextgen2/archive/raw/"]

import os
import fnmatch
import pandas as pd

pattern = "24*"

col_seq = []
col_run = []
col_gigabase = []
for seq in sequencers:
    for raw_path in raw_data_paths:
        raw_folder = os.path.join(raw_path, seq)
        try:
            filtered_folders = [d for d in os.listdir(raw_folder) if os.path.isdir(os.path.join(raw_folder, d)) and fnmatch.fnmatch(d, pattern)]
            for run in filtered_folders:
                if run in col_run:
                    continue
                else:
                    bcl_path = os.path.join(raw_folder, run)
                    gigabase = get_gigabase(bcl_path)
                    col_seq.append(seq)
                    col_run.append(run)
                    col_gigabase.append(gigabase)
                    print([seq, run, gigabase])
        except:
            pass

summary = pd.DataFrame.from_dict({"Sequencer": col_seq,
                                  "Run": col_run,
                                  "Gigabase": col_gigabase})
stat_per_seq = summary.groupby("Sequencer")["Gigabase"].sum().reset_index()

# Save to Excel with two tabs
output_path = "2024_gigabase.xlsx"
with pd.ExcelWriter(output_path, engine='openpyxl') as writer:
    stat_per_seq.to_excel(writer, sheet_name="Per Sequencer", index=False)
    summary.to_excel(writer, sheet_name="Per run", index=False)

print(f"DataFrames have been saved to {output_path}")
```


