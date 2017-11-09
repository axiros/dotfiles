--[[ Left Keyboard Mouse (alt-d)

The main problem was to get chrome based apps select text when we drag via
keyboard.

You MUST return true always in the handle_drag otherwise it fails to select.
FF works, terminal works, chrome apps (atom, ...) don't.

But true is preventing further processing of the drag coords,
hs.mouse.getAbsolutePosition remains constant while dragging (!)
=> i.e. we MUST calc them via DeltaX, DeltaY, see below.

--]]

hs.alert.show("$HOME/.hammerspoon/init.lua: Loaded.")

-- all mechanics stolen from here:
-- local vimouse = require('vimouse')
-- vimouse('cmd', 'm')

now      = hs.timer.secondsSinceEpoch
evt      = hs.eventtap
evte     = evt.event
evtypes  = evte.types
evp      = evte.properties

drag_last = now(); drag_intv = 0.01 -- we only synth drags from time to time

mp     = {['x']=0, ['y']=0} -- mouse point. coords and last posted event
lastd  = {['x']=0, ['y']=0} -- mouse point. coords and last posted event
l = hs.logger.new('keybmouse', 'debug')
dmp = hs.inspect

-- The event tap. Started with the keyboard click:
handled = {evtypes.mouseMoved, evtypes.keyUp }
handle_drag = evt.new(handled, function(e)

    -- if e:getType() == evtypes.keyDown then return true end -- not needed.

    if e:getType() == evtypes.keyUp then
        handle_drag:stop()
        post_evt(2)
        return nil -- otherwise the up seems not processed by the OS
    end
    local dx =  e:getProperty(evp.mouseEventDeltaX)
    local dy =  e:getProperty(evp.mouseEventDeltaY)
    --[[
    if math.abs(dx) > 400 then
        dx = - lastd.x * 10
        drag_last = 0
        mp.x = mp.x + dx
        hs.mouse.setAbsolutePosition(mp)
        dx = 0
    else
        lastd.x = dx
    end
    if math.abs(dy) > 400 then
        dy = - lastd.y
        drag_last = 0
    else
        lastd.y = dy
    end
    -- ]]
    -- lastd.x = dx; lastd.y = dy
    mp.x = mp.x + dx; mp.y = mp.y + dy

    -- giving the key up a chance:
    if now() - drag_last > drag_intv then
        -- l.d('pos', mp.x, 'dx', dx)
        post_evt(6) -- that sometimes makes dx shaky, in the log above :-/
        drag_last = now()
    end
    return true -- important
end)

function post_evt(mode)
    -- 1: down, 2: up, 6: drag
    cs = 0 -- clickstate 0 for drag
    if mode == 1 or mode == 2 then
        local p = hs.mouse.getAbsolutePosition()
        mp.x = p.x; mp.y = p.y; cs = 1
    end
    local e = evte.newMouseEvent(mode, mp)
    e:setProperty(evp.mouseEventClickState, cs)
    e:post()
end

-- mapped by karabiner elements to caps lock:
hyper = {"left_option", "left_control", "left_command", "left_shift"}
hs.hotkey.bind(hyper, "d", function(event)
    --lastd.x = 0; lastd.y = 0
    post_evt(1)
    handle_drag:start()
  end
)


