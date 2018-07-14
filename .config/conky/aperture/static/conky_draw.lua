require 'cairo'
--require 'conky_draw_config'


function hexa_to_rgb(color, alpha)
    -- ugh, whish this wans't an oneliner
    return ((color / 0x10000) % 0x100) / 255., ((color / 0x100) % 0x100) / 255., (color % 0x100) / 255., alpha
end


function get_conky_value_w_format(conky_value, is_number, lo, hi, el_format)
    -- evaluate a conky template to get its current value
    -- example: "cpu cpu0" --> 20
    if el_format == '' then
        return get_conky_value(conky_value, false)
    end

    local value = conky_parse(string.format('${%s}', conky_value))
    if is_number then
        value = tonumber(value)
    
      if value == nil then 
        value = 0
      end

      if lo ~= nil and value < lo then
        value = lo
      else
        if hi ~= nil and value > hi then
          value = hi
        end
      end

    end

    value = string.format( el_format, value )
    return value
end


function get_conky_value(conky_value, is_number)
    -- evaluate a conky template to get its current value
    -- example: "cpu cpu0" --> 20

    local value = conky_parse(string.format('${%s}', conky_value))

    if is_number then
            value = tonumber(value)
    end
    if value==nil then
      return 0
    end
    return value
end


function draw_line(display, element)
    -- draw a line

    -- deltas for x and y (cairo expects a point and deltas for both axis)
    local x_side = element.to.x - element.from.x -- not abs! because they are deltas
    local y_side = element.to.y - element.from.y -- and the same here
    local from_x =element.from.x
    local from_y = element.from.y

    if not element.graduated then
      -- draw line
      cairo_set_source_rgba(display, hexa_to_rgb(element.color, element.alpha))
      cairo_set_line_width(display, element.thickness);
      cairo_move_to(display, element.from.x, element.from.y);
      cairo_rel_line_to(display, x_side, y_side);
    else
      -- draw graduated line
      cairo_set_source_rgba(display, hexa_to_rgb(element.color, element.alpha))
      cairo_set_line_width(display, element.thickness);
      local space_graduation_x = (x_side-x_side/element.space_between_graduation+1)/element.number_graduation
      local space_graduation_y =(y_side-y_side/element.space_between_graduation+1)/element.number_graduation
      local space_x = x_side/element.number_graduation-space_graduation_x
      local space_y = y_side/element.number_graduation-space_graduation_y

      for i=1,element.number_graduation do
          cairo_move_to(display,from_x,from_y)
          from_x=from_x+space_x+space_graduation_x
          from_y=from_y+space_y+space_graduation_y
          cairo_rel_line_to(display,space_x,space_y)
      end
    end
    cairo_stroke(display)
end


