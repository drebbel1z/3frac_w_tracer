# created by write_diracs_input.py
[DiracKernels]
  [source_8_3_h]
    type = PorousFlowPointEnthalpySourceFromPostprocessor
    variable = temperature
    mass_flux = mass_flux_src_stage_8_3
    point = '10.5909799924 220.8257986353 393.4284792113'
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
    point = '3.3320105757 220.0434490667 396.8032379804'
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
    point = '-83.6358901331 210.6703141636 437.2353804364'
    T_in = inject_T
    pressure = porepressure
    fp = tabulated_water
    point_not_found_behavior = WARNING
    # block = 100
  []
[]
