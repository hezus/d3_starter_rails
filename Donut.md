# Donut charts

Using the knowledge of selectors, databind, chaining methods and projection, lets make a donut
 
It will look like this https://bl.ocks.org/mbostock/3887193
 
## Draw a donut

- Create a empty page html
- Add the d3 library in the `<head>` of the HTML using their CDN `<script src="https://d3js.org/d3.v4.min.js"></script>`
- Add a `<script></script>` area to the HTML at the bottom of the `<body>`
- Create a variable to hold some data to visualise 

```javascript
var dataset = [
			  {category: "Fullstack", value: 15},
	      {category: "Backend", value: 5},
	      {category: "Frontend", value: 8}
      ];
```

- Add a variable for width of 950 and a height of 500 and a radius of 250
- create a new arc creator and set its inner and outer radius

```javascript
var arc = d3.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);
```

The arc creator will generate paths for us

- Use a pie layout to calculate the angles for the data. The pie layout uses the arc generator to create the projection

```javascript
var pie = d3.pie()
    .sort(null)
    .value(function(d) { return d.value; });
```
    
- add a `<svg>` element to the `<body>`     

```javascript
var donut = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
```

- create a databinding for the dataset.

```javascript
var g = donut.selectAll(".arc")
    .data(pie(dataset))
  .enter().append("g")
    .attr("class", "arc");
```   

- draw a path for each entry of the dataset using the arc generator 

```javascript
g.append("path")
      .attr("d", arc)         
```   

## Add some colors

Now the donut show some black arcs, lets add some color to that.

- We start by making a ordinal scale. 

```javascript
var color = d3.scaleOrdinal()
    .range(["#98abc5", "#8a89a6", "#7b6888"])
```
    
- Then use this scale on the path 

```javascript
g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.category); });
```

## Introduce some better data and nesting

- replace the dataset with some better data

```javascript
var dataset = [
			  {category: "Fullstack", gender: "male", age: 25},
			  {category: "Fullstack", gender: "male", age: 26},
			  {category: "Fullstack", gender: "male", age: 30},
			  {category: "Fullstack", gender: "male", age: 31},
			  {category: "Fullstack", gender: "male", age: 31},
			  {category: "Fullstack", gender: "male", age: 33},
			  {category: "Fullstack", gender: "male", age: 35},
			  {category: "Fullstack", gender: "female", age: 25},
			  {category: "Fullstack", gender: "female", age: 26},
			  {category: "Fullstack", gender: "female", age: 31},
			  {category: "Fullstack", gender: "female", age: 35},
			  {category: "Fullstack", gender: "female", age: 35},
			  {category: "Backend", gender: "male", age: 25},
			  {category: "Backend", gender: "male", age: 25},
			  {category: "Backend", gender: "male", age: 30},
			  {category: "Backend", gender: "male", age: 40},
			  {category: "Backend", gender: "female", age: 25},
			  {category: "Backend", gender: "female", age: 25},
			  {category: "Backend", gender: "female", age: 25},
			  {category: "Backend", gender: "female", age: 30},
			  {category: "Backend", gender: "female", age: 31},
			  {category: "Backend", gender: "female", age: 31},
			  {category: "Backend", gender: "female", age: 33},
			  {category: "Backend", gender: "female", age: 35},
			  {category: "Backend", gender: "female", age: 35},
			  {category: "Frontend", gender: "male", age: 25},
			  {category: "Frontend", gender: "male", age: 27},
			  {category: "Frontend", gender: "male", age: 35},
			  {category: "Frontend", gender: "female", age: 25},
			  {category: "Frontend", gender: "female", age: 35},
      ];
```

This data needs to be grouped to render in the donut and add a amount to each.
- Group the data using a nest function. this should be done above the drawing of the donut.

```javascript
let groupByCategory =d3.nest()
    .key(function(d) { return d.category; }).sortKeys(d3.ascending)
    .rollup(function(v) { return v.length; })
    .entries(dataset);
```      

- Use the nested data instead of the previous dataset.
 
```
var g = donut.selectAll(".arc")
    .data(pie(groupByCategory))
  .enter().append("g")
    .attr("class", "arc");
```

- When using a nest function you can access the category by the key field. Replace the fill function for the path by `return color(d.data.key);`