function draw_bar_graph(display, element)
    -- draw a bar graph
    -- Used a little bit of trigonometry to be able to draw bars in any direction! :)

    -- get current value

    value = get_conky_value(element.conky_value, true)
    if value > element.max_value   then
        value = element.max_value
    end

    -- dimensions of the full graph
    local x_side = element.to.x - element.from.x
    local y_side = element.to.y - element.from.y
    local hypotenuse = math.sqrt(math.pow(x_side, 2) + math.pow(y_side, 2))
    local angle = math.atan2(y_side, x_side)

    -- dimensions of the value bar
    local bar_hypotenuse = value * (hypotenuse / element.max_value)
    local bar_x_side = bar_hypotenuse * math.cos(angle)
    local bar_y_side = bar_hypotenuse * math.sin(angle)

    -- is it in critical value?
    local color_critical_or_not_suffix = ''
    local alpha_critical_or_not_suffix = ''
    local thickness_critical_or_not_suffix = ''
    if value >= element.critical_threshold then
        if element.change_color_on_critical then
            color_critical_or_not_suffix = '_critical'
        end
        if element.change_alpha_on_critical then
            alpha_critical_or_not_suffix = '_critical'
        end
        if element.change_thickness_on_critical then
            thickness_critical_or_not_suffix = '_critical'
        end
    end

    -- background line (full graph)
    background_line = {
        from = element.from,
        to = element.to,

        color = element['background_color' .. color_critical_or_not_suffix],
        alpha = element['background_alpha' .. alpha_critical_or_not_suffix],
        thickness = element['background_thickness' .. thickness_critical_or_not_suffix],
        graduated = element.graduated,
        number_graduation=element.number_graduation,
        space_between_graduation=element.space_between_graduation,
    }
    bar_line = {
        from = element.from,
        to = {x=element.from.x + bar_x_side, y=element.from.y + bar_y_side},

        color = element['bar_color' .. color_critical_or_not_suffix],
        alpha = element['bar_alpha' .. alpha_critical_or_not_suffix],
        thickness = element['bar_thickness' .. thickness_critical_or_not_suffix],
    }
    -- draw background lines
    draw_line(display, background_line)

  if element.graduated then
      -- draw bar line if graduated
      cairo_set_source_rgba(display, hexa_to_rgb(bar_line.color, bar_line.alpha))
      cairo_set_line_width(display, bar_line.thickness);
      local from_x = bar_line.from.x
      local from_y = bar_line.from.y
      local space_graduation_x = (x_side-x_side/element.space_between_graduation+1)/element.number_graduation
      local space_graduation_y =(y_side-y_side/element.space_between_graduation+1)/element.number_graduation
      local space_x = x_side/element.number_graduation-space_graduation_x
      local space_y = y_side/element.number_graduation-space_graduation_y

      for i=1,bar_x_side/(space_x+space_graduation_x) do

          cairo_move_to(display,from_x,from_y)
          from_x=from_x+space_x+space_graduation_x
          from_y=from_y+space_y+space_graduation_y
          cairo_rel_line_to(display,space_x,space_y)
      end

    cairo_stroke(display)
  else
    -- draw bar line if not graduated
    draw_line(display,bar_line);
  end

end

function angle_to_coords( angle, radius )

  local x, y = angle_to_unit_coords( angle )
  return x * radius, y * radius

end


function draw_box( display, element )

  cairo_set_source_rgba(display, hexa_to_rgb(element.color, element.alpha))
  cairo_set_line_width(display, element.thickness);
  cairo_move_to(display, element.from.x, element.from.y);

  cairo_line_to( display, element.to.x, element.from.y )
  cairo_line_to( display, element.to.x, element.to.y )
  cairo_line_to( display, element.from.x, element.to.y )

  cairo_close_path( display )
  cairo_stroke( display )

end


function angle_to_unit_coords( angle )

  local y = math.sin( angle )
  local x = math.cos( angle )
  return x, y

end


function draw_aperture(display, element)
    -- draw a ring

    -- the user types degrees, but we need radians
    local start_angle, end_angle = math.rad(element.start_angle), math.rad(element.end_angle)

    -- direction of the ring changes the function we must call
    local arc_drawer = cairo_arc
    local orientation = 1
    if start_angle > end_angle then
        arc_drawer = cairo_arc_negative
        orientation = -1
    end
    cairo_set_source_rgba(display, hexa_to_rgb(element.color, element.alpha))
    cairo_set_line_width(display, element.thickness);
    -- draw the ring
    if not element.graduated then
      -- draw the ring if not graduated
      arc_drawer(display, element.center.x, element.center.y, element.radius, start_angle, end_angle)
      cairo_stroke(display);
    else
      -- draw the ring if graduated
      local angle_between_graduation = math.rad(element.angle_between_graduation)
      local graduation_size = math.abs(end_angle-start_angle)/element.number_graduation - angle_between_graduation
      local current_start = start_angle
      local xa, ya, xb, yb, xc, yc = 0, 0, 0, 0, 0, 0

      for i=1, element.number_graduation do
        cairo_new_sub_path( display )
        arc_drawer(display, element.center.x, element.center.y, element.radius, current_start, current_start+graduation_size* orientation)
        current_start = current_start + graduation_size * orientation
        xc, yc = angle_to_coords( current_start, element.radius )
        xb, yb = angle_to_coords( current_start + math.rad( element.angle_to_vertex ), element.radius * element.rel_dist_to_vertex )

        cairo_rel_line_to( display, xb - xc, yb - yc )

        current_start = current_start + angle_between_graduation * orientation

        cairo_close_path( display )
        cairo_fill( display )
      end
    end

end


