## ----eval=FALSE---------------------------------------------------------------
#  # Example when the model is a file
#  model_path <- file.path(Sys.getenv('AZUREML_MODEL_DIR'), 'my_model.rds')
#  
#  # Example when the model is a folder containing a file
#  model_path <- file.path(Sys.getenv('AZUREML_MODEL_DIR'), 'my_model_folder', 'my_model.rds')
#  

## ----eval=FALSE---------------------------------------------------------------
#  # Example when the model is a file, and the deployment contains multiple versions of the same model
#  first_model_path <- file.path(Sys.getenv('AZUREML_MODEL_DIR'), 'my_model', '1', 'my_model.rds')
#  
#  second_model_path <- file.path(Sys.getenv('AZUREML_MODEL_DIR'), 'my_model', '2', 'my_model.rds')

## ----eval=FALSE---------------------------------------------------------------
#  library(jsonlite)
#  
#  init <- function()
#  {
#    # Get the path to the model location of the registered model in Azure ML
#    model_path <- Sys.getenv("AZUREML_MODEL_DIR")
#  
#    # Load the model
#    model <- readRDS(file.path(model_path, "model.rds"))
#    message("logistic regression model loaded")
#  
#    # The following method will be called by Azure ML each time the deployed web service is invoked
#    function(data)
#    {
#      # Deserialize the input data to the service
#      vars <- as.data.frame(fromJSON(data))
#  
#      # Evaluate the data on the deployed model
#      prediction <- as.numeric(predict(model, vars, type="response")*100)
#  
#      # Return the prediction serialized to JSON
#      toJSON(prediction)
#    }
#  }

## ----eval=FALSE---------------------------------------------------------------
#  myenv = get_environment(ws, name = 'myenv', version = '1')
#  
#  inference_config = inference_config(entry_script = 'score.R',
#                                      source_directory = './my_scoring_folder',
#                                      environment = myenv)
#  

## ----eval=FALSE---------------------------------------------------------------
#  deployment_config <- aci_webservice_deployment_config(cpu_cores = 1,
#                                                        memory_gb = 1,
#                                                        auth_enabled = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  # Generate the primary auth key
#  primary_key <- generate_new_webservice_key(service, key_type = "Primary")
#  
#  # Generate the secondary auth key
#  secondary_key <- generate_new_webservice_key(service, key_type = "Secondary")

## ----eval=FALSE---------------------------------------------------------------
#  deployment_config <- aks_webservice_deployment_config(cpu_cores = 1,
#                                                        memory_gb = 1,
#                                                        token_auth_enabled = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  aks_service_access_token <- get_webservice_token(service)
#  
#  # Get the JWT
#  jwt <- aks_service_access_token$access_token
#  # Get the time after which token should be refreshed
#  refresh_after <- aks_service_access_token$refresh_after
#  

## ----eval=FALSE---------------------------------------------------------------
#  library(jsonlite)
#  
#  newdata <- data.frame( # valid values shown below
#   dvcat="10-24",        # "1-9km/h" "10-24"   "25-39"   "40-54"   "55+"
#   seatbelt="none",      # "none"   "belted"
#   frontal="frontal",    # "notfrontal" "frontal"
#   sex="f",              # "f" "m"
#   ageOFocc=22,          # age in years, 16-97
#   yearVeh=2002,         # year of vehicle, 1955-2003
#   airbag="none",        # "none"   "airbag"
#   occRole="pass"        # "driver" "pass"
#   )
#  
#  prob <- invoke_webservice(service, toJSON(newdata))
#  prob

