# ELEC-E5810 Biosignal Processing — Lab Work

![MATLAB](https://img.shields.io/badge/MATLAB-Live_Scripts-0076A8?logo=mathworks&logoColor=white)
![Topic](https://img.shields.io/badge/Topic-Biosignal_Processing-orange)
![Project](https://img.shields.io/badge/Project-Coursework-lightgrey)

Lab work for ELEC-E5810 Biosignal Processing (Aalto University), done in pairs by
María and Claudia. Three labs apply classical signal processing to real
physiological recordings (ECG, EEG, EMG and cardiovascular signals):

1. **Deterministic filtering and linear stochastic models**: IIR/FIR filtering,
   AR-model estimation and EEG classification for a brain-computer interface.
2. **Parametric and non-parametric spectral estimation**: AR spectra, Welch
   and Pisarenko harmonic estimation.
3. **Adaptive filtering**: an LMS interference canceller used to remove EOG
   artefacts from EEG.

### Prerequisites
- MATLAB with the **Signal Processing Toolbox** (`butter`, `firls`, `filtfilt`, `pwelch`, …)
- **System Identification Toolbox** for Lab 1 (`iddata`, `arx`, `present`)

### Run a lab

Open MATLAB at the repository root, put the lab's data on the path, and run the
live script section by section:

```matlab
addpath('lab1/data', 'lab1/matlab');
open('lab1/matlab/lab1-task1-maria-claudia.mlx')
```

## Repository Layout

```
biosignal-processing-lab1/
├── lab1/                Lab I: filtering and linear stochastic models
│   ├── data/            ecg_data.mat, ar_data.mat, bci_eeg.mat
│   ├── matlab/          Task live scripts (.mlx)
│   └── documentation/   Lab report (PDF)
├── lab2/                Lab II: spectral estimation
│   ├── data/            heart_data.mat, emg_data.mat, eeg_stimul_data.mat
│   ├── matlab/          Task live scripts + my_AR_spectrum.m, my_pisarenko.m
│   └── documentation/   Lab report (PDF)
├── lab3/                Lab III: adaptive filtering
│   ├── data/            lms_test_data.mat, eeg_artefact_data.mat
│   ├── matlab/          Task scripts + my_lms_artefact_canceller.m
│   └── documentation/   Lab report (PDF)
└── requirements.txt     
```

## Reports

- [Lab I report](lab1/documentation/report_lab1_maria_claudia.pdf)
- [Lab II report](lab2/documentation/report_lab2_maria_claudia.pdf)
- [Lab III report](lab3/documentation/report_lab3_maria_claudia.pdf)
