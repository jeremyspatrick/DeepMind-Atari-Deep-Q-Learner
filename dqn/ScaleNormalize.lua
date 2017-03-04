--[[
Copyright (c) 2014 Google Inc.

See LICENSE file for full terms of limited license.
]]

require "nn"
require "image"

local scale = torch.class('nn.ScaleNormalize', 'nn.Module')

function scale:__init(height, width)
    self.height = height
    self.width = width
end

function scale:forward(x)
    local x = x
    if x:dim() > 3 then
        x = x[1]
    end

    x = image.rgb2y(x)
    x = image.scale(x, self.width, self.height, 'bilinear')

    -- Y values are between 0 and 1. Try to make them centered at 0
    -- with variance close to 1
    x:mul(4):add(-1)

    return x
end

function scale:updateOutput(input)
    return self:forward(input)
end

function scale:float()
end
