# To call Python code from R, we can use the R package reticulate.

# https://rstudio.github.io/reticulate/articles/python_packages.html
# https://cran.r-project.org/web/packages/reticulate/vignettes/calling_python.html
# https://raw.githubusercontent.com/rstudio/cheatsheets/main/reticulate.pdf

setwd("/root/run-python-from-r")
envname = "virtual_env_name"

# Necessary for the virtualenv_create function from the reticulate package.
system("apt install python3.10-venv -y")

# Install the reticulate package if it is not already installed.
if(!require(reticulate)){
  install.packages("reticulate")
}
# Load the reticulate package.
library(reticulate)

virtualenv_create(envname)
use_virtualenv(envname)

# https://github.com/rstudio/reticulate/issues/963
# Necessary if pip was not installed automatically.
system(paste("/root/.virtualenvs/", envname, "/bin/python -m ensurepip", sep=""))

py_config()
virtualenv_install(envname, "numpy")
virtualenv_install(envname, "pyjokes")
py_config()

# https://rstudio.github.io/reticulate/articles/calling_python.html
# Import Python modules with the import function from the reticulate package.
os = import("os")
os$listdir(".")
pyjokes = import("pyjokes")
pyjokes$get_jokes()

# Run inline Python code, in this case to set a Python variable
py_run_string("x = 10")
# Access the python main module via the 'py' object
py$x

x = 5  # Note that this is different from the Python variable x to which we
# assigned the value 10 above.

myvar = 2+2

View(myvar)  # We are in an R environment, this would not work in Python