# Dashboard

We will create a dashboard now to combine the donut with the barchart.

## Lets combine the 2 labs

Make a copy of the donut using the extended data.
Create a barchart for the amount of men and women.

- Start by creating a nest function to display bars for gender

```javascript
let groupByGender =d3.nest()
    .key(function(d) { return d.gender; }).sortKeys(d3.ascending)
    .rollup(function(v) { return v.length; })
    .entries(dataset);
```
  
- Add a <svg> element with a <g> to the body

```javascript
var bars = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr("class", "barchart")
  .append("g")
    .attr("transform", "translate(" + 200 + "," + 200 + ")");
```

- add a variable to hold the barHeight of 100;
- create the databinding with the nested dataset

```javascript
var bar = bars.selectAll("g")
    .data(groupByGender)
  .enter().append("g")
    .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });
```

- add a x scale 

```javascript
var x = d3.scaleLinear()
    .domain([0, d3.max(groupByGender, function(d){
      return d.value;
    })])
    .range([0, width/2]);
```

- add rectangles
    
```javascript
bar.append("rect")
  .attr("width", function(d){ return x(d.value); })
  .attr("height", barHeight - 1);
```

- add some text to show the keys

```javascript
bar.append("text")
  .attr("x", -100)
  .attr("y", barHeight / 2)
  .attr("dy", ".35em")
  .text(function(d) { return d.key; });
```

- add a text element to show the values

```javascript
bar.append("text")
  .attr("x", function(d){
      return x(d.value);
    })
  .attr("y", barHeight / 2)
  .attr("dy", ".35em")
  .text(function(d) { return d.value; });
```



## Add some interaction

- Lets add a click handler to the arcs
 
```javascript
var g = donut.selectAll(".arc")
    .data(pie(groupByCategory))
  .enter().append("g")
    .attr("class", "arc");
    .on("click", updateBarChart)
```     

this will call the updateBarChart function each time you click the donut

## Update the barchart

There is a bit of refactoring that needs to be done to make the update function work. 
Basically it will filter out for a specific category and update the bars.

- Lets start by refactoring our bar chart drawing. Lets wrap the whole barchart in a function except the adding of the svg.
- Create a function updateBarChart
- move the nesting there
- move the datajoin
- move the appending of rect and the 2 text nodes

- after closing  of the function call it.
- check if the chart still renders as expected

## Filter the data

now its time to make a filter for the data based on the category


- assign the dataset to a temp variable
- change the update function to take d and i argument
- use the javascript function filter() on dataset and assign the result to the temp variable

```
barData = dataset.filter(function(trainee){
      return trainee.category === d.data.key;
    })
```   
 
- use the tempvariable as input for the nest function 
- remove all the bars before doing the datajoin

```
bars.selectAll("g").remove()
```
 
 