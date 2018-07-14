--==============================================================================
--                                 conky_stats.lua
--                              adapted from conky_grey.lua
--
--  author  : SLK, Braitex
--  version : v2011062101
--  license : Distributed under the terms of GNU GPL version 2 or later
--
--==============================================================================

require 'cairo'
require 'conky_draw'
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
-- HOURS
clock_h = {
    {
    name='time',                   arg='%H',                    max_value=12,
    x=960,                         y=260,
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
    x=960,                         y=260,
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
    x=960,                         y=260,
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

-------------------------------------------------------------------------------
--                                                                 rgb_to_r_g_b
-- converts color in hexa to decimal
--
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-------------------------------------------------------------------------------
--                                                            angle_to_position
-- convert degree to rad and rotate (0 degree is top/north)
--
function angle_to_position(start_angle, current_angle)
    local pos = current_angle + start_angle
    return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
end

-------------------------------------------------------------------------------
--                                                              draw_gauge_ring
-- displays gauges
--
function draw_gauge_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_start_angle = data['graph_start_angle']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']
    local hand_fg_colour, hand_fg_alpha = data['hand_fg_colour'], data['hand_fg_alpha']
    local graph_end_angle = (max_value * graph_unit_angle) % 360

    -- background ring
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, 0), angle_to_position(graph_start_angle, graph_end_angle))
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = value % (max_value + 1)
    local start_arc = 0
    local stop_arc = 0
    local i = 1
    while i <= val do
        start_arc = (graph_unit_angle * i) - graph_unit_thickness
        stop_arc = (graph_unit_angle * i)
        cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
        cairo_set_source_rgba(display, rgb_to_r_g_b(graph_fg_colour, graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = start_arc

    -- hand
    start_arc = (graph_unit_angle * val) - (graph_unit_thickness * 2)
    stop_arc = (graph_unit_angle * val)
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
    cairo_set_source_rgba(display, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
    cairo_stroke(display)

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = graph_end_angle / graduation_unit_angle
        local i = 0
        while i < nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            start_arc = (graduation_unit_angle * i) - (graduation_mark_thickness / 2)
            stop_arc = (graduation_unit_angle * i) + (graduation_mark_thickness / 2)
            cairo_arc(display, x, y, graduation_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, angle))
    local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, angle))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight)
    cairo_set_font_size (display, txt_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3)
    cairo_show_text (display, value)
    cairo_stroke (display)

    -- caption
    local caption = data['caption']
    if type(caption) == 'table' then
        --local cap_array = caption
        --local w_interface = data['arg']
        --caption = ""
        --for _, cap_part in ipairs(cap_array) do
            --caption = string.format("%s\n%s", caption, cap_part)
            --caption = string.format("%s\n%s", caption, conky_parse( string.format('${%s %s}', cap_part, w_interface) ) )
        --end
        caption = tostring( conky_parse( string.format('${%s %s}', caption[1], data['arg']) ) )
    end
    local caption_weight, caption_size = data['caption_weight'], data['caption_size']
    local caption_fg_colour, caption_fg_alpha = data['caption_fg_colour'], data['caption_fg_alpha']
    local tox = graph_radius * (math.cos((graph_start_angle * 2 * math.pi / 360)-(math.pi/2))) * 1.05
    local toy = graph_radius * (math.sin((graph_start_angle * 2 * math.pi / 360)-(math.pi/2))) * 1.05
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, caption_weight);
    cairo_set_font_size (display, caption_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(caption_fg_colour, caption_fg_alpha))
    cairo_move_to (display, x + tox + 5, y + toy + 1)
    -- bad hack but not enough time !
    if graph_start_angle < 105 then
        cairo_move_to (display, x + tox - 30, y + toy + 1)
    end
    cairo_show_text (display, caption)
    cairo_stroke (display)
end

-------------------------------------------------------------------------------
--                                                                    draw_icon

function draw_icon(display, data, value)
    cairo_select_font_face (display, "font awesome", CAIRO_FONT_SLANT_NORMAL, 1.0);
    cairo_set_font_size( display, 24 )
    value = (value + 0)
    if data['critical_threshold'] ~= nil and value ~= nil then
      local invert = data['critical_compare'] == 'greater'
      if ( value < data['critical_threshold'] ) ~= invert then
        cairo_set_source_rgba (display, rgb_to_r_g_b(data['critical_text_color'], 1.0))
      else
        cairo_set_source_rgba (display, rgb_to_r_g_b(0x839496, 1.0))
      end
    end
    cairo_move_to( display, data['x'] - 10, data['y'] + 10 )
    cairo_show_text( display, data['icon'] )
    cairo_stroke( display )
end

-------------------------------------------------------------------------------
--                                                              print_net_stats

function print_net_stats(display, data)

    local str, addr, up, down, value = '', '', '', '', 0

    str = string.format('${%s %s}', 'addr', data['arg'])
    addr = conky_parse(str)

    str = string.format('${%s %s}', 'upspeedf', data['arg'])
    up = conky_parse(str)

    str = string.format('${%s %s}', 'downspeedf', data['arg'])
    dn = conky_parse(str)
