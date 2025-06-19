# run_solver.ps1
param(
  [string]$InputJson,
  [string]$OutputJson
)

# 1) Activate virtual environment
& "D:\Personal Project\Math_Simulations\Schroedinger_Solution\Python Libraries\Scripts\Activate.ps1"


# 2) Run the solver in headless mode
python "D:\Personal Project\Math_Simulations\Schroedinger_Solution\SchroedingerSolverp2.py" `
    --input  $InputJson `
    --output $OutputJson
