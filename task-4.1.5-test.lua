
-- Lazy tests

print("WARNING! I'm lazy, tests are bad")
print("LuaJIT needed! (switch to lua inside if needed)")

local file = "task-4.1.5.lua "
local start = "luajit "

-- if os.execute(start.."--version") == -1 then
--   start = "lua "
-- end

function test (string)
  os.execute(start..file.."\""..string.."\"")
end

print("Should be YES")
test(start..file.."(){}[]")
test(start..file.."()()()")
test(start..file.."((()))")
test(start..file.."{[((([{[[()]]}])))]}")
test(start..file.."{( [  ] [  () {  {  }  {  {   }((  [ ]  )) [   [ ] ]  ( ) }   } ]   )}")

print("\nShould be NO")
test(start..file.."((){}[]")
test(start..file..")()()()")
test(start..file.."(((][)))")
test(start..file.."{[((([{[[()]]}])))]}{")
test(start..file.."{( [  ] [  () {  {  }  {  { ()({]]{}[][]{}[]}  }((  [ ]  )) [   [ ] ]  ( ) }   } ]   )}")
