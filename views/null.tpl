%rebase('app', title="Ciencia de Datos")
<h4>
    Dataset:
    <span class="">
        Communities and Crime Unnormalized Data Set
    </span>
</h4>
<hr/>
<div class="row center-align valign-wrapper">
    <div class="col">
        <h5>
            Información del dataset
        </h5>
    </div>
</div>
<div class="divider">
</div>
<script>
    var datos ={{listaNull}};        
    var nombres=[];
    var dict = []; // create an empty array
    var i=0;
    % for fruta in listaNomb:
        i=i+1;
        dict.push({ dato: datos[i] , nombre: "{{fruta}}" });
    % end   
    console.log(dict);


var tooltip = d3.select("div.tooltip");

function graficar() {
  var w = 2000;
  var h = 300;
  
  var svg = d3.select('body')
      .append('svg')
      .attr("width", w)
      .attr("height", h);
      
  svg.selectAll("rect")
    .data(datos)
    .enter()
    .append("rect")
    .attr("x", 0)
    .attr("y", 0)
    .attr("width", 20)
    .attr("height", 100)
    
    .attr("x", function(d, i){return i * 21 + 30 // Ancho de barras de 20 más 1 de espacio
    })
    
    .attr("height", function(d){return d;})
    
    .attr("y", function(d){return h - d; // Altura menos el dato
    })
    .on("mouseover", handleMouseOver)
    .on("mouseout", handleMouseOut);
///
        function handleMouseOver(d, i) {  // Add interactivity

            // Use D3 to select element, change color and size
            d3.select(this).attr({
              fill: "orange"
            });

            // Specify where to put label of text
            svg.append("text").attr({
               id: d + i,  // Create an id for text so we can select it later for removing on mouseout
                x: function() { return d ; }
            })
            .text(function() {
              return d;  // Value of the text
            });
          }

      function handleMouseOut(d, i) {
            // Use D3 to select element, change color back to normal
            d3.select(this).attr({
              fill: "black",
            });

            // Select text by id and then remove
            d3.select(d + i).remove();  // Remove text location
          }
///

    svg.selectAll("text")
      .data(datos)
      .enter()
      .append("text")
      .text(function(d){
        return d;
      })
    .attr("x", function(d, i){
      return i * 21 + 40 // + 5
        })
    .attr("y", function(d){
      return h - d - 3; // + 15
    })
    
}
</script>
<body onload="graficar()">
</body>
