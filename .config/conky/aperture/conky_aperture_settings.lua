
--------------------------------------------------------------------------------
--                                                                    gauge DATA
gauge = {
{
    name='memperc',                arg='',                      max_value=100,
    x=300,                          y=150,
    graph_radius=75,
    graph_thickness=8,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.5,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=52,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=71,
    graduation_thickness=13,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.5,
    caption='MEM',
    caption_weight=1,              caption_size=14.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
    icon='',
    critical_threshold=80,          critical_text_color=0xdc322f,
    critical_compare='greater'
},
{
    name='fs_used_perc',           arg='/',                     max_value=100,
    x=400,                          y=450,
    graph_radius=75,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.5,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=85,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='root',
    caption_weight=1,              caption_size=14.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.4,
    icon='',
    critical_threshold=90,          critical_text_color=0xdc322f,
    critical_compare='greater'
},
{
    name='fs_used_perc',           arg='/home/',                max_value=100,
    x=400,                          y=450,
    graph_radius=67,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.5,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=53,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='/home',
    caption_weight=1,              caption_size=14.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.4,
    icon='',
    critical_threshold=90,          critical_text_color=0xdc322f,
    critical_compare='greater'
},
{
    name='wireless_link_qual_perc',           arg='wlp3s0',                max_value=100,
    x=960 + 660,                          y=150,
    graph_radius=75,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.5,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=58,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption={"wireless_essid", "wireless_ap"},
    caption_weight=1,              caption_size=14.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.4,
    icon='',
    critical_threshold=50,          critical_text_color=0xdc322f,
    critical_compare='less'
},
{
    name='battery_percent',           arg='',                max_value=100,
    --battery_time, battery (status and remaining perc), battery_short (same as battery, short status)
    x=1920-400,                          y=450,
    graph_radius=75,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.5,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=85,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption="batt",
    caption_weight=1,              caption_size=14.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.4,
    icon='   ',
    critical_threshold=25,          critical_text_color=0xdc322f,
    critical_compare='less'
},
{
    name='acpitemp',           arg='',                max_value=100,
    x=1920-400,                          y=450,
    graph_radius=67,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.5,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=53,
    txt_weight=0,                  txt_size=16.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption="temp",
    caption_weight=1,              caption_size=14.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.4,
    icon='',
    critical_threshold=80,          critical_text_color=0xdc322f,
    critical_compare='greater'
},

}

--------------------------------------------------------------------------------
--                                                                    clock DATA
clock_center = { x = 960, y = 700 }
-- HOURS
clock_h = {
    {
    name='time',                   arg='%H',                    max_value=12,
    x=clock_center.x,              y=clock_center.y,
    graph_radius=195,
    graph_thickness=5,
    graph_unit_angle=30,           graph_unit_thickness=30,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.0,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    txt_radius=155,
    txt_weight=1,                  txt_size=24.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=195,
    graduation_thickness=6,        graduation_mark_thickness=2,
    graduation_unit_angle=30,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    },
}
-- MINUTES
clock_m = {
    {
    name='time',                   arg='%M',                    max_value=60,
    x=clock_center.x,              y=clock_center.y,
    graph_radius=205,
    graph_thickness=3,
    graph_unit_angle=6,            graph_unit_thickness=6,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.1,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.3,
    txt_radius=225,
    txt_weight=0,                  txt_size=20.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=205,
    graduation_thickness=1,        graduation_mark_thickness=2,
    graduation_unit_angle=30,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    },
}
-- SECONDS
clock_s = {
    {
    name='time',                   arg='%S',                    max_value=60,
    x=clock_center.x,              y=clock_center.y,
    graph_radius=185,
    graph_thickness=2,
    graph_unit_angle=6,            graph_unit_thickness=2,
    graph_bg_colour=0xffffff,      graph_bg_alpha=0.0,
    graph_fg_colour=0xFFFFFF,      graph_fg_alpha=0.2,
    txt_radius=178,
    txt_weight=0,                  txt_size=14.0,
    txt_fg_colour=0xb58900,        txt_fg_alpha=1.0,
    graduation_radius=0,
    graduation_thickness=0,        graduation_mark_thickness=0,
    graduation_unit_angle=0,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.0,
    },
}

--------------------------------------------------------------------------------
--                                                       test_chamber_icons DATA

test_chamber_icons_config = {
    box = {
      kind = 'box',
      from = {x = test_chamber_elems_config.position.x, y = test_chamber_elems_config.position.y},
      to = {x = test_chamber_elems_config.position.x + 56, y = test_chamber_elems_config.position.y + 56},
      color = colors.red,
      background_color = colors.red,
      alpha = test_chamber_elems_config.alpha
    },
    icon_coords = {
      wlan = {x=75, y = 550},
      disk = {x=75 + 63, y = 613},
      swap = {x=75 + 2 * 63, y = 550},
      mem = {x=75 + 3 * 63, y = 613},
      batt = {x=75 + 4 * 63, y = 550},
      temp = {x=75 + 5 * 63, y = 613}
    }
}

test_chamber = {

}

function deep_copy( obj )
    local ret = {}
    for i, v in pairs( obj ) do
        if type( v ) == "table" then
          local tmp = {}
          for j, vv in pairs( v ) do
            tmp[j] = vv
          end
          ret[i] = tmp
        else
          ret[i] = v
        end
    end
    return ret
end

function fill_test_chamber_icons()
    for i, v in pairs( test_chamber_icons_config.icon_coords ) do
        local box = deep_copy( test_chamber_icons_config.box )
        box.from.x = box.from.x + v.x
        box.to.x = box.to.x + v.x
        box.from.y = box.from.y + v.y
        box.to.y = box.to.y + v.y
        test_chamber[i] = box
    end
end


--------------------------------------------------------------------------------
--                                                   test_chamber_icons_text DATA

-- ${voffset -178}
-- ${goto 194}${color2}${font Roboto Condensed:size=28}${wireless_link_qual_db wlp3s0}${offset +90}${swapperc}${offset +90}${battery_percent}
-- ${voffset +17}${goto 194}${fs_used_perc /}${offset +90}${memperc}${offset +90}${acpitemp}
test_chamber_icons_text = {
  {
    kind = 'variable_text',
    from = {x = 198, y = 641},
    conky_value = 'wireless_link_qual_perc wlp3s0',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 34,
    italic = false,
    bold = false,
    format = '%02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },
  {
    kind = 'variable_text',
    from = {x = 326, y = 641},
    conky_value = 'swapperc',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 34,
    italic = false,
    bold = false,
    format = '%02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },
  {
    kind = 'variable_text',
    from = {x = 450, y = 641},
    conky_value = 'battery_percent',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 34,
    italic = false,
    bold = false,
    format = '%02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },
  {
    kind = 'variable_text',
    from = {x = 196, y = 688},
    conky_value = 'fs_used_perc /',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 24,
    italic = false,
    bold = false,
    format = 'R %02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },
  {
    kind = 'variable_text',
    from = {x = 196, y = 710},
    conky_value = 'fs_used_perc /home',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 24,
    italic = false,
    bold = false,
    format = 'H %02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },

  {
    kind = 'variable_text',
    from = {x = 326, y = 702},
    conky_value = 'memperc',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 34,
    italic = false,
    bold = false,
    format = '%02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },
  {
    kind = 'variable_text',
    from = {x = 450, y = 702},
    conky_value = 'acpitemp',
    color = apert_elems_config.color,
    font = 'Roboto Condensed',
    font_size = 34,
    italic = false,
    bold = false,
    format = '%02i',
    is_number = true,
    lo = 0,
    hi = 99,
  },

}


