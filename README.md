# Análisis comparativo entre optimización clásica y optimización metaheurística aplicado al Beamforming adaptativo de arreglos planos MIMO Masivo

In recent years, wireless networks have experienced exponential growth due to increasing research and new technologies in both hardware and software. However, this increase in devices poses several problems and challenges for the network, such as limited or non-existent coverage in rural or remote areas, signal interference due to electromagnetic interference or densely populated urban environments, privacy of transmitted data, and poor quality of service offered by mobile operators. To address these issues, the industry and scientific community are investigating various techniques, with Beamforming being the most suitable strategy in the context of fifth and sixth generation mobile telephony.

This thesis conducts a comparative analysis between classical optimization algorithms such as Conjugate Gradient Method (CGM), Stochastic Gradient Descent (SGD), and Nelder-Mead Search (NMS), and metaheuristic algorithms such as Particle Swarm Optimization (PSO), Bat Algorithm (BA), and Cuckoo Search by Lévy Flights (CKLF). For this analysis, different test functions were selected in different dimensions and metrics. Stop criteria, maximum number of iterations, and success rate were established. In addition, the convergence order p was analyzed through the analysis of the Root Mean Squared Error time series.

The thesis also considers the model of Blind Adaptive Beamforming, where the information of the desired and interfering signal orientations is not available for the algorithm. A rectangular flat antenna with 64 radiating elements was used, and metrics such as the bandwidth of the average power in degrees, the radiation intensity of the main lobe, the depth of the first nulls, and the level of the side lobes were implemented, all in decibels. The results aim to improve spectral efficiency and service quality.

$\textbf{Keywords:}$ Wireless networks, Beamforming, Optimization algorithms, Blind Adaptive Beamforming, Metaheuristic algorithms.

# Table of Contents

- [Prerequisites](#Prerequisites)
- [Installation](#Installation)
- [Usage](#Usage)
- [License](#License)
- [Contact](#Contact)

# Prerequisites
The simulations were performed on a modern computer using $MATLAB\textsuperscript{\textregistered}$ R2022B software, this being a laptop with Intel(R) 12th Gen Core i9 12900H processor at 2.5 GHz with 14 cores, RAM 32 GB. Operating System Windows 11 Professional at 64 bits and NVIDIA GeForce RTX 3080 Ti with 16GB.

# Installation
Once you install the last version of $MATLAB\textsuperscript{\textregistered}$ R2022B software adn then clone the repository with the 3 folders.

# Usage
  1. In the folder: "01_Funciones" execute the code "Main_generador.m".
  2. In the folder: "02_Algoritmos" execute the codes.
      - Analisis_01_CGM.m
      - Analisis_02_SGD.m
      - Analisis_03_NMS.m
      - Analisis_04_PSO.m
      - Analisis_05_BA.m
      - Analisis_06_CKLF.m
  3. In the folder: "03_Experimentos" execute the code "MAIN_DEFINITIVO.m".

# License
Copyright (c) 2023 act1_met_sim_est_tablero authors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Contact
For additional information or questions about the project, you can reach out to the following individuals:

- hamsomp3@hotmail.com
- janpolanco@javerianacali.edu.co
- [LinkedIn](https://www.linkedin.com/in/jan-polanco-velasco/)

We will be happy to assist you. Thank you for your interest in this project!
