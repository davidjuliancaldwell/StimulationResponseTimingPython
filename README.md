### Code to produce figures and generate .csv files in Python, as well as run R analysis scripts of the stimulation response time, modified waveform, and temporal order judgement experiments in epilepsy patients. This code should be run after the MATLAB analyses in the ***ResponseTimingAnalysis***

This repository contains python and R code to analyze the data from different sorts of stimulation response time, modified waveform, and temporal order judgement experiments in epilepsy patients.

---

### Response timing analysis

Each subject has their individual analysis python jupyter notebook. For example, ***a1355e_priming.ipynb*** is the jupyter notebook for a1355e.

***run_priming_stats.R*** allows for statistical analyses on the response timing data after the CSV files in python have been generated. It is currently setup for some of the existing "priming" experiments for subjects a1355e, 3ada8b, and 822e26.

---

### Temporal order judgement analysis

Each subject has their individual analysis python jupyter notebook. For example, ***a1355e_tempOrderJudge.ipynb*** is the jupyter notebook for a1355e.

***run_TOJ_stats.R*** allows for statistical analyses of the temporal order judgement experiments from subjects a1355e, 3ada8b, and 822e26 after the python scripts have been run and the CSV files generated.


---

David J Caldwell, BSD-3 License
