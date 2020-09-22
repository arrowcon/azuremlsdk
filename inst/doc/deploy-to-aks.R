## ----import_package, eval=FALSE-----------------------------------------------
#  library(azuremlsdk)

## ----load_workspace, eval=FALSE-----------------------------------------------
#  ws <- load_workspace_from_config()

## ----get_workspace, eval=FALSE------------------------------------------------
#  ws <- get_workspace("<your workspace name>", "<your subscription ID>", "<your resource group>")

## ----register_model, eval=FALSE-----------------------------------------------
#  model <- register_model(ws,
#                          model_path = "deploy-to-aks/model.rds",
#                          model_name = "iris_model",
#                          description = "Predict an Iris flower type")

## ----provision_cluster, eval=FALSE--------------------------------------------
#  aks_target <- create_aks_compute(ws, cluster_name = 'myakscluster')
#  
#  wait_for_provisioning_completion(aks_target, show_output = TRUE)

## ----create_env, eval=FALSE---------------------------------------------------
#  r_env <- r_environment(name = "deploy_env")

## ----create_inference_config, eval=FALSE--------------------------------------
#  inference_config <- inference_config(
#    entry_script = "score.R",
#    source_directory = "deploy-to-aks",
#    environment = r_env)

## ----deploy_config, eval=FALSE------------------------------------------------
#  aks_config <- aks_webservice_deployment_config(cpu_cores = 1, memory_gb = 1)

## ----deploy_service, eval=FALSE-----------------------------------------------
#  aks_service <- deploy_model(ws,
#                              'my-new-aksservice',
#                              models = list(model),
#                              inference_config = inference_config,
#                              deployment_config = aks_config,
#                              deployment_target = aks_target)
#  
#  wait_for_deployment(aks_service, show_output = TRUE)

## ----get_logs, eval=FALSE-----------------------------------------------------
#  get_webservice_logs(aks_service)

## ----test_service, eval=FALSE-------------------------------------------------
#  library(jsonlite)
#  # versicolor
#  plant <- data.frame(Sepal.Length = 6.4,
#                      Sepal.Width = 2.8,
#                      Petal.Length = 4.6,
#                      Petal.Width = 1.8)
#  
#  # setosa
#  # plant <- data.frame(Sepal.Length = 5.1,
#  #                    Sepal.Width = 3.5,
#  #                    Petal.Length = 1.4,
#  #                    Petal.Width = 0.2)
#  
#  # virginica
#  # plant <- data.frame(Sepal.Length = 6.7,
#  #                    Sepal.Width = 3.3,
#  #                    Petal.Length = 5.2,
#  #                    Petal.Width = 2.3)
#  
#  predicted_val <- invoke_webservice(aks_service, toJSON(plant))
#  message(predicted_val)

## ----eval=FALSE---------------------------------------------------------------
#  aks_service$scoring_uri

## ----delete_service, eval=FALSE-----------------------------------------------
#  delete_webservice(aks_service)

## ----delete_model, eval=FALSE-------------------------------------------------
#  delete_model(model)

## ----delete_cluster, eval=FALSE-----------------------------------------------
#  delete_compute(aks_target)

