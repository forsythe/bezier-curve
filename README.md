### bezier-curve

![demo](https://i.gyazo.com/7f8a628092ae5fc91fd2027a94711796.gif)  
The program uses [De Casteljau's algorithm](https://en.wikipedia.org/wiki/De_Casteljau%27s_algorithm) to create bezier curves for data streams.  

### pseudocode  
```
function drawCurve(points[], t):  
  if(points.length==1):
    draw(points[0])
  else:
    newpoints=array(points.size-1)
    for(i=0; i<newpoints.length; i++):
      newpoints[i] = (1-t) * points[i] + t * points[i+1]
    drawCurve(newpoints, t)
```
Psuedocode taken from [here](https://pomax.github.io/bezierinfo/#decasteljau).
