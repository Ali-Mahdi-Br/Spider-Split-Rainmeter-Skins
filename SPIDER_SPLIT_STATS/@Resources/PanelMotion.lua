-- SPIDER SPLIT STATS • MOTION EDITION
-- Same exact widget background, measurements, colors, sizes and coordinates.
-- Existing progress bars now move smoothly rather than jumping once a second.
-- The color pulses lightly in place; no extra shapes are created.
local bars
local phase = 0
local prev = {}
local first = true

local function clamp(x)
    if x < 0 then return 0 end
    if x > 1 then return 1 end
    return x
end

function Initialize()
    bars = {
       { meter='CPUBar', measure=SKIN:GetMeasure('MeasureCPU'), color='221,38,55', pct=0 },
       { meter='RAMBar', measure=SKIN:GetMeasure('MeasureRAM'), color='22,73,138', pct=0 },
       { meter='BatteryBar', measure=SKIN:GetMeasure('MeasureBattery'), color='221,38,55', pct=0 }
    }
    phase = 0
    first = true
    prev = {}
end

function Update()
    phase = phase + 0.15
    for i,b in ipairs(bars) do
        local target = clamp(b.measure:GetRelativeValue())
        if first then b.pct = target else b.pct = b.pct + (target - b.pct) * 0.22 end
        local width = math.floor(137 * b.pct + 0.5)
        -- A soft opacity pulse, keeping the original comic red and blue.
        local a = math.floor(240 + 15 * (0.5 + 0.5 * math.sin(phase + i * 1.2)) + 0.5)
        local shape = 'Rectangle 0,0,' .. width .. ',7,0 | Fill Color ' .. b.color .. ',' .. a .. ' | StrokeWidth 0'
        if prev[b.meter] ~= shape then
            SKIN:Bang('!SetOption', b.meter, 'Shape', shape)
            prev[b.meter] = shape
        end
    end
    first = false
    return 0
end
