# created by write_frac_materials_input.py
# see Materials Property section in porous flow notes: 
# https://mooseframework.inl.gov/modules/porous_flow/multiapp_fracture_flow_PorousFlow_3D.html 
# DFN from fname 
all_frac_ids = "fracture1 fracture2 fracture3 "

frac_aperture_1 = ${frac_aperature_1}
frac_aperture_2 = ${frac_aperature_2}
frac_aperture_3 = ${frac_aperature_3}

frac_roughness_1 = ${frac_roughness}
frac_roughness_2 = ${frac_roughness}
frac_roughness_3 = ${frac_roughness}

log_slope_at_midpoint = -2.12849404

one_over_bulk = 1.4e-11 #bulk modulus = 70GPa

[AuxVariables]
  # [aperture_fracture1]
  #   order = CONSTANT
  #   family = MONOMIAL
  # []
  # [aperture_fracture2]
  #   order = CONSTANT
  #   family = MONOMIAL
  # []
  [aperture_fracture3]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[AuxKernels]
  [aperture_fracture3]
    type=CapsuleApertureAux
    variable = aperture_fracture3
    start_point ='-45.5934589398 214.7704112881 419.5491193579'
    end_point ='-45.5934589398 214.7704112881 519.5491193579'
    a_max = ${frac_aperture_3}
    a_min = ${fparse frac_aperture_3/10}
    midpoint_of_sigmoid = 47.14586926
    slope_at_midpoint = ${fparse 10^log_slope_at_midpoint}
    block = 'fracture1'
    execute_on = 'INITIAL'
  []

  # [aperture_fracture2]
  #   type=CapsuleApertureAux
  #   variable = aperture_fracture2
  #   start_point ='3.3320105757 220.0434490667 396.8032379804'
  #   end_point ='3.3320105757 220.0434490667 496.8032379804'
  #   a_max = ${frac_aperture_2}
  #   a_min = ${fparse frac_aperture_2/10}
  #   midpoint_of_sigmoid = 1.4138057349e+01
  #   slope_at_midpoint = 9.9578287020e-01
  #   block = 'fracture2'
  #   execute_on = 'INITIAL'
  # []

  # [aperture_fracture1]
  #   type=CapsuleApertureAux
  #   variable = aperture_fracture1
  #   start_point ='10.5909799924 220.8257986353 393.4284792113'
  #   end_point ='10.5909799924 220.8257986353 493.4284792113'
  #   a_max = ${frac_aperture_1}
  #   a_min = ${fparse frac_aperture_1/10}
  #   midpoint_of_sigmoid = 7.3867538406e+01
  #   slope_at_midpoint = 8.4752947300e-01
  #   block = 'fracture1'
  #   execute_on = 'INITIAL'
  # []
[]

[Materials]
  [porosity_fracture1]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_1} #aperture_fracture1
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_1/10}
    block = fracture3
  []
  [porosity_fracture2]
    type = PorousFlowPorosityLinear
    porosity_ref = ${frac_aperture_2} #aperture_fracture2
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_2/10}
    block = fracture2
  []
  [porosity_fracture3]
    type = PorousFlowPorosityLinear
    porosity_ref = aperture_fracture3 #aperture_fracture3
    P_ref = insitu_pp
    P_coeff = ${one_over_bulk}
    porosity_min = ${fparse frac_aperture_3/10}
    block = fracture1
  []
  [permeability_fracture1]
    type = PorousFlowPermeabilityKozenyCarman
    poroperm_function = kozeny_carman_A
    A = '${fparse frac_roughness_1/12}'
    m = 0
    n = 3
    block = fracture1
  []
  
  [permeability_fracture2]
    type = PorousFlowPermeabilityKozenyCarman
    poroperm_function = kozeny_carman_A
    A = '${fparse frac_roughness_2/12}'
    m = 0
    n = 3
    block = fracture2
  []
  [permeability_fracture3]
    type = PorousFlowPermeabilityKozenyCarman
    poroperm_function = kozeny_carman_A
    A = '${fparse frac_roughness_3/12}'
    m = 0
    n = 3
    block = fracture3
  []

  [rock_internal_energy_fracture]
    type = PorousFlowMatrixInternalEnergy
    density = 2500
    specific_heat_capacity = 100.0
    block = ${all_frac_ids}
  []

  [thermal_conductivity_fracture]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '3 0 0 0 3 0 0 0 3'
    block = ${all_frac_ids}
  []
[]
