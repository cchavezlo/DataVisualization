%rebase('app', title="Ciencia de Datos")
<h4>
    Dataset:
    <span class="">
        Communities and Crime Unnormalized Data Set
    </span>
</h4>
<hr />
<div class="row center-align valign-wrapper">
    <div class="col">
        <h5>
            Atributos con Datos Nulos
        </h5>
    </div>
</div>
<div class="divider"></div>
<canvas id="myChart" height="200"></canvas>

<script>
    let null_data = {{!nullDetail}};
    let labels = [];
    let data = [];

    for (let city in null_data){
      labels.push(city)
      data.push(null_data[city])
    }

    console.log(labels, data)
    
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: '# of Nulls',
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 2,
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            plugins:{
              tooltip: {
                callbacks: {
                  label: function (context) {
                    var label = context.dataset.label || '';
                    if (label) {
                      label += ': ';
                    }
                    if (context.parsed.x !== null) {
                      label += context.parsed.x + '%';
                    }

                    return label;
                  }
                }
              }
            },
            indexAxis: 'y',
            onClick: (e) => {
              console.log(e)
              var activePointLabel = Chart.helpers;
              console.log(activePointLabel)
              alert(activePointLabel);
            }
        }
    });
</script>
</body>