function draw_ring(display, element)
    -- draw a ring

    -- the user types degrees, but we need radians
    local start_angle, end_angle = math.rad(element.start_angle), math.rad(element.end_angle)

    -- direction of the ring changes the function we must call
    local arc_drawer = cairo_arc
    local orientation = 1
    if start_angle > end_angle then
        arc_drawer = cairo_arc_negative
        orientation = -1
    end
    cairo_set_source_rgba(display, hexa_to_rgb(element.color, element.alpha))
    cairo_set_line_width(display, element.thickness);
    -- draw the ring
    if not element.graduated then
      -- draw the ring if not graduated
      arc_drawer(display, element.center.x, element.center.y, element.radius, start_angle, end_angle)
      if element.filled then
        cairo_fill( display )
      end
      cairo_stroke(display);
    else
      -- draw the ring if graduated
      local angle_between_graduation = math.rad(element.angle_between_graduation)
      local graduation_size = math.abs(end_angle-start_angle)/element.number_graduation - angle_between_graduation
      local current_start = start_angle

      for i=1, element.number_graduation do
        arc_drawer(display, element.center.x, element.center.y, element.radius, current_start, current_start+graduation_size* orientation)
        current_start= current_start+ (graduation_size+angle_between_graduation)* orientation
        cairo_stroke(display);
      end
    end

end


function draw_ring_graph(display, element)
    -- draw a ring graph

    -- get current value
    local value = get_conky_value(element.conky_value, true)

    if value > element.max_value then
        value = element.max_value
    end

    -- dimensions of the full graph
    local degrees = element.end_angle - element.start_angle

    -- dimensions of the value bar
    local bar_degrees = value * (degrees / element.max_value)

    -- is it in critical value?
    local critical_or_not_suffix = ''
    if value >= element.critical_threshold then
        critical_or_not_suffix = '_critical'
    end

    -- background ring (full graph)
    background_ring = {
        center = element.center,
        radius = element.radius,

        start_angle = element.start_angle,
        end_angle = element.end_angle,

        graduated=element.graduated,
        number_graduation= element.number_graduation,
        angle_between_graduation =element.angle_between_graduation,

        color = element['background_color' .. critical_or_not_suffix],
        alpha = element['background_alpha' .. critical_or_not_suffix],
        thickness = element['background_thickness' .. critical_or_not_suffix],
    }

    -- bar ring
    bar_ring = {
        center = element.center,
        radius = element.radius,

        start_angle = element.start_angle,
        end_angle = element.start_angle + bar_degrees,

        color = element['bar_color' .. critical_or_not_suffix],
        alpha = element['bar_alpha' .. critical_or_not_suffix],
        thickness = element['bar_thickness' .. critical_or_not_suffix],
    }

    -- draw background rings
    draw_ring(display, background_ring)
    if not element.graduated then
      -- draw bar ring if not graduated
      draw_ring(display, bar_ring)
    else
      -- draw bar ring if graduated
      local start_angle, end_angle = math.rad(element.start_angle), math.rad(element.end_angle)
      local arc_drawer = cairo_arc
      local orientation = 1
      if start_angle > end_angle then
          arc_drawer = cairo_arc_negative
          orientation = -1
      end
      cairo_set_source_rgba(display, hexa_to_rgb(bar_ring.color, bar_ring.alpha))
      cairo_set_line_width(display, bar_ring.thickness);

      local angle_between_graduation = math.rad(element.angle_between_graduation)
      local graduation_size = math.abs(end_angle-start_angle)/element.number_graduation - angle_between_graduation
      local current_start = start_angle
      bar_degrees=math.rad(bar_degrees)
      for i=1, bar_degrees/(graduation_size+angle_between_graduation)*orientation do
        arc_drawer(display, element.center.x, element.center.y, element.radius, current_start, current_start+graduation_size* orientation)
        current_start= current_start+ (graduation_size+angle_between_graduation)* orientation
        cairo_stroke(display);

      end
    end

end


