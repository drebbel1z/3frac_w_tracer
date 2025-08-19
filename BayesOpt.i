[StochasticTools]
[]

[Distributions]
  [log_fracture_aperture_1]
    type = Uniform
    lower_bound = -5
    upper_bound = -2.5
  []

  [log_fracture_aperture_2]
    type = Uniform
    lower_bound = -5
    upper_bound = -2.5
  []

  [log_fracture_aperture_3]
    type = Uniform
    lower_bound = -5
    upper_bound = -2.5
  []

  [log_matrix_poro]
    type = Uniform
    lower_bound = -4
    upper_bound = -2
  []

  [midpoint_of_sigmoid]
    type = Uniform
    lower_bound = 10
    upper_bound = 90
  []

  [log_slope_at_midpoint]
    type = Uniform
    lower_bound = -3
    upper_bound = 0.0
  []

  [log_matrix_perm]
    type = Uniform
    lower_bound = -17.5
    upper_bound = -15.5
  []

  [log_frac_roughness]
    type = Uniform
    lower_bound = -3
    upper_bound = -1.7
  []
[]

[ParallelAcquisition]
  [expectedimprovement]
    type = ParEGO
    # tuning = 0.01
    require_full_covariance = true
  []
[]

[Samplers]
  [sample]
    type = GenericActiveLearningSampler
    distributions = 'log_fracture_aperture_1 log_fracture_aperture_2 log_fracture_aperture_3 log_matrix_poro midpoint_of_sigmoid log_slope_at_midpoint log_matrix_perm log_frac_roughness'
    sorted_indices = 'conditional/sorted_indices'
    num_parallel_proposals = 5
    num_tries = 5000
    seed = 100
    execute_on = PRE_MULTIAPP_SETUP
    initial_values = "2e-4 2e-4 2e-4 2e-4 2e-4 2e-4 2e-4 2e-4"
  []
[]

[MultiApps]
  [sub]
    type = SamplerFullSolveMultiApp
    input_files = 2dFrac_10zone.i
    sampler = sample
    ignore_solve_not_converge = true
  []
[]

[Transfers]
  [reporter_transfer]
    type = SamplerReporterTransfer
    from_reporter = 'objective_functions/objective_functions'
    stochastic_reporter = 'constant'
    from_multi_app = sub
    sampler = sample
  []
[]

[Controls]
  [cmdline]
    type = MultiAppSamplerControl
    multi_app = sub
    sampler = sample
    param_names = 'log_frac_aperature_1 log_frac_aperature_2 log_frac_aperature_3 log_matrix_poro AuxKernels/aperture_fracture3/midpoint_of_sigmoid log_slope_at_midpoint log_matrix_perm log_frac_roughness'
  []
[]

[Reporters]
  [constant]
    type = StochasticReporter
  []
  [conditional]
    type = GenericActiveLearner
    output_value = 'constant/reporter_transfer:objective_functions:objective_functions'
    sampler = sample
    al_gp = 'GP_al_trainer1 GP_al_trainer2 GP_al_trainer3 GP_al_trainer4 GP_al_trainer5'
    gp_evaluator = 'GP_eval1 GP_eval2 GP_eval3 GP_eval4 GP_eval5'
    acquisition = 'expectedimprovement'
    penalize_acquisition = false
    num_objs = 5
  []
[]

[Trainers]
  [GP_al_trainer1]
   type = ActiveLearningGaussianProcess
    covariance_function = 'covar1'
    standardize_params = 'true'
    standardize_data = 'true'
    tune_parameters = 'covar1:signal_variance covar1:length_factor'
    num_iters = 700
    learning_rate = 0.001
    # show_every_nth_iteration = 2
    batch_size = 350
  []
  [GP_al_trainer2]
   type = ActiveLearningGaussianProcess
    covariance_function = 'covar2'
    standardize_params = 'true'
    standardize_data = 'true'
    tune_parameters = 'covar2:signal_variance covar2:length_factor'
    num_iters = 700
    learning_rate = 0.001
    # show_every_nth_iteration = 2
    batch_size = 350
  []
  [GP_al_trainer3]
   type = ActiveLearningGaussianProcess
    covariance_function = 'covar3'
    standardize_params = 'true'
    standardize_data = 'true'
    tune_parameters = 'covar3:signal_variance covar3:length_factor'
    num_iters = 700
    learning_rate = 0.001
    # show_every_nth_iteration = 2
    batch_size = 350
  []
  [GP_al_trainer4]
   type = ActiveLearningGaussianProcess
    covariance_function = 'covar4'
    standardize_params = 'true'
    standardize_data = 'true'
    tune_parameters = 'covar4:signal_variance covar4:length_factor'
    num_iters = 700
    learning_rate = 0.001
    # show_every_nth_iteration = 2
    batch_size = 350
  []
  [GP_al_trainer5]
   type = ActiveLearningGaussianProcess
    covariance_function = 'covar5'
    standardize_params = 'true'
    standardize_data = 'true'
    tune_parameters = 'covar5:signal_variance covar5:length_factor'
    num_iters = 700
    learning_rate = 0.001
    # show_every_nth_iteration = 2
    batch_size = 350
  []
[]

[Surrogates]
  [GP_eval1]
    type = GaussianProcessSurrogate
    trainer = GP_al_trainer1
  []
  [GP_eval2]
    type = GaussianProcessSurrogate
    trainer = GP_al_trainer2
  []
  [GP_eval3]
    type = GaussianProcessSurrogate
    trainer = GP_al_trainer3
  []
  [GP_eval4]
    type = GaussianProcessSurrogate
    trainer = GP_al_trainer4
  []
  [GP_eval5]
    type = GaussianProcessSurrogate
    trainer = GP_al_trainer5
  []
[]

[Covariance]
  # [covar]
  #   type = SquaredExponentialCovariance
  #   signal_variance = 4.0
  #   noise_variance = 1e-6
  #   length_factor = '1.0 1.0'
  # []

  [covar1]
    type = MaternHalfIntCovariance
    signal_variance = 4.0
    noise_variance = 1e-6
    length_factor = '10.0'
    p=1
  []

  [covar2]
    type = MaternHalfIntCovariance
    signal_variance = 4.0
    noise_variance = 1e-6
    length_factor = '10.0'
    p=1
  []

  [covar3]
    type = MaternHalfIntCovariance
    signal_variance = 4.0
    noise_variance = 1e-6
    length_factor = '10.0'
    p=1
  []

  [covar4]
    type = MaternHalfIntCovariance
    signal_variance = 4.0
    noise_variance = 1e-6
    length_factor = '10.0'
    p=1
  []
  [covar5]
    type = MaternHalfIntCovariance
    signal_variance = 4.0
    noise_variance = 1e-6
    length_factor = '10.0'
    p=1
  []
[]

[Executioner]
  type = Transient
  num_steps = 250
[]

[Outputs]
  file_base = 'al1'
  [out1_parallelAL]
    type = JSON
    execute_system_information_on = NONE
  []
[]
