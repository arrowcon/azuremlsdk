## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----cluster, eval=FALSE------------------------------------------------------
#  library(azuremlsdk)
#  ws <- load_workspace_from_config()
#  ds <- get_default_datastore(ws)
#  target_path <- "accidentdata"
#  
#  download_from_datastore(ds, target_path=".", prefix="accidentdata")
#  
#  ## Find the compute target
#  cluster_name <- "rcluster"
#  compute_target <- get_compute(ws, cluster_name = cluster_name)
#  if(is.null(compute_target)) stop("Training cluster not found")

## ----accident-glm, eval=FALSE-------------------------------------------------
#  ### FROM FILE: accident-glm.R - do not run this code chunk
#  
#  ## Caret GLM model on training set with 5-fold cross validation
#  accident_glm_mod <- train(
#    form = dead ~ .,
#    data = accident_trn,
#    trControl = trainControl(method = "cv", number = 5),
#    method = "glm",
#    family = "binomial"
#  )
#  summary(accident_glm_mod)

## ----create-experiment, eval=FALSE--------------------------------------------
#  exp <- experiment(ws, "accident")

## ----run-experiment-1, eval=FALSE---------------------------------------------
#  est <- estimator(source_directory="experiments-deep-dive",
#                   entry_script = "accident-glm.R",
#                   script_params = list("--data_folder" = ds$path(target_path)),
#                   compute_target = compute_target)
#  run <- submit_experiment(exp, est)

## ----view_run, eval=FALSE-----------------------------------------------------
#  plot_run_details(run)

## ----tracking_code, eval=FALSE------------------------------------------------
#  ### DO NOT RUN THIS CODE CHUNK: tracking code from accident-XXX.R scripts
#  log_metric_to_run("Accuracy",
#                    calc_acc(actual = accident_tst$dead,
#                             predicted = predict(accident_glmnet_mod, newdata = accident_tst))
#  )
#  log_metric_to_run("Method", "GLMNET")
#  log_metric_to_run("TrainPCT", train.pct)

## ----run-experiment-2, eval=FALSE---------------------------------------------
#  est <- estimator(source_directory="experiments-deep-dive",
#                   entry_script = "accident-knn.R",
#                   script_params = list("--data_folder" = ds$path(target_path)),
#                   compute_target = compute_target)
#  run <- submit_experiment(exp, est)
#  
#  est <- estimator(source_directory="experiments-deep-dive",
#                   entry_script = "accident-glmnet.R",
#                   script_params = list("--data_folder" = ds$path(target_path)),
#                   compute_target = compute_target)
#  run <- submit_experiment(exp, est)

## ----options-code, eval=FALSE-------------------------------------------------
#  ## DO NOT RUN THIS CODE CHUNK: options code from experiment script
#  options <- list(
#    make_option(c("-d", "--data_folder")),
#    make_option(c("-p", "--percent_train"))
#  )
#  
#  opt_parser <- OptionParser(option_list = options)
#  opt <- parse_args(opt_parser)
#  
#  train.pct <- as.numeric(opt$percent_train)

## ----more-experiments, eval=FALSE---------------------------------------------
#  train_pct_exp <- 0.80
#  
#  ## GLM model
#  est <- estimator(source_directory = "experiments-deep-dive",
#                   entry_script = "accident-glm.R",
#                   script_params = list("--data_folder" = ds$path(target_path),
#                                        "--percent_train" = train_pct_exp),
#                   compute_target = compute_target
#  )
#  run.glm <- submit_experiment(exp, est)
#  
#  ## KNN model
#  exp <- experiment(ws, "accident")
#  est <- estimator(source_directory = "experiments-deep-dive",
#                   entry_script = "accident-knn.R",
#                   script_params = list("--data_folder" = ds$path(target_path),
#                                        "--percent_train" = train_pct_exp),
#                   compute_target = compute_target
#  )
#  run.knn <- submit_experiment(exp, est)
#  
#  ## GLMNET model
#  exp <- experiment(ws, "accident")
#  est <- estimator(source_directory = "experiments-deep-dive",
#                   entry_script = "accident-glmnet.R",
#                   script_params = list("--data_folder" = ds$path(target_path),
#                                        "--percent_train" = train_pct_exp),
#                   compute_target = compute_target
#  )
#  run.glmnet <- submit_experiment(exp, est)

## ----check-metrics, eval=FALSE------------------------------------------------
#  get_run_metrics(run.glm)$Accuracy
#  get_run_metrics(run.knn)$Accuracy
#  get_run_metrics(run.glmnet)$Accuracy

## ----retrieve_model, eval=FALSE-----------------------------------------------
#  download_files_from_run(run.glmnet, prefix="outputs/")
#  accident_model <- readRDS("outputs/model.rds")
#  
#  model <- register_model(ws,
#                          model_path = "outputs/model.rds",
#                          model_name = "accidents_model_caret",
#                          description = "Predict probability of auto accident using caret")
#  
#  r_env <- r_environment(name = "basic_env")
#  
#  inference_config <- inference_config(
#    entry_script = "accident_predict_caret.R",
#    source_directory = "experiments-deep-dive",
#    environment = r_env)

## ----provis-aci, eval=FALSE---------------------------------------------------
#  aci_config <- aci_webservice_deployment_config(cpu_cores = 1, memory_gb = 0.5)
#  
#  aci_service <- deploy_model(ws,
#                              'accident-pred-caret',
#                              list(model),
#                              inference_config,
#                              aci_config)
#  
#  wait_for_deployment(aci_service, show_output = TRUE)

## ----get_endpoint, eval=FALSE-------------------------------------------------
#  accident.endpoint <- get_webservice(ws,   "accident-pred-caret")$scoring_uri

## ----shiny-app, eval=FALSE----------------------------------------------------
#  shiny::runApp("experiments-with-R/accident-app")

