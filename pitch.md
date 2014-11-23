<style>

.reveal section del {
  color: blue;
  font-weight:bold;
  width: 100%;
}

</style>


ShinyApp: Exploring Unemployment by County in USA, 2009
========================================================
transition: rotate
author: Coursera Student
date: Sat Nov 22 18:19:30 2014
font-family: 'Helvetica'

Overview
========================================================

The ShinyApp is designed to visualize the unemployment data by county in 2009. There are three tabpanels, including ~~Window~~, ~~Overall~~, and ~~About~~.
- ~~Window~~ 
 - Histogram of unimployment by county with a window.
 - Viewlize map of counties in the unemployment window.
 - List user-defined number of counties within the window. 
- ~~Overall~~ 
 - A map colored according to unemployment rate.
- ~~About~~
 - A brief note on the ShinyApp.


Histogram of Unemployment
========================================================
left: 70%

![plot of chunk unnamed-chunk-1](pitch-figure/unnamed-chunk-1.png) 

***
 
<small>
Select unemployment rate and window size to view map/list of counties.

Here is an example.
* unimployment rate = 12 
* window size = 1 
</small>

Counties in Unemploment Window 
========================================================
left: 50%

<small>
~~Map of Counties in Unemployment Window~~
</small>

![plot of chunk unnamed-chunk-2](pitch-figure/unnamed-chunk-2.png) 

***

<small>
~~List of Wanted Counties~~ 
<small>
<small><small>
- input county number = 10
</small></small>

```
    county    state unemp
  Rockdale  Georgia    12
  Boundary    Idaho    12
 Vermilion Illinois    12
     Henry  Indiana    12
    Wabash  Indiana    12
     Knott Kentucky    12
   Letcher Kentucky    12
     Alger Michigan    12
    Benzie Michigan    12
 Dickinson Michigan    12
```
</small></small>

Map Colored by Unemployment
========================================================
![plot of chunk unnamed-chunk-4](pitch-figure/unnamed-chunk-4.png) 

~~Summary~~
- Demonstrate ShinyApp to explore unemployment data. 
- See map/list of counties in the window of histogram.    
- Show colored map for overview of unemplotment.
