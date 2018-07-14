rsvg_handle = nil
cairo_cs = nil
cairo_disp = nil
--------------------------------------------------------------------------------
--                                                               clock gate DATA
clock_center = { x = 960, y = 700 }
clock_gate_config = {
  radius_inner = 15,
  radius_outer = 100,
  angle = 60,
  color = colors.base00,
  alpha = 1,
  background_color = colors.base00,
}
clock_gate_elems = {

  -- inner circle ==============================================================
  {
    kind = 'ring',
    center = { x = clock_center.x, y = clock_center.y },
    radius = clock_gate_config.radius_inner,

    start_angle = 0,
    end_angle = 360,
    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'ring',
    center = { x = clock_center.x, y = clock_center.y },
    radius = clock_gate_config.radius_inner - 3,

    filled = true,
    start_angle = 0,
    end_angle = 360,
    color= colors.cyan,
    background_color= clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x,
      y = clock_center.y + clock_gate_config.radius_inner
    },
    to = {
      x = clock_center.x,
      y = clock_center.y + 170
    },

    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x,
      y = clock_center.y - clock_gate_config.radius_inner
    },
    to = {
      x = clock_center.x,
      y = clock_center.y - 170
    },

    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },

  -- outer circle ==============================================================
  {
    kind = 'ring',
    center = { x = clock_center.x, y = clock_center.y },
    radius = clock_gate_config.radius_outer,

    start_angle = -clock_gate_config.angle,
    end_angle = clock_gate_config.angle,
    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'ring',
    center = { x = clock_center.x, y = clock_center.y },
    radius = clock_gate_config.radius_outer,

    start_angle = 180 - clock_gate_config.angle,
    end_angle = 180 + clock_gate_config.angle,
    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x + math.cos( math.rad( -clock_gate_config.angle ) ) * clock_gate_config.radius_outer,
      y = clock_center.y + math.sin( math.rad( -clock_gate_config.angle ) ) * clock_gate_config.radius_outer
    },
    to = {
      x = clock_center.x + math.cos( math.rad( -clock_gate_config.angle ) ) * 170,
      y = clock_center.y + math.sin( math.rad( -clock_gate_config.angle ) ) * 170
    },

    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x + math.cos( math.rad( clock_gate_config.angle ) ) * clock_gate_config.radius_outer,
      y = clock_center.y + math.sin( math.rad( clock_gate_config.angle ) ) * clock_gate_config.radius_outer
    },
    to = {
      x = clock_center.x + math.cos( math.rad( clock_gate_config.angle ) ) * 170,
      y = clock_center.y + math.sin( math.rad( clock_gate_config.angle ) ) * 170
    },

    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x + math.cos( math.rad( 180 - clock_gate_config.angle ) ) * clock_gate_config.radius_outer,
      y = clock_center.y + math.sin( math.rad( 180 - clock_gate_config.angle ) ) * clock_gate_config.radius_outer
    },
    to = {
      x = clock_center.x + math.cos( math.rad( 180 - clock_gate_config.angle ) ) * 170,
      y = clock_center.y + math.sin( math.rad( 180 - clock_gate_config.angle ) ) * 170
    },

    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x + math.cos( math.rad( 180 + clock_gate_config.angle ) ) * clock_gate_config.radius_outer,
      y = clock_center.y + math.sin( math.rad( 180 + clock_gate_config.angle ) ) * clock_gate_config.radius_outer
    },
    to = {
      x = clock_center.x + math.cos( math.rad( 180 + clock_gate_config.angle ) ) * 170,
      y = clock_center.y + math.sin( math.rad( 180 + clock_gate_config.angle ) ) * 170
    },

    color = clock_gate_config.color,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },

  -- horizontal lights =========================================================
  {
    kind = 'line',
    from = {
      x = clock_center.x + clock_gate_config.radius_outer + 20,
      y = clock_center.y
    },
    to = {
      x = clock_center.x + 170,
      y = clock_center.y
    },
    color = colors.cyan,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  },
  {
    kind = 'line',
    from = {
      x = clock_center.x - clock_gate_config.radius_outer - 20,
      y = clock_center.y
    },
    to = {
      x = clock_center.x - 170,
      y = clock_center.y
    },
    color = colors.cyan,
    background_color = clock_gate_config.background_color,
    alpha = clock_gate_config.alpha
  }
}

--------------------------------------------------------------------------------
--                                                                 aperture DATA
apert_elems_config = {
  center = { x = 130, y = 870 },
  color = colors.base00,
  bg_color = colors.base00,
  alpha = 1,
  radius = 60
}
apert_elems = {
  {
    kind = 'aperture',
    center = { x = apert_elems_config.center.x, y = apert_elems_config.center.y },
    radius = apert_elems_config.radius,
    graduated = true,
    number_graduation = 7,
    angle_between_graduation=10,

    angle_to_vertex=20,
    rel_dist_to_vertex=0.7,

    start_angle = 20,
    end_angle = 340,
    color = apert_elems_config.color,
    background_color = apert_elems_config.bg_color,
    alpha = apert_elems_config.alpha
  },
  {
    kind = 'static_text',
    from = {x = apert_elems_config.center.x + 45, y = apert_elems_config.center.y + 10},
    text = 'APERTURE',
    color = apert_elems_config.color,
    font_size = 50,
    italic = true,
    bold = true
  },
  {
    kind = 'static_text',
    from = {x = apert_elems_config.center.x + 85, y = apert_elems_config.center.y + 40 },
    text = 'LABORATORIES',
    color = apert_elems_config.color,
    font_size = 30,
    --italic = true,
    --bold = true
  }
}