--
    local updown = string.format( '%s     %s', '', '' )
    local updownval = string.format( '    %s     %s', dn, up )

    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, 1.0);
    cairo_set_font_size( display, 16 )
    cairo_set_source_rgba (display, rgb_to_r_g_b(0xFFFFFF, 0.3))
    cairo_move_to( display, data['x'] + 5, data['y'] + 60 )
    cairo_show_text( display, addr )
    cairo_move_to( display, data['x'] + 5, data['y'] + 40 )
    cairo_show_text( display, updownval )
    cairo_select_font_face (display, "font awesome", CAIRO_FONT_SLANT_NORMAL, 1.0);
    cairo_move_to( display, data['x'] + 5, data['y'] + 40 )
    cairo_show_text( display, updown )
    cairo_stroke( display )
end

-------------------------------------------------------------------------------
--                                                               go_gauge_rings
-- loads data and displays gauges
--
function go_gauge_rings(display)
    local function load_gauge_rings(display, data)
        local str, value = '', 0
        str = string.format('${%s %s}',data['name'], data['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        draw_gauge_ring(display, data, value)
        return value
      end

    for i in pairs(gauge) do
        local value = load_gauge_rings(display, gauge[i])
        draw_icon(display, gauge[i], value)
    end

    print_net_stats( display, gauge[4] )

end


-------------------------------------------------------------------------------
--                                                               draw_aperture

function draw_aperture( cr )
  local elems = {
    {
      kind = 'aperture',
      center = {x = 960, y = 700},
      radius = 120,
      graduated = true,
      number_graduation=7,
      angle_between_graduation=10,

      angle_to_vertex=20,
      rel_dist_to_vertex=0.7,

      start_angle = 20,
      end_angle = 340,
      color= 0xFFFFFF,
      background_color= 0xFFFFFF,
    },
    {
      kind = 'static_text',
      from = {x = 960 + 105, y = 700},
      text = 'APERTURE',
      color = 0x839496,
      font_size = 60,
      italic = true,
      bold = true
    },
    {
      kind = 'static_text',
      from = {x = 960 + 125, y = 700 + 40 },
      text = 'LABORATORIES',
      color = 0x839496,
      font_size = 40,
      --italic = true,
      --bold = true
    }
  }
  check_requirements(elems)
  fill_defaults(elems)
  for i, elem in pairs(elems) do
    elem.draw_function(cr, elem)
  end
end


-------------------------------------------------------------------------------
--                                                               draw_cpu_radar

function draw_cpu_radar( cr )

    -- CPU GRAPH
    -- Non-linear (sqrt instead) so graph area approximatly matches usage

    local cx,cy = 960,700
    local radius = 75


    local half_radius = 0.05 + radius * math.sqrt(0.5) * 0.95
    local sqrt05r = math.sqrt(0.5) * radius
    local sqrt05r_1 = (1 - math.sqrt(0.5)) * radius
    local sqrt05hr = math.sqrt(0.5) * half_radius
    local sqrt05hr_1 = (1 - math.sqrt(0.5)) * half_radius

    cairo_set_source_rgba(cr, 0.701, 0.537, 0, 1)
    local cpu1 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu1}")) / 100.0) * 0.95
    local cpu2 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu2}")) / 100.0) * 0.95
    local cpu3 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu3}")) / 100.0) * 0.95
    local cpu4 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu4}")) / 100.0) * 0.95
    local cpu5 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu5}")) / 100.0) * 0.95
    local cpu6 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu6}")) / 100.0) * 0.95
    local cpu7 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu7}")) / 100.0) * 0.95
    local cpu8 = 0.05 + math.sqrt(tonumber(conky_parse("${cpu cpu8}")) / 100.0) * 0.95

    -- draw cpu usage
    cairo_set_line_width(cr, 1)
    cairo_move_to(cr, cx, cy + radius * cpu1)
    cairo_line_to(cr, cx + sqrt05r * cpu2, cy + sqrt05r * cpu2)
    cairo_line_to(cr, cx + radius * cpu3, cy)
    cairo_line_to(cr, cx + sqrt05r * cpu4, cy - sqrt05r * cpu4)

    cairo_line_to(cr, cx, cy - radius * cpu5)
    cairo_line_to(cr, cx - sqrt05r * cpu6, cy - sqrt05r * cpu6)
    cairo_line_to(cr, cx - radius * cpu7, cy)
    cairo_line_to(cr, cx - sqrt05r * cpu8, cy + sqrt05r * cpu8)
    cairo_fill(cr)

    -- draw numbers
    --cairo_set_font_size(cr, 20)
    --cairo_move_to(cr, cx - 5, cy - radius - 5)
    --cairo_show_text(cr, 0)
    --cairo_move_to(cr, cx + radius + 5, cy + 6)
    --cairo_show_text(cr, 3)
    --cairo_move_to(cr, cx - 5, cy + radius + 21)
    --cairo_show_text(cr, 5)
    --cairo_move_to(cr, cx - radius - 14, cy + 6)
    --cairo_show_text(cr, 7)

    -- draw outer contour
    cairo_set_source_rgba(cr, 0.933,0.905,0.894,0.4)
    cairo_set_line_width(cr, 2)
    cairo_move_to(cr, 	cx, cy - radius )
    cairo_rel_line_to(cr, sqrt05r,	sqrt05r_1 )
    cairo_rel_line_to(cr, sqrt05r_1,	sqrt05r )
    cairo_rel_line_to(cr, - sqrt05r_1,	sqrt05r )
    cairo_rel_line_to(cr, - sqrt05r,	sqrt05r_1 )
    cairo_rel_line_to(cr, - sqrt05r,	- sqrt05r_1 )
    cairo_rel_line_to(cr, - sqrt05r_1,	- sqrt05r )
    cairo_rel_line_to(cr, sqrt05r_1,	- sqrt05r )
    cairo_rel_line_to(cr, sqrt05r,	- sqrt05r_1 )
    cairo_stroke(cr)

    -- draw inner countour
    cairo_move_to(cr, cx, cy - half_radius)
     cairo_rel_line_to(cr, sqrt05hr,	sqrt05hr_1 )
    cairo_rel_line_to(cr, sqrt05hr_1,	sqrt05hr )
    cairo_rel_line_to(cr, - sqrt05hr_1,	sqrt05hr )
    cairo_rel_line_to(cr, - sqrt05hr,	sqrt05hr_1 )
    cairo_rel_line_to(cr, - sqrt05hr,	- sqrt05hr_1 )
    cairo_rel_line_to(cr, - sqrt05hr_1,	- sqrt05hr )
    cairo_rel_line_to(cr, sqrt05hr_1,	- sqrt05hr )
    cairo_rel_line_to(cr, sqrt05hr,	- sqrt05hr_1 )

    cairo_stroke(cr)

    -- draw axes
    -- vertical
    cairo_move_to(cr, cx + radius, cy)
    cairo_rel_line_to(cr, - 2*radius, 0)
    cairo_stroke(cr)

    -- horizontal
    cairo_move_to(cr, cx, cy + radius)
    cairo_rel_line_to(cr, 0, - 2*radius)
    cairo_stroke(cr)

    -- r-l diagonal
    cairo_move_to(cr, cx + sqrt05r, cy + sqrt05r)
    cairo_rel_line_to(cr, - 2*sqrt05r, - 2*sqrt05r)
    cairo_stroke(cr)

    -- l-r diagonal
    cairo_move_to(cr, cx - sqrt05r, cy + sqrt05r)
    cairo_rel_line_to(cr, 2*sqrt05r, - 2*sqrt05r)
    cairo_stroke(cr)

