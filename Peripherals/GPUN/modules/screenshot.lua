--GPU: Screenshot and Label image.

--luacheck: push ignore 211
local Config, GPU, yGPU, GPUKit, DevKit = ...
--luacheck: pop

local events = require("Engine.events")

local Path = GPUKit.Path
local MiscKit = GPUKit.Misc
local WindowKit = GPUKit.Window
local RenderKit = GPUKit.RenderKit
local SharedKit = GPUKit.SharedKit

--==Kits Constants==--
local _LIKO_W, _LIKO_H = WindowKit.LIKO_W, WindowKit._LIKO_H
local systemMessage = MiscKit.systemMessage
local Verify = SharedKit.Verify

--==Local Variables==--

local _ScreenshotKey = Config._ScreenshotKey or "f5"
local _ScreenshotScale = Config._ScreenshotScale or 3

local _LabelCaptureKey = Config._LabelCaptureKey or "f6"

--==GPU Screenshot API==--

function GPU.screenshot(x,y,w,h)
  x, y, w, h = x or 0, y or 0, w or _LIKO_W, h or _LIKO_H
  x = Verify(x,"X","number",true)
  y = Verify(y,"Y","number",true)
  w = Verify(w,"W","number",true)
  h = Verify(h,"H","number",true)
  love.graphics.setCanvas()
  local imgdata = GPU.imagedata(RenderKit.ScreenCanvas:newImageData(1,1,x,y,w,h))
  love.graphics.setCanvas{RenderKit.ScreenCanvas,stencil=true}
  return imgdata
end

--==Label Image==--

local newImageHandler = love.filesystem.load(Path.."scripts/imageHandler.lua")

local LabelImage = love.image.newImageData(_LIKO_W, _LIKO_H)

LabelImage:mapPixel(function() return 0,0,0,1 end)

local LIMGHandler; LIMGHandler = newImageHandler(_LIKO_W,_LIKO_H,function() end,function() end)

LIMGHandler("setImage",0,0,LabelImage)

--==Label Image API==--

function GPU.getLabelImage()
  return GPU.imagedata(LabelImage)
end

--==Hooks==--

--Screenshot and LabelCapture keys handling.
events.register("love:keypressed", function(key)
  if key == _ScreenshotKey then
    local sc = GPU.screenshot()
    sc = sc:enlarge(_ScreenshotScale)
    local png = sc:exportOpaque()
    love.filesystem.write("/Screenshots/LIKO12-"..os.time()..".png",png)
    systemMessage("Screenshot has been taken successfully",2)
  elseif key == _LabelCaptureKey then
    love.graphics.setCanvas()
    LabelImage:paste(RenderKit.ScreenCanvas:newImageData(),0,0,0,0,_LIKO_W,_LIKO_H)
    love.graphics.setCanvas{RenderKit.ScreenCanvas,stencil=true}
    systemMessage("Captured label image successfully !",2)
  end
end)

--==DevKit Exports==--
DevKit.LIMGHandler = LIMGHandler