--------------------------------------------------------------------------------
--                                                             test chamber DATA
test_chamber_elems_config = {
  position = { x = 50, y = 50 },
  color = colors.base00,
  bg_color = colors.base00,
  alpha = 1,
}
test_chamber_elems = {
  {
    kind = 'box',
    from = {x = test_chamber_elems_config.position.x, y = test_chamber_elems_config.position.y},
    to = {x = test_chamber_elems_config.position.x + 470, y = test_chamber_elems_config.position.y + 900},
    color = test_chamber_elems_config.color,
    background_color = test_chamber_elems_config.bg_color,
    alpha = test_chamber_elems_config.alpha
  },
  {
    kind = 'line',
    from = {x = test_chamber_elems_config.position.x + 70, y = test_chamber_elems_config.position.y + 70},
    to = {x = test_chamber_elems_config.position.x + 450, y = test_chamber_elems_config.position.y + 70},

    thickness = 2,
    color = test_chamber_elems_config.color,
    background_color = test_chamber_elems_config.bg_color,
    alpha = test_chamber_elems_config.alpha
  },
  {
    kind = 'line',
    from = {x = test_chamber_elems_config.position.x + 70, y = test_chamber_elems_config.position.y + 400},
    to = {x = test_chamber_elems_config.position.x + 450, y = test_chamber_elems_config.position.y + 400},

    thickness = 2,
    color = test_chamber_elems_config.color,
    background_color = test_chamber_elems_config.bg_color,
    alpha = test_chamber_elems_config.alpha
  },
  {
    kind = 'line',
    from = {x = test_chamber_elems_config.position.x + 70, y = test_chamber_elems_config.position.y + 420},
    to = {x = test_chamber_elems_config.position.x + 250, y = test_chamber_elems_config.position.y + 420},

    graduated = true,
    number_graduation = 20,
    space_between_graduation = 2,
    thickness = 20,

    color = test_chamber_elems_config.color,
    background_color = test_chamber_elems_config.bg_color,
    alpha = test_chamber_elems_config.alpha
  },
  {
    kind = 'line',
    from = {x = test_chamber_elems_config.position.x + 70, y = test_chamber_elems_config.position.y + 520},
    to = {x = test_chamber_elems_config.position.x + 450, y = test_chamber_elems_config.position.y + 520},

    thickness = 2,


    color = test_chamber_elems_config.color,
    background_color = test_chamber_elems_config.bg_color,
    alpha = test_chamber_elems_config.alpha,
  }
}

--------------------------------------------------------------------------------
--                                                                    CUaTI DATA
CUaTI_elems_config = {
  position = { x = 1370, y = 50 },
  color = colors.base00,
  bg_color = colors.base00,
  alpha = 1,
}
CUaTI_elems = {
  {
    kind = 'box',
    from = {x = CUaTI_elems_config.position.x, y = CUaTI_elems_config.position.y},
    to = {x = CUaTI_elems_config.position.x + 530, y = CUaTI_elems_config.position.y + 900},

    color = CUaTI_elems_config.color,
    background_color = CUaTI_elems_config.bg_color,
    alpha = CUaTI_elems_config.alpha,
  },
  {
    kind = 'static_text',
    from = {x = CUaTI_elems_config.position.x + 30, y = CUaTI_elems_config.position.y + 830},
    text = 'Completely Unbiased and Truthful Information',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 26,
    italic = true,
    --bold = true
  },
  {
    kind = 'static_text',
    from = {x = CUaTI_elems_config.position.x + 30, y = CUaTI_elems_config.position.y + 850},
    text = '"Completely Unbiased and Truthful Information" is a trademark of Aperture Science and Aperture Laboratories',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 10,
    --italic = true,
    --bold = true
  },
  {
    kind = 'static_text',
    from = {x = CUaTI_elems_config.position.x + 30, y = CUaTI_elems_config.position.y + 865},
    text = 'All rights reserved',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 10,
    --italic = true,
    --bold = true
  },
  {
    kind = 'static_text',
    from = {x = CUaTI_elems_config.position.x + 120, y = CUaTI_elems_config.position.y + 880},
    text = 'SERVICE ANNOUNCEMENT',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 24,
    italic = true,
    --bold = true
  }
  --${goto 1400}${font Roboto Condensed:size=20:style=italic}Completely Unbiased and Truthful Information
  --${goto 1400}${voffset -14}${font Roboto Condensed:size=10}"CUaTI" is a trademark of Aperture Science and Aperture Laboratories
  --${goto 1400}${font Roboto Condensed:size=10}All rights reserved${font Roboto Condensed:size=20:style=italic} SERVICE ANNOUNCEMENT
}
