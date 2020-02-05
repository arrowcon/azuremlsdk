## ----install_remotes, eval=FALSE-----------------------------------------
#  install.packages('remotes')

## ----install_azuremlsdk, eval=FALSE--------------------------------------
#  remotes::install_github('https://github.com/Azure/azureml-sdk-for-r')
#  
#  remotes::install_cran('azuremlsdk', repos = 'https://cloud.r-project.org/')

## ----eval=FALSE----------------------------------------------------------
#  remotes::install_cran('azuremlsdk', repos = 'https://cloud.r-project.org/', INSTALL_opts=c("--no-multiarch"))

## ----install_pythonsdk1, eval=FALSE--------------------------------------
#  azuremlsdk::install_azureml(envname = 'r-reticulate')

## ----install_pythonsdk2, eval=FALSE--------------------------------------
#  azuremlsdk::install_azureml()

## ----eval=FALSE----------------------------------------------------------
#  azuremlsdk::install_azureml(version = NULL,
#                              envname = "<your conda environment name>",
#                              conda_python_version = "<desired python version>",
#                              restart_session = TRUE,
#                              remove_existing_env = TRUE)

## ----test_installation, eval=FALSE---------------------------------------
#  library(azuremlsdk)
#  get_current_run()

