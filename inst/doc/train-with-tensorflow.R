## ----eval=FALSE---------------------------------------------------------------
#  library(azuremlsdk)

## ----load_workpace, eval=FALSE------------------------------------------------
#  ws <- load_workspace_from_config()

## ----get_workpace, eval=FALSE-------------------------------------------------
#  ws <- get_workspace("<your workspace name>", "<your subscription ID>", "<your resource group>")

## ----create_experiment, eval=FALSE--------------------------------------------
#  exp <- experiment(workspace = ws, name = "tf-mnist")

## ----create_cluster, eval=FALSE-----------------------------------------------
#  cluster_name <- "gpucluster"
#  
#  compute_target <- get_compute(ws, cluster_name = cluster_name)
#  if (is.null(compute_target))
#  {
#    vm_size <- "STANDARD_NC6"
#    compute_target <- create_aml_compute(workspace = ws,
#                                         cluster_name = cluster_name,
#                                         vm_size = vm_size,
#                                         max_nodes = 4)
#  
#    wait_for_provisioning_completion(compute_target, show_output = TRUE)
#  }

## ----create_estimator, eval=FALSE---------------------------------------------
#  env <- r_environment("tensorflow-env", custom_docker_image = "amlsamples/r-tensorflow:latest")
#  
#  est <- estimator(source_directory = "train-with-tensorflow",
#                   entry_script = "tf_mnist.R",
#                   compute_target = compute_target,
#                   environment = env)

## ----submit_job, eval=FALSE---------------------------------------------------
#  run <- submit_experiment(exp, est)

## ----eval=FALSE---------------------------------------------------------------
#  plot_run_details(run)

## ----eval=FALSE---------------------------------------------------------------
#  wait_for_run_completion(run, show_output = TRUE)

## ----get_metrics, eval=FALSE--------------------------------------------------
#  metrics <- get_run_metrics(run)
#  metrics

## ----delete_compute, eval=FALSE-----------------------------------------------
#  delete_compute(compute_target)

