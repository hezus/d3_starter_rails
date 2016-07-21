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

copy the following HTML and open in the browser. 

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

- Create a empty page html with a div of class chart and copy the css from the previous example
- Add the d3 library in the `<head>` of the HTML using their CDN `<script src="https://d3js.org/d3.v4.min.js"></script>`
- Add a `<script></script>` area to the HTML at the bottom of the `<body>`
- We select the `.chart` div using d3. with `var chart = d3.select(".chart");`

Were going to create a [datajoin](https://bost.ocks.org/mike/join/). Between html elements and our array. A datajoin starts by defining a selection to which the data will be joined. Think of the initial join like the visualisation you would like to see. 

- We want to see some bars that represent our data. This is done by selecting all divs that will be the bars. `var bar = chart.selectAll("div");`
- Next we join the data to this selection. `var barUpdate = bar.data(data);`
- To add the missing elements to the HTML we can use the `enter()` method of `data()`. `var barEnter = barUpdate.enter().append("div");`
- `barEnter` holds the elements of the selectAll that have been added in the enter method. We can set the style of the bars using the style method `barEnter.style("width", "100px")`
- We can make the width of bar dynamic by using the bound data. To do this we use a function instead of a fixed value. The function will return the value of the bound data time 100. change the setting of the width to 100px to `function(d){ return d*100 + "px" ; }`
- Check your progress in the browser. 
- Lets set the text of the bar to the value of the bound data using the text method. `barEnter.text(function(d) { return d; });`

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

- Add a x linear scale above the selector 

```
var x = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, 420]);
```
x is now a object that we can use to translate a value of our dataset to a value of our display

- Use x() to get a display value. `function(d) { return x(d) + "px"; }`

## SVG

Now we created a barchart only using HTML elements. Lets start using SVG. SVG stands for Scalable Vector Graphics. HTML is more or less limited to blocks but in SVG we can use lines, circles, curves, masks and so on.

### Create a graph manually

Continuing with our dataset of `[4, 8, 15, 16, 23, 42]` we will make a chart in SVG. Lets start doing this manually.

- create a new html document
- use the following css

```css
.chart rect {
  fill: steelblue;
}

.chart text {
  fill: white;
  font: 10px sans-serif;
  text-anchor: end;
}
```

- add a `<svg>` element to the body. 
- give the `<svg>` the attributes width 200 and height 120
- Add a `<g>` inside the svg. This g will determine the vertical position of the bars
- To vertically position the `<g>` element, add a `transform` attribute with the value of translation(0,0)
- Inside the `<g>` element add a `<rect>` with a width attribute of 40 and a height of 19
- After the `<rect>` element add a `<text>` element to show the value of the bar.

```html
<svg width="420" height="120">
  <g transform="translate(0,0)">
    <rect width="40" height="19"></rect>
    <text x="37" y="9.5" dy=".35em">4</text>
  </g>
</svg>  
```	

- Check your progress in the browser. 
- repeat this to show the other bars in the dataset
 
### Now lets do it with a script

- Create a empty page html with a svg element that has class chart
- Use the following css

```css
.chart rect {
  fill: steelblue;
}

.chart text {
  fill: white;
  font: 10px sans-serif;
  text-anchor: end;
}
```

- Add the d3 library in the `<head>` of the HTML using their CDN `<script src="https://d3js.org/d3.v4.min.js"></script>`
- Add a `<script></script>` area to the HTML at the bottom of the `<body>`
- Add a variable to hold the data `[4, 8, 15, 16, 23, 42]`.
- Add a variable for width of 600 and one for barHeight of 20
- Select the `.chart` svg using d3 and set the width and height. 

```javascript
var chart = d3.select(".chart")
    .attr("width", width)
    .attr("height", barHeight * data.length);
```

- Create a datajoin just like we did before except this time we create `<g>` elements instead of div, just like we did in the manual SVG before this.

```javascript
var bar = chart.selectAll("g")
    .data(data)
  .enter().append("g")
    .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });
```

- We also need to create a projection. Add a scale for x (bar width)

```
var x = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, width]);
```

- To the `bar` variable cotaining the `<g>` element, add a rect. Use the `x` function for the width and set the height using the `barHeight` variable

```
bar.append("rect")
    .attr("width", x)
    .attr("height", barHeight - 1);
```

because `width` can take a integer value, we don't need to specify a function here to append + "px" to the value of `x`. Instead we use the default behaviour wich basically is equivalant too `function(d){return x(d);}` 
    
- Check your progress in the browser.    
- Add a text node to the `bar` variable
 
``` 
bar.append("text")
    .attr("x", function(d) { return x(d) - 3; })
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(function(d) { return d; });
```    

- Check your progress in the browser.












