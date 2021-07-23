%rebase('app', title="Ciencia de Datos")

<h4>
    Dataset: <span class> Communities and Crime Unnormalized Data Set</span>
</h4>
<hr />
<div class="row center-align valign-wrapper">
    <div class="col">
        <h5>Data reducida en 2 dimensiones</h5>
    </div>

</div>
<div class="row center-align valign-wrapper">
    <div class="col">
        <div id="my_dataviz2"></div>
    </div>
    <div class="col">
        <h5> Selected community: <span id="hovered_comm" style="font-size: 0.7em;"></span> </h5>

        <h5> State: <span id="state_display" style="font-size: 0.7em;"></span> </h5>

    </div>
</div>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="/static/colors.js"></script>
<script>
    var n = 50; // number of points
    var max = 100; // maximum of x and y

    // dimensions and margins
    var svg = d3.select("#my_dataviz2")
        .append("svg")
        .attr("width", "1000")
        .attr("height", "500"),
        width = +svg.attr("width"),
        height = +svg.attr("height"),
        width = 0.8 * width;
    height = 0.8 * height;
    var margin = {top: (0.1*width), right: (0.1*width), bottom: (0.1*width), left: (0.1*width)};

    var data = {{!reduced_data}}

    const [first] = data
    max = data.reduce((acc, val) => {
        return Math.max(acc, val.x)
    }, first.x) + 0.5

    var min = data.reduce((acc, val) => {
        return Math.min(acc, val.x)
    }, first.x) - 0.1
    console.log('Max', max)
    // create a clipping region 
    svg.append("defs").append("clipPath")
        .attr("id", "clip")
        .append("rect")
        .attr("width", width)
        .attr("height", height);

    // create scale objects
    var xScale = d3.scaleLinear()
        .domain([min, max])
        .range([0, width]);
    var yScale = d3.scaleLinear()
        .domain([min, max])
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
        .domain(states)
        .range(colors);

    function get_color(state) {
        let index = states.indexOf(state)
        if (index == -1)
            return colors[0]
        else
            return colors[index]

    }

    // Highlight the specie that is hovered
    var highlight = function(d) {

        selected_comm = d.comm_alias.slice(-2)

        console.log(d)
        d3.selectAll(".dot")
            .transition()
            .duration(200)
            .style("fill", "lightgrey")
            .attr("r", 1)

        d3.selectAll("." + selected_comm)
            .transition()
            .duration(200)
            .style("fill", get_color(selected_comm))

        $('#hovered_comm').text(d.comm_alias.slice(0, -3))
        $('#state_display').text(d.comm_alias.slice(-2))
    }

    // Restart styles
    var doNotHighlight = function(d) {
        console.log("NOT", d)
        d3.selectAll(".dot")
            .transition()
            .duration(200)
            .style("fill", "lightgray")
            .attr("r", 5)
    }

    // Draw Datapoints
    var points_g = svg.append("g")
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
        .attr("clip-path", "url(#clip)")
        .classed("points_g", true);
    var points = points_g.selectAll("circle").data(data);

    points = points.enter().append("circle")
        .attr('class', function(d){return "dot " + d.comm_alias.slice(-2)})
        .attr('cx', function(d) {return xScale(d.x)})
        .attr('cy', function(d) {return yScale(d.y)})
        .attr('r', 3)
        .style("fill", function(d) { return get_color(d.comm_alias.slice(-2)) })
        .style('pointer-events', 'all')
        .on("mouseover", highlight)
        .on("mouseleave", doNotHighlight);




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
        .style("pointer-events", "stroke")
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
        .attr('cx', function(d) {return new_xScale(d.x)})
        .attr('cy', function(d) {return new_yScale(d.y)});
    }
</script>