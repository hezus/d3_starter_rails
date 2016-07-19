# Intro to d3.js with a barchart

Benjamin Udink ten Cate (using great tutorials by Mike Bostock and the d3 community)

We will be doing the visualisation of some data with a barchart. We will be using d3 which is a visualisation library.

Inspired by https://bost.ocks.org/mike/bar/

## HTML

### Selecting a element

In d3 you can select html just like with jquery. By using a selector you can manipulate a collection of elements. Selecting a single element is done with `d3.select("body")` while selecting a group is done with `d3.selectAll("div")`

### Chaining methods

In conventional javascript you would assign a variable and call methods. But with d3 you can chain methods

```javascript
var body = d3.select("body");
body.style("color", "black");
body.style("background-color", "white");
```

looks chained

```javascript
d3.select("body")
    .style("color", "black")
    .style("background-color", "white");
```

This can be done because the methods used on a selector return the selection.

### Making our first chart

copy the following HTML

```html
<!DOCTYPE html>
<html>
<head>
	<style>

	.chart div {
		font: 10px sans-serif;
		background-color: steelblue;
		text-align: right;
		padding: 3px;
		margin: 1px;
		color: white;
	}

	</style>
</head>
<body>
<div class="chart">
  <div style="width: 40px;">4</div>
  <div style="width: 80px;">8</div>
  <div style="width: 150px;">15</div>
  <div style="width: 160px;">16</div>
  <div style="width: 230px;">23</div>
  <div style="width: 420px;">42</div>
</div>
</body>
</html>
```

### Coding the chart

Now lets start with some real exercises.

Using the following array `var data = [4, 8, 15, 16, 23, 42];` We will create a barchart.

1. Create a empty page html with a div of class chart and copy the css from the previous example



2. Add the d3 library in the `<head>` of the HTML
3. Add a `<script></script>` area to the HTML at the bottom of the `<body>`
4. We select the `.chart` div using d3. with `var chart = d3.select(".chart");`

Were going to create a [datajoin](https://bost.ocks.org/mike/join/). Between html elements and our array. A datajoin starts by defining a selection to which the data will be joined. Think of the initial join like the visualisation you would like to see. 

5. We want to see some bars that represent our data. This is done by selecting all divs that will be the bars. `var bar = chart.selectAll("div");`
6. Next we join the data to this selection. `var barUpdate = bar.data(data);`
7. To add the missing elements to the HTML we can use the `enter()` method of `data()`. `var barEnter = barUpdate.enter().append("div");`
8. barEnter holds the elements of the selectAll that have been added in the enter method. We can set the style of the bars using the style method `barEnter.style("width", "100px")`
9. We can make the width of bar dynamic by using the bound data. To do this we use a function instead of a fixed value. The function will return the value of the bound data time 100. change the setting of the width to 100px to `function(d){ return d*100 + "px" ; }`
10. Lets set the text of the bar to the value of the bound data using the text method. `barEnter.text(function(d) { return d; });`

The final piece of code looks a bit like this:

```javascript
d3.select(".chart")
  .selectAll("div")
    .data(data)
  .enter().append("div")
    .style("width", function(d) { return d * 10 + "px"; })
    .text(function(d) { return d; });
```

### Domain and Range

The width of our barchart is now quite fixed. This is not so usefull. Especially if you don't know the values of the data because it's dynamic or if you don't know the actual measurments of the .chart element.

Instead of using this magic number 10 we can use a projection. A projection is used to translate the value of the data to a relative value in pixels.

d3 provides scales for easy handling of projections. They take a domain (data) and a range (display)

lets add a scale

1. Add a x linear scale above the selector 

```
var x = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, 420]);
```
x is now a object that we can use to translate a value of our dataset to a value of our display

2. Use x() to get a display value. `function(d) { return x(d) + "px"; }`

## SVG
Now we created a barchart only using HTML elements. Lets start using SVG. SVG stands for Scalable Vector Graphics. HTML is more or less limited to blocks but in SVG we can use lines, circles, curves, masks and so on.

Continuing with our dataset of `[4, 8, 15, 16, 23, 42]` we will make a chart in SVG. Lets start doing this manually.

1. add a <svg> element to the body. 
2. give the <svg> the attributes width 200 and height 120
3. Add a <g> inside the svg. This g will determine the vertical position of the bars
4. To vertically position the g elements, add a transform attribute with the value of translation(0,0)
5. Inside the g element add a <rect> with a width attribute of 40 and a height of 19

```
<svg width="420" height="120">
  <g transform="translate(0,0)">
    <rect width="40" height="19"></rect>
  </g>
</svg>  
```	
6. repeat this for the other bars in the dataset
