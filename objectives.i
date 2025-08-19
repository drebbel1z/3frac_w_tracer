end_time_for_pressure_match = ${endTime}
start_time_for_pressure_match = 247001
start_time_for_tracer_match = ${tracer_start_time}
end_time_for_tracer_match = ${fparse tracer_start_time+100000}
eps = 1e-10

[Postprocessors]
    # relative pressure at 16A
  [relative_pressure_16a]
    type = FunctionValuePostprocessor
    function = 'relative_pressure_16a'
  []

  [relative_pressure_16a_sq]
    type = ParsedPostprocessor
    expression = 'if(t<=${end_time_for_pressure_match} & t>=${start_time_for_pressure_match},(relative_pressure_16a)^2,0)'
    pp_names = 'relative_pressure_16a'
    use_t= true
  []

  [integrated_relative_pressure_16a_sq]
    type = TimeIntegratedPostprocessor
    value = relative_pressure_16a_sq
  []
  
  [L2_diff_pressure_8_3]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=${end_time_for_pressure_match} & t>=${start_time_for_pressure_match},(relative_pressure_16a-p_in_8_3)^2,0)'
    pp_names = 'relative_pressure_16a p_in_8_3'
    use_t= true
  []

  [integrated_L2_diff_pressure_8_3]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_8_3
  []

  [L2_diff_pressure_8_4]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=${end_time_for_pressure_match} & t>=${start_time_for_pressure_match},(relative_pressure_16a-p_in_8_4)^2,0)'
    pp_names = 'relative_pressure_16a p_in_8_4'
    use_t= true
  []

  [integrated_L2_diff_pressure_8_4]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_8_4
  []

  [L2_diff_pressure_10]
    # matching only the first 3.5 days for pressure
    type = ParsedPostprocessor
    expression = 'if(t<=${end_time_for_pressure_match} & t>=${start_time_for_pressure_match},(relative_pressure_16a-p_in_10)^2,0)'
    pp_names = 'relative_pressure_16a p_in_10'
    use_t= true
  []

  [integrated_L2_diff_pressure_10]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_10
  []

  [relative_pressure_well_58]
    type = FunctionValuePostprocessor
    function = 'relative_pressure_well_58'
  []

  [relative_pressure_well_58_sq]
    type = ParsedPostprocessor
    expression = 'if(t<=${endTime},(relative_pressure_well_58)^2,0)'
    pp_names = 'relative_pressure_well_58'
    use_t= true
  []

  [integrated_relative_pressure_well_58_sq]
    type = TimeIntegratedPostprocessor
    value = relative_pressure_well_58_sq
  []

  ##########################
  ##########################
  # compute the squared difference between the sim curve and the exp curve
  # at well 58
  [L2_diff_pressure_well_58]
    type = ParsedPostprocessor
    expression = 'if(t<=${endTime},(relative_pressure_well_58-p_well_58_bottom)^2,0)'
    pp_names = 'relative_pressure_well_58 p_well_58_bottom'
    use_t= true
  []

  [integrated_L2_diff_pressure_well_58]
    type = TimeIntegratedPostprocessor
    value = L2_diff_pressure_well_58
  []

    # fluid recovery rate
  [mass_rate]
    type = FunctionValuePostprocessor
    function = 'mass_rate'
  []

  [mass_rate_sq]
    type = ParsedPostprocessor
    expression = 'if(t<=${end_time_for_pressure_match} & t>=${start_time_for_pressure_match},((${inj_ratio_stage_10}+${inj_ratio_stage_8_4}+${inj_ratio_stage_8_3})*mass_rate)^2,0)'
    pp_names = 'mass_rate'
    use_t= true
  []

  [integrated_mass_rate_sq]
    type = TimeIntegratedPostprocessor
    value = mass_rate_sq
  []

  [L2_diff_mass_rate]
    # right now, match mass rate that will be 2 when projected to 20 days
    type = ParsedPostprocessor
    expression = 'if(t<=${end_time_for_pressure_match} & t>=${start_time_for_pressure_match},(fluid_report/a1_dt/2.65 - (${inj_ratio_stage_10}+${inj_ratio_stage_8_4}+${inj_ratio_stage_8_3})*mass_rate)^2,0)'
    pp_names = 'fluid_report a1_dt mass_rate'
    use_t= true
  []

  [integrated_L2_diff_mass_rate]
    type = TimeIntegratedPostprocessor
    value = L2_diff_mass_rate
  []


  #tracer mass rate
  [normalized_exp_tracer_rate]
    type = FunctionValuePostprocessor
    function = 'normalized_exp_tracer_rate'
  [] 

  [normalized_exp_tracer_rate_sq]
    type = ParsedPostprocessor
    expression = 'if(t>${end_time_for_tracer_match} | t<${start_time_for_tracer_match},0,normalized_exp_tracer_rate*normalized_exp_tracer_rate)'
    pp_names = 'normalized_exp_tracer_rate'
    use_t= true
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [normalized_exp_tracer_rate_sq_integrated]
    type = TimeIntegratedPostprocessor
    value = normalized_exp_tracer_rate_sq
    # execute_on = 'timestep_end'
    # outputs = none
  []


  [sim_tracer_rate]
    type = ParsedPostprocessor
    expression = 'tracer_report / a1_dt'
    pp_names = 'tracer_report a1_dt'
    # execute_on = 'timestep_end'
  []
  
  [sim_tracer_rate_sq]
    type = ParsedPostprocessor
    expression = 'if(t>${end_time_for_tracer_match} | t<${start_time_for_tracer_match},0,sim_tracer_rate*sim_tracer_rate)'
    pp_names = 'sim_tracer_rate'
    use_t= true
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [sim_tracer_rate_sq_integrated]
    type = TimeIntegratedPostprocessor
    value = sim_tracer_rate_sq
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [exp_sim_tracer_rate]
    type = ParsedPostprocessor
    expression = 'if(t>${end_time_for_tracer_match} | t<${start_time_for_tracer_match},0,normalized_exp_tracer_rate*sim_tracer_rate)'
    pp_names = 'normalized_exp_tracer_rate sim_tracer_rate'
    use_t= true
    # execute_on = 'timestep_end'
    # outputs = none
  []
  [exp_sim_tracer_rate_integrated]
    type = TimeIntegratedPostprocessor
    value = exp_sim_tracer_rate
    # execute_on = 'timestep_end'
    # outputs = none
  []

  [tracer_rate_max]
    type = TimeExtremeValue
    postprocessor = sim_tracer_rate
    # outputs = none
  []

  [integrated_L2_diff_tracer_rate]
    type = ParsedPostprocessor
    expression = 'normalized_exp_tracer_rate_sq_integrated
                   -2*exp_sim_tracer_rate_integrated/(tracer_rate_max+${eps})
                   +sim_tracer_rate_sq_integrated/(tracer_rate_max+${eps})/(tracer_rate_max+${eps})'
    pp_names = 'normalized_exp_tracer_rate_sq_integrated sim_tracer_rate_sq_integrated exp_sim_tracer_rate_integrated tracer_rate_max'
    # execute_on = 'timestep_end'
  []

  [well_16A_pressure_curve_8_3]
    type =ParsedPostprocessor
    expression ='if(t=${endTime}, -10*integrated_L2_diff_pressure_8_3/(integrated_relative_pressure_16a_sq+${eps}),-10^2)'
    pp_names = 'integrated_L2_diff_pressure_8_3 integrated_relative_pressure_16a_sq'
    use_t = true
  []

  [well_16A_pressure_curve_8_4]
    type =ParsedPostprocessor
    expression ='if(t=${endTime}, -10*integrated_L2_diff_pressure_8_4/(integrated_relative_pressure_16a_sq+${eps}),-10^2)'
    pp_names = 'integrated_L2_diff_pressure_8_4 integrated_relative_pressure_16a_sq'
    use_t = true
  []

  [well_16A_pressure_curve_10]
    type =ParsedPostprocessor
    expression ='if(t=${endTime}, -10*integrated_L2_diff_pressure_10/(integrated_relative_pressure_16a_sq+${eps}),-10^2)'
    pp_names = 'integrated_L2_diff_pressure_10 integrated_relative_pressure_16a_sq'
    use_t = true
  []

  [mass_rate_curve]
    type =ParsedPostprocessor
    expression ='if(t=${endTime}, -10*integrated_L2_diff_mass_rate/(integrated_mass_rate_sq+${eps}),-10^2)'
    pp_names = 'integrated_L2_diff_mass_rate integrated_mass_rate_sq'
    use_t = true
  []

  [normalized_tracer_curve]
    type =ParsedPostprocessor
    expression ='if(t=${endTime}, -10*integrated_L2_diff_tracer_rate/(normalized_exp_tracer_rate_sq_integrated+${eps}),-10^2)'
    pp_names = 'integrated_L2_diff_tracer_rate normalized_exp_tracer_rate_sq_integrated'
    use_t = true
  []

  [well_58_pressure_curve]
    type =ParsedPostprocessor
    expression ='if(t=${endTime}, -10*integrated_L2_diff_pressure_well_58/(integrated_relative_pressure_well_58_sq+${eps}),-10^2)'
    pp_names = 'integrated_L2_diff_pressure_well_58 integrated_relative_pressure_well_58_sq'
    use_t = true
  []

[]

[VectorPostprocessors]
  [objective_functions]
    type = VectorOfPostprocessors
    postprocessors = 'well_16A_pressure_curve_8_3 well_16A_pressure_curve_8_4 well_16A_pressure_curve_10 mass_rate_curve normalized_tracer_curve' # 
    outputs = none
  []
[]

[Functions]
  [relative_pressure_16a]
    type = PiecewiseLinear
    data_file = relative_pressure_well_16A.csv
    format ="columns"
  []

  [relative_pressure_well_58]
    type = PiecewiseLinear
    data_file = relative_pressure_well_58.csv
    format ="columns"
  []

  [mass_rate]
    type = PiecewiseLinear
    data_file = mass_rate.csv
    format ="columns"
  []

  [normalized_exp_tracer_rate]
    type = PiecewiseLinear
    data_file = normalized_tracer_rate.csv
    format ="columns"
  []
[]


















  
  

  