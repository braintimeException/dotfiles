require 'cairo'

function init_cairo()
  if conky_window == nil then
    return false
  end

  cs = cairo_xlib_surface_create(
    conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    conky_window.width,
    conky_window.height)

  cr = cairo_create(cs)

  font = "Mono"

  cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
  cairo_set_source_rgba(cr, 0.933,0.905,0.894,1)
  return true
end

function aperture()
  
  local radius = 100
  local cx, cy = 100, 100

  cairo_set_source_rgba(cr, 0.701, 0.537, 0, 1)



end

function conky_cpu_radar_main()
  if (not init_cairo()) then
    return
  end

  -- CPU GRAPH
  -- Non-linear (sqrt instead) so graph area approximatly matches usage

  local cx,cy = 100,100
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
  cairo_set_font_size(cr, 20)
  cairo_move_to(cr, cx - 5, cy - radius - 5)
  cairo_show_text(cr, 0)
  cairo_move_to(cr, cx + radius + 5, cy + 6)
  cairo_show_text(cr, 3)
  cairo_move_to(cr, cx - 5, cy + radius + 21)
  cairo_show_text(cr, 5)
  cairo_move_to(cr, cx - radius - 14, cy + 6)
  cairo_show_text(cr, 7)

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
