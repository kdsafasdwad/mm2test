local function applyLimiter(fpsLimit, renderingEnabled)
    game:GetService("RunService"):Set3dRenderingEnabled(renderingEnabled)
    setfpscap(fpsLimit)
end

local function runScriptHub()
    print("put your scripthub")
end

local function startSequence(scriptDelay, renderDelay)
    task.wait(scriptDelay)
    runScriptHub()
    task.wait(renderDelay)
    applyLimiter(15, false)
end

startSequence(5, 60) -- 5s before scripthub, 60s before rendering limit
