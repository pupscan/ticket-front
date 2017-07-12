<script>
  import {Line} from 'vue-chartjs'
  import {HTTP} from '../axios'

  export default Line.extend({
    props: ['tag'],
    mounted () {
      HTTP.get('/ticket/trend/' + this.tag)
        .then((response) => {
          this.renderChart({
            labels: response.data,
            datasets: [
              {
                label: this.tag,
                backgroundColor: 'rgba(255,255,255,.2)',
                borderColor: 'rgba(255,255,255,.55)',
                data: response.data
              }
            ]
          }, {
            maintainAspectRatio: false,
            legend: {
              display: false
            },
            scales: {
              xAxes: [{
                display: false
              }],
              yAxes: [{
                display: false
              }]
            },
            elements: {
              line: {
                borderWidth: 2
              },
              point: {
                radius: 0,
                hitRadius: 10,
                hoverRadius: 4
              }
            }
          })
        })
    }
  })
</script>
