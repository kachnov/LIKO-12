function _init()
 api.points(1,1, 192,1, 192,128, 1,128, 8)
 api.points(0,1, 193,1, 193,128, 0,128, 3)
 api.points(1,0, 192,0, 192,129, 1,129, 3)
 api.rect_line(2,2, 190,126, 12)
 --api.line(2,2,191,2,191,127,2,127,2,2,12)
 api.line(2,2, 191,127, 9)
 api.line(191, 2,2,127, 9)
 
 --api.rect(10,10,10,10,9)
 api.Image(api.ImageData(10,10):map(function() return 13 end)):draw(10,10)
  api.rect(10,42,10,10,9)
 api.rect(10,30,10,10,9)
 api.rect_line(10,30,10,10,8)
 api.points(10,10, 10,19, 19,19, 19,10, 8)
 api.color(8)
 print_grid("0 TEST",1,1)
end