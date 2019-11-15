## ----configure_parameters, eval=FALSE------------------------------------
#  subscription_id <- Sys.getenv("SUBSCRIPTION_ID", unset = "<my-subscription-id>")
#  resource_group <- Sys.getenv("RESOURCE_GROUP", default="<my-resource-group>")
#  workspace_name <- Sys.getenv("WORKSPACE_NAME", default="<my-workspace-name>")
#  workspace_region <- Sys.getenv("WORKSPACE_REGION", default="eastus2")

## ----create_workspace, eval=FALSE----------------------------------------
#  library(azuremlsdk)
#  
#  ws <- create_workspace(name = workspace_name,
#                         subscription_id = subscription_id,
#                         resource_group = resource_group,
#                         location = workspace_region,
#                         exist_ok = TRUE)

## ----write_config, eval=FALSE--------------------------------------------
#  write_workspace_config(ws)

## ----load_config, eval=FALSE---------------------------------------------
#  ws <- load_workspace_from_config()

## ----get_workspace, eval=FALSE-------------------------------------------
#  ws <- get_workspace(name = workspace_name,
#                      subscription_id = subscription_id,
#                      resource_group = resource_group)

