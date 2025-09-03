# created by write_diracs_input.py
[DiracKernels]
  [source_8_3_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_3
    point = '53.8865543998 225.4920635023 373.2999856190'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_8_4_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_4
    point = '-13.3484490202 218.2456800420 404.5581304535'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
  [source_10_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_10
    point = '-45.5934589398 214.7704112881 419.5491193579'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
[]
