<!DOCTYPE html>
<meta charset="utf-8">

<!-- Load d3.js -->
<script src="https://d3js.org/d3.v4.js"></script>

<!-- Create a div where the graph will take place -->
<div id="my_dataviz2"></div>

<script>
    // set the dimensions and margins of the graph
    var margin = {top: 10, right: 30, bottom: 40, left: 50},
    width = 520 - margin.left - margin.right,
        height = 520 - margin.top - margin.bottom;

    // append the svg object to the body of the page
    var svg = d3.select("#my_dataviz2")
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform",
            "translate(" + margin.left + "," + margin.top + ")")


    //Read the data
    d3.csv("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/iris.csv", function(data) {

        // Add X axis
        var x = d3.scaleLinear()
            .domain([4 * 0.95, 8 * 1.001])
            .range([0, width])
        var gX = svg.append("g")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x).tickSize(-height * 1.3).ticks(10))
            .select(".domain").remove()

        // Add Y axis
        var y = d3.scaleLinear()
            .domain([-0.001, 9 * 1.01])
            .range([height, 0])
            .nice()
        var gY = svg.append("g")
            .call(d3.axisLeft(y).tickSize(-width * 1.3).ticks(7))
            .select(".domain").remove()


        var xAxis = d3.axisBottom(x)
            .ticks(20, "s");
        var yAxis = d3.axisLeft(y)
            .ticks(20, "s");


        // Customization
        svg.selectAll(".tick line").attr("stroke", "#EBEBEB")


        // Add X axis label:
        svg.append("text")
            .attr("text-anchor", "end")
            .attr("x", width)
            .attr("y", height + margin.top + 20)
            .text("Sepal Length");

        // Y axis label:
        svg.append("text")
            .attr("text-anchor", "end")
            .attr("transform", "rotate(-90)")
            .attr("y", -margin.left + 20)
            .attr("x", -margin.top)
            .text("Petal Length")

        // Color scale: give me a specie name, I return a color
        var color = d3.scaleOrdinal()
            .domain(["setosa", "versicolor", "virginica"])
            .range(["#402D54", "#D18975", "#8FD175"])

        // Add dots
        var points_g = svg.append('g')
            .selectAll("dot")
            .data(data)
            .enter()
            .append("circle")
            .attr("cx", function(d) { return x(d.Sepal_Length); })
            .attr("cy", function(d) { return y(d.Petal_Length); })
            .attr("r", 5)
            .style("fill", function(d) { return color(d.Species) })

        var points = points_g.selectAll("circle").data(data);


        // Pan and zoom
        var zoom = d3.zoom()
            .scaleExtent([.5, 20])
            .extent([
                [0, 0],
                [width, height]
            ])
            .on("zoom", zoomed);

        svg.append("rect")
            .attr("width", width)
            .attr("height", height)
            .style("fill", "none")
            .style("pointer-events", "all")
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
            .call(zoom);

        function genRandomData(n, max) {
            var data = [];
            var datapoint = {};
            for (i = 0; i < n; i++) {
                datapoint = {};
                datapoint["x"] = Math.random() * max;
                datapoint["y"] = Math.random() * max;
                data.push(datapoint);
            }
            return data
        }

        function zoomed() {
            // create new scale ojects based on event
            var new_xScale = d3.event.transform.rescaleX(x);
            var new_yScale = d3.event.transform.rescaleY(y);
            // update axes
            gX.call(xAxis.scale(new_xScale));
            gY.call(yAxis.scale(new_yScale));
            points.data(data)
            .attr('cx', function(d) {return new_xScale(d.x)})
            .attr('cy', function(d) {return new_yScale(d.y)});
        }



    })
</script>