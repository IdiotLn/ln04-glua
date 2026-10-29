-- -- UNDERSTANDING COOLDOWNS.
-- local cooldown = 10 -- the overall cooldown.
-- local last = 50 -- the last time the command was used.
-- local now = 59 -- the time now.

-- local timePassed = now - last -- how much time has passed since now and the last time.
-- print("The time passed has been: " .. timePassed .. "s")

-- if timePassed < cooldown then -- if the time passed is less than 10 seconds, then execute the following.
--     print("There is " .. cooldown - timePassed .. "s left!")
-- else -- if the time passed is more than 10 seconds, then execute the following.
--     print("Welcome in!")
-- end


-- -- UNDERSTANDING COUNTDOWNS.
-- print("--- COUNTDOWN ---")

-- local duration = 5 -- the duration of the countdown.
-- local spawnTime = 200 -- the time the player spawned
-- local endTime = 205 -- the time the spawn protection should end

-- local secondNow = 203.5 -- the time the player is checking

-- if secondNow < endTime then -- if the current time is less than the end time, then execute the following.
--     print("Protected! With " .. math.ceil(endTime - secondNow) .. "s left!")
-- else -- if the current time is more than the end time, then execute the following.
--     print("Protection is over.")
-- end


-- TESTING FOR LOOPS AND FUNCTIONS KNOWLEDGE.
-- local blueTeam = {
--     { name = "Alex", money = 900 },
--     { name = "Jordan", money = 200 },
--     { name = "Casey", money = 1500 },
-- }

-- local redTeam = {
--     { name = "Riley", money = 50 },
--     { name = "Morgan", money = 750 },
-- }

-- local serverSettings = {
--     maxPlayers = 32,
--     map = "rp_downtown",
--     pvp = true,
-- }

-- local function countRich(plys)
--     local richPlys = 0

--     for _, ply in ipairs(plys) do
--         if ply.money > 500 then
--             print(ply.name .. " has " .. ply.money .. " dollars.")
--             richPlys = richPlys + 1
--         end
--     end

--     print("This team has " .. richPlys .. " rich players \n ----------------------")
-- end

-- for key, value in pairs(serverSettings) do
--     print(key .. ": " .. tostring(value))
-- end

-- countRich(blueTeam)
-- countRich(redTeam)


-- LOOPS EXERCISE.
-- local shop = {
--     { name = "Pistol", price = 200, stock = 5 },
--     { name = "Medkit", price = 50, stock = 0 },
--     { name = "Armor", price = 300, stock = 2 },
--     { name = "Lockpick", price = 100, stock = 8 },
-- }

-- local playerInfo = {
--     name = "Bob",
--     money = 250,
--     job = "Thief",
-- }

-- for i, item in ipairs(shop) do -- PART 1
--     print(i, item.name .. ": $" .. item.price)     -- why dont we do item[i].name instead? I struggle to understand when to use the square brackets and stuff?
-- end

-- print("--------------------------------")

-- for key, value in pairs(playerInfo) do -- PART 2
--     print(key .. " = " .. value)
-- end

-- print("--------------------------------")

-- local function countInStock(items) -- PART 3
--     local itemsInStock = 0

--     for _, item in ipairs(items) do
--         if item.stock > 0 then
--             itemsInStock = itemsInStock + 1
--         end
--     end
--     print("There are " .. itemsInStock .. " items in stock.")
-- end

-- countInStock(shop)

-- print("--------------------------------")

-- local function showAffordable(items, money)  -- PART 4
--     print("Bob can afford:")
--     for _, item in ipairs(items) do
--         if item.stock > 0 and item.price <= money then
--             print(item.name)
--         end
--     end 
-- end

-- showAffordable(shop, playerInfo.money)

local policeJobs = {
    { name = "Officer", salary = 150 },
    { name = "Chief", salary = 400 },
}

local criminalJobs = {
    { name = "Thief", salary = 50 },
    { name = "Hitman", salary = 300 },
    { name = "Dealer", salary = 120 },
}

local function totalSalary(jobs) 
    local salaryTotal = 0

    for _, job in ipairs(jobs) do
        salaryTotal = salaryTotal + job.salary
    end

    return salaryTotal
end

print("Police Salary: $" .. totalSalary(policeJobs))
print("Criminal Salary: $" .. totalSalary(criminalJobs))

print(criminalJobs[2].name) -- bonus question


-- HOOKS PRACTICE
hook.Add("PlayerSay", "ln04_healCmd", function(ply, text)
    
    if string.lower(text) == "!heal" and ply:Alive() then
        if ply:Health() < ply:GetMaxHealth() then
            ply:SetHealth(ply:GetMaxHealth())
            ply:ChatPrint("You have been set to max health now!")

        else 
            ply:ChatPrint("You are already at max health.")
        end

        return ""
    end
end)
