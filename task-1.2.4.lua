
-- NOTE: This is a WIP! *gets the black and yellow WIP tape*
-- WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP 

t = {}
debug = {}


box1_input = { x1 = 20, y1 = 20, x2 = 120, y2 = 120 }
box2_input = { x1 = 200, y1 = 200, x2 = 300, y2 = 280 }

function create_box (x1, y1, x2, y2)
  local box = { type = "box" }
  if (x1 < x2) then
    box.x1, box.x2, box.x3, box.x4 = x1, x1, x2, x2
  else
    box.x1, box.x2, box.x3, box.x4 = x2, x2, x1, x1
  end
  if (y1 > y2) then
    box.y1, box.y2, box.y3, box.y4 = y2, y1, y1, y2
  else
    box.y1, box.y2, box.y3, box.y4 = y1, y2, y2, y1
  end
  return box
end

box1 = create_box(box1_input.x1, box1_input.y1, box1_input.x2, box1_input.y2)
box2 = create_box(box2_input.x1, box2_input.y1, box2_input.x2, box2_input.y2)

--[[ Hypothetic situation:

               2----------------3
               |                |
  2------------+---3    2       |
  |            |   |            |
  |       1    1---+------------4
  |                |
  1----------------4

--]]

-- Considering these functions will work with floats in the future
-- I'm not adding >= or <= as there is no point in that (pun intended)

function check_pointInside (x, y, box)
  return (((x > box.x1)and(x < box.x3)) and ((y > box.x2)and(y < box.x4)))
end

-- function check_polygonRadius (poly1, poly2)
--   --
-- end
-- function check_boxRadius (b1, b2)
--   local x1, y1 = (b1.x3-b1.x1)
-- end

function check_linesCross (x11, y11, x12, y12, x21, y21, x22, y22)
  -- 4 occasions (90 deg turns)
  -- local m1, m2 = ((y12-y11)/(x12-x11)), ((y22-y21)/(x22-x21))
  -- -- local f1, f2 = (x*m1 - x1*m1 + y1), (x*m2 - x2*m2 + y2)
  -- local k1, k2 = m, m
  -- local b1, b2 = (y1 - x1*m1), (y1 - x1*m2)
  -- --   y - y1 = m*(x - x1)
  -- --   y = x*m - x1*m + y1
  -- --   k = m
  -- --   b = y1 - x1*m
  local p_down = (x11-x12)*(y21-y22) - (y11-y12)*(x21-x22)
  local px = ((x11*y12-y11*x12)*(x21-x22)-(x11-x12)*(x21*y22-y21*x22))/p_down
  local py = ((x11*y12-y11*x12)*(y21-y22)-(y11-y12)*(x21*y22-y21*x22))/p_down

  local between = function (a, p, b)
    return (  ( (a < p) and (p < b) )  or  ( (b < p) and (p < a) )  )
  end

  local cross = (  (between(x11, px, x12)) and (between(y11, px, y12))  ) or (  (between(x21, py, x22)) and (between(y21, py, y22))  )

  if cross then
    return true, {px, py}
  else
    return false
  end

  -- return false

end

-- function check_boxCollision (b1, b2)
--   for i=1,4 do
--     if check_pointInside(b1["x"..i], b1["y"..i], b2) then
--       for j=1,4 do
--         if check_pointInside(b2["x"..j], b2["y"..j], b1) then
--           return true, {{x = b1["x"..i], y = b2["y"..j]}, {x = b2["x"..i], y = b1["y"..j]}}
--         end
--       end
--       -- error("Something weird happend, invalid box")
--     end
--   end
--   return false
-- end
function check_polygonCollision (poly1, poly2)
  local points = {}
  if (poly1.type == "box") and (poly2.type == "box") then
    debug.type = "box"
    -- if not check_boxRadius(poly1, poly2) then debug.r = "box radius failed"; return nil end
    for i=1,4 do
      for j=1,4 do
        local yes, point = check_linesCross(poly1["x"..i], poly1["y"..i], poly1["x"..(i+1)], poly1["y"..(i+1)], poly2["x"..j], poly2["y"..j], poly2["x"..(j+1)], poly2["y"..(j+1)])
        if yes then
          table.insert(points, point)
          debug.point = "box"
          -- table.insert(debug, point)
        end
      end
    end
    return points
  end
  return nil
end