function draw_ellipse_graph(display, element)
    -- draw a ellipse graph

    -- get current value
    local value = get_conky_value(element.conky_value, true)

    if value > element.max_value then
        value = element.max_value
    end

    -- dimensions of the full graph
    local degrees = element.end_angle - element.start_angle

    -- dimensions of the value bar
    local bar_degrees = value * (degrees / element.max_value)

    -- is it in critical value?
    local critical_or_not_suffix = ''
    if value >= element.critical_threshold then
        critical_or_not_suffix = '_critical'
    end

    -- background ellipse (full graph)
    background_ellipse = {
        center = element.center,
        radius = element.radius,
        width = element.width,
        height =element.height,
        start_angle = element.start_angle,
        end_angle = element.end_angle,
        rotation_angle= element.rotation_angle,

        graduated=element.graduated,
        number_graduation= element.number_graduation,
        angle_between_graduation =element.angle_between_graduation,

        color = element['background_color' .. critical_or_not_suffix],
        alpha = element['background_alpha' .. critical_or_not_suffix],
        thickness = element['background_thickness' .. critical_or_not_suffix],
    }

    -- bar ellipse
    bar_ellipse = {
        center = element.center,
        radius = element.radius,
        width = element.width,
        height =element.height,
        start_angle = element.start_angle,
        end_angle = element.start_angle + bar_degrees,
        rotation_angle= element.rotation_angle,
        color = element['bar_color' .. critical_or_not_suffix],
        alpha = element['bar_alpha' .. critical_or_not_suffix],
        thickness = element['bar_thickness' .. critical_or_not_suffix],
    }

    -- draw background ellipse
    draw_ellipse(display, background_ellipse)


    if not element.graduated then
      -- draw ellipse bar if not graduated
      draw_ellipse(display, bar_ellipse)
    else
      -- draw ellipse bar if graduated
      local start_angle, end_angle = math.rad(element.start_angle), math.rad(element.end_angle)
      local arc_drawer = cairo_arc
      local orientation = 1
      if start_angle > end_angle then
          arc_drawer = cairo_arc_negative
          orientation = -1
      end
      cairo_set_source_rgba(display, hexa_to_rgb(bar_ellipse.color, bar_ellipse.alpha))
      cairo_set_line_width(display, bar_ellipse.thickness);

      local angle_between_graduation = math.rad(element.angle_between_graduation)
      local graduation_size = math.abs(end_angle-start_angle)/element.number_graduation - angle_between_graduation
      local current_start = start_angle
      bar_degrees=math.rad(bar_degrees)
      for i=1, bar_degrees/(graduation_size+angle_between_graduation)*orientation do
        cairo_save(display)
        cairo_translate (display, element.center.x + element.width / 2., element.center.y + element.height / 2.)

        cairo_scale (display, element.width / 2., element.height / 2.)
        arc_drawer(display, element.center.x, element.center.y, element.radius, current_start, current_start+graduation_size* orientation)
        current_start= current_start+ (graduation_size+angle_between_graduation)* orientation

        cairo_restore(display)
        cairo_stroke(display);
      end
    end


end


function draw_ellipse(display, element)
    -- draw an ellipse

    -- the user types degrees, but we need radians
    local start_angle, end_angle = math.rad(element.start_angle), math.rad(element.end_angle)
    local rotation_angle = math.rad(element.rotation_angle)
    -- direction of the ellipse changes the function we must call
      local arc_drawer = cairo_arc
    local orientation = 1
    if start_angle > end_angle then
        arc_drawer = cairo_arc_negative
        orientation = -1
    end

    cairo_set_source_rgba(display,hexa_to_rgb(element.color, element.alpha))
    cairo_set_line_width(display, element.thickness)


    if not element.graduated then
      -- draw simple ellipse
      cairo_save(display)
      cairo_translate (display, element.center.x + element.width / 2., element.center.y + element.height / 2.)

      cairo_scale (display, element.width / 2., element.height / 2.)
      arc_drawer(display, element.center.x, element.center.y, element.radius, start_angle, end_angle)

      cairo_restore(display)
      cairo_stroke(display)
    else
      -- draw graduated ellipse
      local angle_between_graduation = math.rad(element.angle_between_graduation)
      local graduation_size = math.abs(end_angle-start_angle)/element.number_graduation - angle_between_graduation
      local current_start = start_angle

      for i=1, element.number_graduation do
        cairo_save(display)
        cairo_translate (display, element.center.x + element.width / 2., element.center.y + element.height / 2.)
        cairo_scale (display, element.width / 2., element.height / 2.)
        arc_drawer(display, element.center.x, element.center.y, element.radius, current_start, current_start+graduation_size* orientation)
        current_start= current_start+ (graduation_size+angle_between_graduation)* orientation
        cairo_restore(display)
        cairo_stroke(display);
      end
    end
end


