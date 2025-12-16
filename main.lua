local url = "https://raw.githubusercontent.com/kdsafasdwad/mm2test/refs/heads/main/config"
local path = "Rayfield/settingsxd.rfld"
print("[DEBUG] Fetching config from URL:", url)

local content = game:HttpGet(url)
print("[DEBUG] Config fetched, length:", #content)

local updateConfig = true

-- ensure folder exists
if makefolder then
    print("[DEBUG] Ensuring Rayfield folder exists")
    pcall(function()
        makefolder("Rayfield")
    end)
end

local function applyLimiter(fpsLimit, renderingEnabled)
    print("[DEBUG] Applying limiter | FPS:", fpsLimit, "| Rendering:", renderingEnabled)
    game:GetService("RunService"):Set3dRenderingEnabled(renderingEnabled)
    setfpscap(fpsLimit)
end

local function runScriptHub()
    print("[DEBUG] Running script hub")
    loadstring(game:HttpGet('https://raw.githubusercontent.com/de-ishi/syl/refs/heads/main/mainLoader'))()
end

local function startSequence(scriptDelay, renderDelay)
    print("[DEBUG] Sequence start | Script delay:", scriptDelay, "| Render delay:", renderDelay)

    task.wait(scriptDelay)
    print("[DEBUG] Script delay finished")
    runScriptHub()

    task.wait(renderDelay)
    print("[DEBUG] Render delay finished")
    applyLimiter(15, false)

    if updateConfig == true then
        print("[DEBUG] Writing config to:", path)
        writefile(path, content)
        print("[DEBUG] Config write complete")
    else
        print("[DEBUG] updateConfig is false, skipping write")
    end
end

startSequence(5, 60) -- 5s before scripthub, 60s before rendering limit
