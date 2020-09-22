## ----eval=FALSE---------------------------------------------------------------
#  library(azuremlsdk)

## ----load_workpace, eval=FALSE------------------------------------------------
#  ws <- load_workspace_from_config()

## ----get_workpace, eval=FALSE-------------------------------------------------
#  ws <- get_workspace("<your workspace name>", "<your subscription ID>", "<your resource group>")

## ----create_experiment, eval=FALSE--------------------------------------------
#  exp <- experiment(workspace = ws, name = 'hyperdrive-cifar10')

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
#  env <- r_environment("keras-env", custom_docker_image = "amlsamples/r-keras:latest")
#  
#  est <- estimator(source_directory = "hyperparameter-tune-with-keras",
#                   entry_script = "cifar10_cnn.R",
#                   compute_target = compute_target,
#                   environment = env)

## ----search_space, eval=FALSE-------------------------------------------------
#  sampling <- random_parameter_sampling(list(batch_size = choice(c(16, 32, 64)),
#                                             epochs = choice(c(200, 350, 500)),
#                                             lr = normal(0.0001, 0.005),
#                                             decay = uniform(1e-6, 3e-6)))

## ----termination_policy, eval=FALSE-------------------------------------------
#  policy <- bandit_policy(slack_factor = 0.15)

## ----create_config, eval=FALSE------------------------------------------------
#  hyperdrive_config <- hyperdrive_config(hyperparameter_sampling = sampling,
#                                         primary_metric_goal("MINIMIZE"),
#                                         primary_metric_name = "Loss",
#                                         max_total_runs = 8,
#                                         policy = policy,
#                                         estimator = est)

## ----submit_run, eval=FALSE---------------------------------------------------
#  hyperdrive_run <- submit_experiment(exp, hyperdrive_config)

## ----eval=FALSE---------------------------------------------------------------
#  plot_run_details(hyperdrive_run)

## ----eval=FALSE---------------------------------------------------------------
#  wait_for_run_completion(hyperdrive_run, show_output = TRUE)

## ----analyse_runs, eval=FALSE-------------------------------------------------
#  # Get the metrics of all the child runs
#  child_run_metrics <- get_child_run_metrics(hyperdrive_run)
#  child_run_metrics
#  
#  # Get the child run objects sorted in descending order by the best primary metric
#  child_runs <- get_child_runs_sorted_by_primary_metric(hyperdrive_run)
#  child_runs
#  
#  # Directly get the run object of the best performing run
#  best_run <- get_best_run_by_primary_metric(hyperdrive_run)
#  
#  # Get the metrics of the best performing run
#  metrics <- get_run_metrics(best_run)
#  metrics

## ----delete_compute, eval=FALSE-----------------------------------------------
#  delete_compute(compute_target)

