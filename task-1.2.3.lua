
-- Task can be solved without aproximation, but I'm too lazy for that
-- Aproximation does the job here, values cleary approach known numbers

if (type(tonumber(arg[1])) ~= "number") then
  print("Calculating male/female percent (no more than 1 male in a family, 50/50 chance).")
  print("Usage: "..arg[0].." <count>")
  os.exit()
end

local cycles = tonumber(arg[1]) -- 100 000 is fine, more takes a bit of time. Accurate results at 100 000+
print("Doing "..cycles.." cycles...")

local male, female = cycles, 0

function gen1 ()
  local girl = true
  while girl do
    girl = math.random() > 0.5
    if girl then
      female = female + 1
    end
  end
  return
end

-- local t = {}
for i=1,cycles do
  -- t.insert(gen1())
  gen1()
end

-- t_max = math.max(table.unpack(t))
-- t_min = math.min(table.unpack(t))

local malePercent, femalePercent = (male/(male+female)), (female/(male+female))

print("Results: "..((malePercent-malePercent%0.001)*100).."% male | "..((femalePercent-femalePercent%0.001)*100).."% female")
