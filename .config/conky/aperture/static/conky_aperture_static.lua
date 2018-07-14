--==============================================================================
--                                 conky_aperture.lua
--                              adapted from conky_grey.lua by SLK
--
--  author  : Braitex
--  version : v2011062101
--  license : Distributed under the terms of GNU GPL version 2 or later
--
--==============================================================================

--require 'cairo'
--require 'conky_draw'
--require 'conky_aperture_static_settings'
--require 'rsvg'

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
--                                                               draw_elements

function draw_elements( cr, elements )
  for i, elem in pairs( elements ) do
    elem.draw_function( cr, elem )
  end
end

-------------------------------------------------------------------------------
--                                                                         MAIN
--rsvg_handle = nil
function conky_aperture_static_main()
    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)

    local updates = conky_parse('${updates}')
    -- update_num = tonumber(updates)



        -- check_requirements(clock_gate_elems)
        -- fill_defaults(clock_gate_elems)
        -- check_requirements(apert_elems)
        -- fill_defaults(apert_elems)
        -- check_requirements(test_chamber_elems)
        -- fill_defaults(test_chamber_elems)
        -- check_requirements(CUaTI_elems)
        -- fill_defaults(CUaTI_elems)
        -- rsvg_handle = rsvg_handle_new_from_file( "Portal_Icons_selected.svg")
        -- draw_elements( display, apert_elems )
        -- draw_elements( display, test_chamber_elems )
        -- draw_elements( display, clock_gate_elems )
        -- draw_elements( display, CUaTI_elems )
        --
        -- rsvg_handle_render_cairo( rsvg_handle, display)
    conky_aperture_static( display )

    cairo_surface_destroy(cs)
    cairo_destroy(display)
    return updates
end

function conky_aperture_static(display)

        -- check_requirements(clock_gate_elems)
        -- fill_defaults(clock_gate_elems)
        -- check_requirements(apert_elems)
        -- fill_defaults(apert_elems)
        -- check_requirements(test_chamber_elems)
        -- fill_defaults(test_chamber_elems)
        -- check_requirements(CUaTI_elems)
        -- fill_defaults(CUaTI_elems)
        draw_elements( display, apert_elems )
        draw_elements( display, test_chamber_elems )
        draw_elements( display, clock_gate_elems )
        draw_elements( display, CUaTI_elems )

        rsvg_handle_render_cairo( rsvg_handle, display)

end
