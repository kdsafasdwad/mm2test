local url = "https://raw.githubusercontent.com/kdsafasdwad/mm2test/refs/heads/main/config"
local path = "Rayfield/settings.rfld"

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

local function startSequence()
    print("[DEBUG] Sequence start")

    -- wait 5 seconds, then save config
    task.wait(5)

    if updateConfig == true then
        print("[DEBUG] Writing config to:", path)

        local ok, err = pcall(function()
            writefile(path, content)
        end)

        if ok then
            print("[DEBUG] Config file created successfully ✅")
        else
            print("[DEBUG] Config file write FAILED ❌ | Error:", err)
        end
    end

    -- wait another 5 seconds (total 10s), then run scripthub
    task.wait(5)
    print("[DEBUG] Running script hub after 10 seconds")
    runScriptHub()

    -- wait 60 seconds, then apply limiter
    task.wait(60)
    print("[DEBUG] Applying limiter after render delay")
    applyLimiter(15, false)
end

startSequence()
