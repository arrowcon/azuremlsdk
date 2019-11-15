## ----install_remotes, eval=FALSE-----------------------------------------
#  install.packages('remotes')

## ----install_azuremlsdk, eval=FALSE--------------------------------------
#  remotes::install_github('https://github.com/Azure/azureml-sdk-for-r')

## ----eval=FALSE----------------------------------------------------------
#  remotes::install_github('https://github.com/Azure/azureml-sdk-for-r', INSTALL_opts=c("--no-multiarch"))

## ----install_pythonsdk, eval=FALSE---------------------------------------
#  azuremlsdk::install_azureml()

## ----eval=FALSE----------------------------------------------------------
#  azuremlsdk::install_azureml(version = NULL,
#                              envname = "<your conda environment name>",
#                              conda_python_version = "<desired python version>")

## ----test_installation, eval=FALSE---------------------------------------
#  library(azuremlsdk)
#  get_current_run()