function draw_variable_text(display, element)
  cairo_save(display)
  cairo_move_to (display,element.from.x,element.from.y)
  cairo_rotate(display,element.rotation_angle* (math.pi / 180))
  cairo_set_source_rgba(display,hexa_to_rgb(element.color, element.alpha))
  cairo_set_font_size (display, element.font_size)
  local font_slant = CAIRO_FONT_SLANT_NORMAL
  if element.italic then
    font_slant=CAIRO_FONT_SLANT_ITALIC
  end
  local font_weight = CAIRO_FONT_WEIGHT_NORMAL
  if element.bold then
    font_weight=CAIRO_FONT_WEIGHT_BOLD
  end
  cairo_select_font_face(display,element.font,font_slant,font_weight)
  local text = get_conky_value_w_format(element.conky_value, element.is_number, element.lo, element.hi, element.format)
  cairo_show_text (display,text)

  cairo_restore(display)
  cairo_stroke (display)
end


function draw_static_text(display, element)
      cairo_save(display)
      cairo_move_to (display,element.from.x,element.from.y)
      cairo_rotate(display,element.rotation_angle* (math.pi / 180))
      cairo_set_source_rgba(display,hexa_to_rgb(element.color, element.alpha))
      cairo_set_font_size (display, element.font_size)
      local font_slant = CAIRO_FONT_SLANT_NORMAL
      if element.italic then
        font_slant=CAIRO_FONT_SLANT_ITALIC
      end
      local font_weight = CAIRO_FONT_WEIGHT_NORMAL
      if element.bold then
        font_weight=CAIRO_FONT_WEIGHT_BOLD
      end
      cairo_select_font_face(display,element.font,font_slant,font_weight)

      cairo_show_text (display,element.text)

      cairo_restore(display)
      cairo_stroke (display)
end


function draw_clock(display, element)
    error('clock element kind not implemented')
end


-- properties that the user *must* define, because they don't have default
-- values
requirements = {
    line = {'from', 'to'},
    box = {'from', 'to'},
    bar_graph = {'from', 'to', 'conky_value'},
    ring = {'center', 'radius'},
    aperture = {'center', 'radius'},
    ring_graph = {'center', 'radius', 'conky_value'},
    ellipse ={'center', 'radius', 'width','height'},
    ellipse_graph ={'center', 'radius', 'width','height','conky_value'},
    variable_text = {'from','conky_value'},
    static_text = {'from','text'},
    clock = {},
}


