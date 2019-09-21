
function f (num)
  local tmp = 1
  for i=1, num do
    tmp = tmp * i
  end
  return tmp
end

for i=1,10 do
  print(f(i))
end
