--[[

     ME awesome theme with 
        top panel       = xfce4-panel
        bottom panel    = wibox
     
     NOTE: xfce4-panel needs xfwm4 compositor to perfectly run as intended

     The panels can be interchanged with any panel
            
            Additional xfce4-panel plugins need to be installed

--]]


local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/ME"
theme.font                                      = "Noto Sans Regular 10"
--theme.taglist_font                              = "Noto Sans Regular 13"
theme.bg_normal                                 = "#000000"
theme.fg_normal                                 = "#aaaaaa"
theme.fg_focus                                  = "#00FF5F"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#9FFFFF"
theme.border_width                              = dpi(2)
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#A82130"
--theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 0
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(200)
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 1
theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                                = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.confdir .. "/icons/floating.png"


function theme.at_screen_connect(s)
  
        -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

        -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

        -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
        -- Create an imagebox widget which will contains an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
        -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

   
        -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)


    -- #######################         Wibar          #########################################

        -- Create the top wibox
    mywibox = awful.wibar({ position = "top", screen = s, bg = theme.bg_normal, fg = theme.fg_normal })

        -- Launch xfce-panel
    awful.spawn("xfce4-panel")

        -- Don't create the default wibox
    mywibox = nil


        -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(15), bg = theme.bg_normal, fg = theme.fg_normal })

        -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
        },
    }
end

return theme
