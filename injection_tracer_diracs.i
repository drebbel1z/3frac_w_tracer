# created by write_diracs_input.py
[DiracKernels]
  [source_8_3_tracer]
    type = PorousFlowSquarePulsePointSource
    variable = C
    mass_flux = ${fparse inj_ratio_stage_8_3*tracer_flux_src}
    point = '10.5909799924 220.8257986353 393.4284792113'
    start_time = ${tracer_start_time}
    end_time = ${tracer_end_time}
    point_not_found_behavior = WARNING
  []
  [source_8_4_tracer]
    type = PorousFlowSquarePulsePointSource
    variable = C
    mass_flux = ${fparse inj_ratio_stage_8_4*tracer_flux_src}
    point = '3.3320105757 220.0434490667 396.8032379804'
    start_time = ${tracer_start_time}
    end_time = ${tracer_end_time}
    point_not_found_behavior = WARNING
  []
  [source_10_tracer]
    type = PorousFlowSquarePulsePointSource
    variable = C
    mass_flux = ${fparse inj_ratio_stage_10*tracer_flux_src}
    point = '-83.6358901331 210.6703141636 437.2353804364'
    start_time = ${tracer_start_time}
    end_time = ${tracer_end_time}
    point_not_found_behavior = WARNING
  []
[]