-- Default values for properties that can have a default value
defaults = {
    bar_graph = {
        max_value = 100.,
        critical_threshold = 90.,

        background_color = 0x00FF6E,
        background_alpha = 0.2,
        background_thickness = 5,

        bar_color = 0x00FF6E,
        bar_alpha = 1.0,
        bar_thickness = 5,

        background_color_critical = 0xFA002E,
        background_alpha_critical = 0.2,
        background_thickness_critical = 5,

        bar_color_critical = 0xFA002E,
        bar_alpha_critical = 1.0,
        bar_thickness_critical = 5,

        change_color_on_critical = true,
        change_alpha_on_critical = false,
        change_thickness_on_critical = false,

        graduated = false,
        number_graduation=0,
        space_between_graduation=1,

        draw_function = draw_bar_graph,
    },
    ring_graph = {
        max_value = 100.,
        critical_threshold = 90.,

        background_color = 0x00FF6E,
        background_alpha = 0.2,
        background_thickness = 5,

        bar_color = 0x00FF6E,
        bar_alpha = 1.0,
        bar_thickness = 5,

        background_color_critical = 0xFA002E,
        background_alpha_critical = 0.2,
        background_thickness_critical = 5,

        bar_color_critical = 0xFA002E,
        bar_alpha_critical = 1.0,
        bar_thickness_critical = 5,

        change_color_on_critical = true,
        change_alpha_on_critical = false,
        change_thickness_on_critical = false,

        start_angle = 0,
        end_angle = 360,

        graduated = false,
        number_graduation=0,
        angle_between_graduation=1,

        draw_function = draw_ring_graph,
    },
    line = {
        color = 0x00FF6E,
        alpha = 0.2,
        thickness = 5,
        graduated = false,
        number_graduation=0,
        space_between_graduation=1,
        draw_function = draw_line,
    },
    box = {
        color = 0x00FF6E,
        alpha = 0.2,
        thickness = 5,
        draw_function = draw_box,
    },
    aperture = {
        color = 0x00FF6E,
        alpha = 0.2,
        thickness = 5,

        start_angle = 0,
        end_angle = 360,

        graduated = true,
        number_graduation=8,
        angle_between_graduation=10,

        angle_to_vertex=30,
        rel_dist_to_vertex=0.6,

        draw_function = draw_aperture,
    },
    ring = {
        color = 0x00FF6E,
        alpha = 0.2,
        thickness = 5,

        start_angle = 0,
        end_angle = 360,

        graduated = false,
        number_graduation=0,
        angle_between_graduation=1,

        filled = false,

        draw_function = draw_ring,
    },
    ellipse_graph = {
        max_value = 100.,
        critical_threshold = 90.,

        background_color = 0x00FF6E,
        background_alpha = 0.2,
        background_thickness = 5,

        bar_color = 0x00FF6E,
        bar_alpha = 1.0,
        bar_thickness = 5,

        background_color_critical = 0xFA002E,
        background_alpha_critical = 0.2,
        background_thickness_critical = 5,

        bar_color_critical = 0xFA002E,
        bar_alpha_critical = 1.0,
        bar_thickness_critical = 5,

        change_color_on_critical = true,
        change_alpha_on_critical = false,
        change_thickness_on_critical = false,

        start_angle = 0,
        end_angle = 360,
        rotation_angle=0,

        graduated = false,
        number_graduation=0,
        angle_between_graduation=1,

        draw_function = draw_ellipse_graph,
    },
    ellipse = {
        color = 0x00FF6E,
        alpha = 0.2,
        thickness = 5,

        start_angle = 0,
        end_angle = 360,
        rotation_angle=0,

        graduated = false,
        number_graduation=0,
        angle_between_graduation=1,

        draw_function = draw_ellipse,
    },
    variable_text = {
        color = 0x00FF6E,
        rotation_angle=0,
        font="Liberation Sans",
        font_size=12,
        bold=false,
        italic=false,
        alpha=1.0,
        draw_function = draw_variable_text,
        format = '',
        is_number = false,
    },
    static_text = {
        color = 0x00FF6E,
        rotation_angle=0,
        font="Liberation Sans",
        font_size=12,
        bold=false,
        italic=false,
        alpha=1.0,
        draw_function = draw_static_text,
    },
    clock = {
        draw_function = draw_clock,
    },
}


function check_requirements(elements)
    -- check every element has the required properties
    for i, element in pairs(elements) do
        -- find the requirements for that element kind
        kind_requirements = requirements[element.kind]
        -- if there are defined requirements for that element kind
        if  kind_requirements ~= nil then
            -- check all of them are defined by the user
            for i, property in pairs(kind_requirements) do
                if element[property] == nil then
                    error('You defined a ' .. element.kind .. ' without specifying its "' .. property .. '" value')
                end
            end
        else
            -- we don't know which properties has to have, BUT, it always needs
            -- a draw_function
            if element.draw_function == nil then
                error('You defined a ' .. element.kind .. ', which is unknown element kind to me. Was it a typo? or are you trying to define a custom element kind but forgot to define its draw_function?')
            end
        end
    end
end


function fill_defaults(elements)
    -- fill each each element with the missing values, using the defaults
    for i, element in pairs(elements) do
        -- find the defaults for that element kind
        kind_defaults = defaults[element.kind]
        -- only if there are defined defaults for that element kind
        if  kind_defaults ~= nil then
            -- fill the element with the defaults (for the properties without
            -- value)
            for key, value in pairs(kind_defaults) do
                if element[key] == nil then
                    element[key] = kind_defaults[key]
                end
            end
        end
    end
end


function conky_main()
    if conky_window == nil then
        return
    end

    check_requirements(elements)
    fill_defaults(elements)

    local surface = cairo_xlib_surface_create(conky_window.display,
                                              conky_window.drawable,
                                              conky_window.visual,
                                              conky_window.width,
                                              conky_window.height)
    local display = cairo_create(surface)

    if tonumber(conky_parse('${updates}')) > 3 then
        for i, element in pairs(elements) do
            element.draw_function(display, element)
        end
    end

    cairo_surface_destroy(surface)
end