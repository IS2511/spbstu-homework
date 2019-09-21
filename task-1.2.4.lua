

box1_input = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
box2_input = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }

function create_box (x1, y1, x2, y2)
  local box = {}
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

]]

-- Considering this function will work with floats in the future
-- I'm not adding >= or <= as there is no point in that (pun intended)
function check_pointInside (x, y, box)
  return (((x > box.x1)and(x < box.x3)) and ((y > box.x2)and(y < box.x4)))
end

function check_boxCollision (b1, b2)
  for i=1,4 do
    if check_pointInside(b1["x"..i], b1["y"..i], b2) then
      for j=1,4 do
        if check_pointInside(b2["x"..j], b2["y"..j], b1) then
          return true, {{x = b1["x"..i], y = b2["y"..j]}, {x = b2["x"..i], y = b1["y"..j]}}
        end
      end
      error("Something weird happend, invalid box")
    end
  end
  return false
end
