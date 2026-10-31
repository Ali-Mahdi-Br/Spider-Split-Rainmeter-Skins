-- SPIDER SPLIT BOLD • MOTION EDITION
-- The geometry, images, fonts and positions are unchanged.
-- Only opacity / the existing accent strokes gently pulse.
local phase = 0
local last = {}

function Initialize()
    phase = 0
    last = {}
end

local function set(name, option, value)
    value = tostring(value)
    local key = name .. ':' .. option
    if last[key] ~= value then
        SKIN:Bang('!SetOption', name, option, value)
        last[key] = value
    end
end

local function alpha(lo, hi, v)
    return math.floor(lo + (hi - lo) * (0.5 + 0.5 * math.sin(v)) + 0.5)
end

function Update()
    -- 100 ms updates. Subtle, quiet breathing rather than new HUD parts.
    phase = phase + 0.18
    local ink = alpha(225, 255, phase)
    local web = alpha(182, 255, phase - 0.7)
    local cut = alpha(204, 255, phase + 1.8)
    local shadow = alpha(193, 223, phase + 1.4)
    local accent = alpha(191, 255, phase + 0.5)
    local tip = alpha(175, 255, phase + 2.1)
    set('DateFront', 'InlineSetting', 'Color | 221,38,55,' .. ink)
    set('DateFront', 'InlineSetting2', 'Color | 22,73,138,' .. ink)
    set('DateExtrusion', 'FontColor', '12,26,48,' .. shadow)
    set('Web', 'ImageAlpha', web)
    set('ComicCuts', 'ImageAlpha', cut)
    set('WeekdayAccent', 'Shape', 'Line 49,239,49,519 | StrokeWidth 3 | Stroke Color 221,38,55,' .. accent)
    set('RedUnderbar', 'Shape', 'Rectangle 154,495,264,5,2 | Fill Color 221,38,55,' .. accent .. ' | StrokeWidth 0')
    set('BlueTip', 'Shape', 'Rectangle 422,495,48,5,2 | Fill Color 22,73,138,' .. tip .. ' | StrokeWidth 0')
    return 0
end