end

-------------------------------------------------------------------------------
--                                                              draw_clock_ring
-- displays clock
--
function draw_clock_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']

    -- background ring
    cairo_arc(display, x, y, graph_radius, 0, 2 * math.pi)
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = (value % max_value)
    local i = 1
    while i <= val do
        cairo_arc(display, x, y, graph_radius,(  ((graph_unit_angle * i) - graph_unit_thickness)*(2*math.pi/360)  )-(math.pi/2),((graph_unit_angle * i) * (2*math.pi/360))-(math.pi/2))
        cairo_set_source_rgba(display,rgb_to_r_g_b(graph_fg_colour,graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = (graph_unit_angle * i) - graph_unit_thickness

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = 360 / graduation_unit_angle
        local i = 1
        while i <= nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            cairo_arc(display, x, y, graduation_radius, (((graduation_unit_angle * i)-(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2),(((graduation_unit_angle * i)+(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * (math.cos((angle * 2 * math.pi / 360)-(math.pi/2)))
    local movey = txt_radius * (math.sin((angle * 2 * math.pi / 360)-(math.pi/2)))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight);
    cairo_set_font_size (display, txt_size);
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha));
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3);
    cairo_show_text (display, value);
    cairo_stroke (display);
end

-------------------------------------------------------------------------------
--                                                               go_clock_rings
-- loads data and displays clock
--
function go_clock_rings(display)
    local function load_clock_rings(display, data)
        local str, value = '', 0
        str = string.format('${%s %s}',data['name'], data['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        draw_clock_ring(display, data, value)
    end

    for i in pairs(clock_h) do
        load_clock_rings(display, clock_h[i])
    end
    for i in pairs(clock_m) do
        load_clock_rings(display, clock_m[i])
    end
    for i in pairs(clock_s) do
        load_clock_rings(display, clock_s[i])
    end
end


-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_stats_main()
    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)

    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)



    if update_num > 5 then

        draw_cpu_radar(display)
        draw_aperture(display)
        go_clock_rings(display)
        go_gauge_rings(display)

    end

    cairo_surface_destroy(cs)
    cairo_destroy(display)
end
