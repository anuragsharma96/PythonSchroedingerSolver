# Schrödinger Equation Solver

A comprehensive Python script for solving the time-independent Schrödinger equation in arbitrary dimensions using multiple numerical methods, analytic benchmarks, and advanced visualization. Designed to run inside a Python virtual environment on Windows PowerShell and easily integrated into GitHub workflows.

---

## 🚀 Features

- **Multi-dimensional support**: 1D, 2D, and higher dimensions via sparse matrices and PCA visualization.
- **Multiple solvers**:
  - **Finite Difference Method (FDM)**
  - **Shooting Method** (1D only)
  - **Variational Method**
  - **Matrix Diagonalization** (alias of FDM)
  - **Spectral (Fourier) Method**
  - **Imaginary-time RK4**
  - **Crank–Nicolson**
- **Analytic solutions** for harmonic oscillator, infinite square well (1D), and Coulomb potential (3D) for cross-checking.
- **High-precision potential evaluation** with `sympy` and `mpmath`.
- **Parallel execution** using `multiprocessing.Pool` to leverage all CPU cores.
- **Dual logging**: console + file (`schroedinger.log`) to record execution details and errors.
- **Rich visualization**:
  - Plot potential energy surfaces (1D line, 2D contours, 3D scatter via PCA).
  - Compare eigenvalue spectra across methods.
  - Display ground-state wavefunctions for each chosen method.
  - Overlay analytic wavefunction when available.
- **Output artifacts**:
  - JSON summary (`schrodinger_results.json`)
  - NumPy archive (`.npz`) for grids, potentials, and eigenvalues
  - Interactive Matplotlib plots

---

## 🛠️ Prerequisites

- **Windows 10+** or any OS with PowerShell
- **Python 3.8+**

### Python Virtual Environment

```powershell
# Create a virtual environment named 'venv'
py -m venv venv

# Activate it
.\venv\Scripts\Activate.ps1
```

### Install Dependencies

```powershell
pip install \
  numpy sympy scipy matplotlib mpmath scikit-learn
```

---

## ⚙️ Configuration

### JSON-Based Input (Recommended)

Create an `input.json` file containing the problem parameters:

```json
{
  "n_dim": 2,          // Number of spatial dimensions
  "V_str": "x0**2 + x1**2",  // Potential V(x0, x1) in sympy syntax
  "L": 5.0,            // Half-domain length: [-L, L]
  "num_pts": 128,      // Grid points per dimension
  "num_eigs": 6,       // Number of eigenvalues to compute
  "chosen": [          // Subset of methods for wavefunction plotting
    "FDM", "Spectral", "CrankN"
  ]
}
```

### Interactive Mode

If you prefer prompts instead of JSON, simply run without `--input`, answer the console questions to set:

1. Dimension `n_dim`
2. Potential string `V_str`
3. Domain `L`, grid-points, and eigenvalues (comma-separated)
4. Solver indices to plot

---

## ▶️ Running the Solver

### Command-Line

```powershell
python SchroedingerPython.py --input input.json --output results.json
```

- `--input`  : Path to JSON config (default: **required** in JSON mode).
- `--output` : Path for output JSON (default: `schroedinger_results.json`).

### Output Files

- **JSON** (`.json`): Contains per-method eigenvalues, timings, iteration counts, analytic formulas, and log entries.
- **NumPy Archive** (`.npz`): Enables programmatic reloading of grids, potential array, and each solver’s eigenvalues.
- **Log File** (`schroedinger.log`): Timestamped entries for debugging and performance tracking.
- **Plots**: Shown interactively (no files saved by default). Close each window to proceed.

---

## 🧩 Solver Details

Each solver is implemented as a function returning a tuple: `(method_name, E, psi, duration, history, k_actual)`.

| Method          | Description                                                   |
| --------------- | ------------------------------------------------------------- |
| **FDM**         | Sparse finite-difference Laplacian + ARPACK eigensolver       |
| **Shooting**    | 1D root-finding of boundary-value mismatch via Brent’s method |
| **Variational** | Gaussian trial wavefunction energy expectation                |
| **MatrixDiag**  | Alias for FDM                                                 |
| **Spectral**    | Fourier-space kinetic operator + sparse diagonal potential    |
| **RK4**         | Imaginary-time fourth-order Runge–Kutta iteration             |
| **CrankN**      | Crank–Nicolson time-stepping to ground state                  |

The script automatically chooses `k = min(requested, N-2)` to ensure numerical stability.

---

## 📈 Visualization Functions

### `plot_potential(grids, V_flat)`

- **1D**: Line plot of `V(x)` vs. `x`.
- **2D**: Filled contour `V(x,y)`.
- **>2D**: PCA projection to 3D scatter of potential values.

### `plot_eigenspectrum(all_E, chosen, k_req, n_dim)`

1. **Spectrum (all)**: Overlay of eigenvalue sequences for each method.
2. **Spectrum (chosen)**: Subset plot for clearer comparison.
3. **PCA cloud**: 3D PCA on `(k-index, energy, method-index)` to reveal clustering trends.

### `plot_wavefunction(grids, psi, method)`

- **1D**: Wavefunction amplitude vs. `x` for ground state.
- **2D**: Contour plot of 2D ground-state density.
- **>2D**: PCA-based 3D scatter of flattened wavefunction values.

### Analytic Overlay

If an analytic solution exists (e.g., harmonic oscillator), the script also:

- Computes symbolic `ψ₀(x)` via `sympy`.
- Plots on top of the numerical wavefunction for direct comparison.

---

## ⚙️ Logging & Debugging

- **Log Levels**: INFO for normal operations, ERROR for failures.
- **File**: `schroedinger.log` in working directory.
- **Console**: Real-time progress messages.

Example log entry:

```
2025-06-19 16:30:12,345 [INFO] Results -> schroedinger_results.json
```

---

## 🛠 Troubleshooting

- **Sympy parsing errors**: Ensure `V_str` uses valid Python/sympy syntax (e.g., `sin(x0)`, `exp(-x0**2)`).
- **Memory errors**: Reduce `num_pts` or use fewer solvers in `chosen`.
- **Eigenvalue solver failures**: Check that `N > num_eigs + 1`.

---

## 🏗️ Project Structure

```
├── SchroedingerPython.py   # Main solver script
├── input.json              # Example configuration
├── schroedinger.log        # Execution log (generated)
├── schroedinger_results.json # Output summary
├── schroedinger_results.npz# Output arrays
└── README.md               # Project documentation (this file)
```

---

## 📄 License

Released under the MIT License. See [LICENSE](LICENSE) for details.

---

*Happy quantum computing!*

