<script>
  import {Line, mixins} from 'vue-chartjs'

  const {reactiveProp} = mixins

  export default Line.extend({
    mixins: [reactiveProp],
    mounted () {
      this.renderChart(this.chartData,
        {
          maintainAspectRatio: false,
          legend: {
            display: false
          },
          scales: {
            xAxes: [{
              gridLines: {
                drawOnChartArea: false
              }
            }],
            yAxes: [{
              ticks: {
                beginAtZero: true,
                maxTicksLimit: 5
              },
              gridLines: {
                display: true
              }
            }]
          },
          elements: {
            point: {
              radius: 0,
              hitRadius: 10,
              hoverRadius: 4,
              hoverBorderWidth: 3
            }
          }
        })
    }
  })
</script>
