<!DOCTYPE html>
<meta charset="utf-8">
<svg width="500" height="500"></svg>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script>
    var n = 50; // number of points
    var max = 100; // maximum of x and y

    // dimensions and margins
    var svg = d3.select("svg"),
        width = +svg.attr("width"),
        height = +svg.attr("height"),
        width = 0.8 * width;
    height = 0.8 * height;
    var margin = {top: (0.1*width), right: (0.1*width), bottom: (0.1*width), left: (0.1*width)};

    d3.csv("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/iris.csv", function(data) {
        const [first] = data
        max = data.reduce((acc, val) => {
            return Math.max(acc, val.Sepal_Length)
        }, first.Sepal_Length) + 0.5
        console.log('Max', max)
        // create a clipping region 
        svg.append("defs").append("clipPath")
            .attr("id", "clip")
            .append("rect")
            .attr("width", width)
            .attr("height", height);

        // create scale objects
        var xScale = d3.scaleLinear()
            .domain([0, max])
            .range([0, width]);
        var yScale = d3.scaleLinear()
            .domain([0, max])
            .range([height, 0]);
        // create axis objects
        var xAxis = d3.axisBottom(xScale)
            .ticks(20, "s");
        var yAxis = d3.axisLeft(yScale)
            .ticks(20, "s");
        // Draw Axis
        var gX = svg.append('g')
            .attr('transform', 'translate(' + margin.left + ',' + (margin.top + height) + ')')
            .call(xAxis);
        var gY = svg.append('g')
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
            .call(yAxis);

        var color = d3.scaleOrdinal()
            .domain(["setosa", "versicolor", "virginica"])
            .range(["#402D54", "#D18975", "#8FD175"]);

        // Draw Datapoints
        var points_g = svg.append("g")
            .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
            .attr("clip-path", "url(#clip)")
            .classed("points_g", true);
        console.log(data)
        var points = points_g.selectAll("circle").data(data);
        points = points.enter().append("circle")
            .attr('cx', function(d) {return xScale(d.Sepal_Length)})
            .attr('cy', function(d) {return yScale(d.Petal_Length)})
            .attr('r', 3)
            .style("fill", function(d) { return color(d.Species) });



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
            var new_xScale = d3.event.transform.rescaleX(xScale);
            var new_yScale = d3.event.transform.rescaleY(yScale);
            // update axes
            gX.call(xAxis.scale(new_xScale));
            gY.call(yAxis.scale(new_yScale));
            points.data(data)
            .attr('cx', function(d) {return new_xScale(d.Sepal_Length)})
            .attr('cy', function(d) {return new_yScale(d.Petal_Length)});
        }
    });
</script>