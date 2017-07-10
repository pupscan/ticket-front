<template>
  <div class="animated fadeIn">

    <div class="row">
      <div class="col-sm-6 col-md-4">
        <div class="card card-inverse card-success">
          <div class="card-block pb-0">
            <div class="h1 text-muted pull-right mb-4">
              <i class="fa fa-plus-circle"></i>
            </div>
            <h4 class="mb-0">{{totalNewThisWeek}} tickets this week</h4>
            <p>New</p>
          </div>
          <card-line3-chart-example class="chart-wrapper" style="height:70px;" tag="all"/>
        </div>
      </div><!--/.col-->
      <div class="col-sm-6 col-md-4">
        <div class="card card-inverse card-info">
          <div class="card-block pb-0">
            <div class="h1 text-muted pull-right mb-4">
              <i class="fa fa-smile-o"></i>
            </div>
            <h4 class="mb-0">{{totalHappyThisWeek}} tickets this week</h4>
            <p>Happy</p>
          </div>
          <card-line3-chart-example class="chart-wrapper" style="height:70px;" tag="happy"/>
        </div>
      </div><!--/.col-->
      <div class="col-sm-6 col-md-4">
        <div class="card card-inverse card-danger">
          <div class="card-block pb-0">
            <div class="h1 text-muted pull-right mb-4">
              <i class="fa fa-frown-o"></i>
            </div>
            <h4 class="mb-0">{{totalUnhappThisWeek}} tickets this week</h4>
            <p>Unhappy</p>
          </div>
          <card-line3-chart-example class="chart-wrapper" style="height:70px;" tag="unhappy"/>
        </div>
      </div>
    </div>

    <div class="card">
      <div class="card-block">
        <div class="row">
          <div class="col-sm-5">
            <h4 class="card-title mb-0">New / Happy / Unhappy</h4>
            <!--<div class="small text-muted">Updated 2 hour ago</div>-->
          </div><!--/.col-->
          <!--<div class="col-sm-7 hidden-sm-down">-->
          <!--<button type="button" class="btn btn-primary float-right"><i class="icon-cloud-download"></i></button>-->
          <!--<div class="btn-toolbar float-right" role="toolbar" aria-label="Toolbar with button groups">-->
          <!--<div class="btn-group mr-3" data-toggle="buttons" aria-label="First group">-->
          <!--<label class="btn btn-outline-secondary" :class="{ active: isWeek }" @click="switchWeekMonth(true)"-->
          <!--@click.prevent>-->
          <!--<input type="radio" name="options" id="option1"> Week-->
          <!--</label>-->
          <!--<label class="btn btn-outline-secondary" :class="{ active: !isWeek }"-->
          <!--@click="switchWeekMonth(false)" @click.prevent>-->
          <!--<input type="radio" name="options" id="option2" checked> Month-->
          <!--</label>-->
          <!--</div>-->
          <!--</div>-->
          <!--</div>&lt;!&ndash;/.col&ndash;&gt;-->
        </div><!--/.row-->
        <main-bar-chart class="chart-wrapper"
                        style="height:300px;margin-top:40px;"
                        :chart-data="datacollection"
                        v-if="isLoaded"
        ></main-bar-chart>
      </div>
      <div class="card-footer">
        <ul>
          <li>
            <div class="text-muted">All</div>
            <strong>{{ totalTicket }} tickets (100 %)</strong>
            <div class="progress progress-xs mt-2">
              <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100"
                   aria-valuemin="0"
                   aria-valuemax="100"></div>
            </div>
          </li>
          <li class="hidden-sm-down">
            <div class="text-muted">Happy</div>
            <strong>{{ totalHappy }} tickets ({{totalHappyPercent}} %)</strong>
            <div class="progress progress-xs mt-2">
              <div class="progress-bar bg-info" role="progressbar"
                   v-bind:style="{ width: totalHappyPercent + '%' }"
                   aria-valuenow="totalHappyPercent"
                   aria-valuemin="0"
                   aria-valuemax="100"></div>
            </div>
          </li>
          <li>
            <div class="text-muted">Unhappy</div>
            <strong>{{ totalUnhappy }} tickets ({{totalUnhappyPercent}} %)</strong>
            <div class="progress progress-xs mt-2">
              <div class="progress-bar bg-danger" role="progressbar"
                   v-bind:style="{ width: totalUnhappyPercent + '%' }"
                   aria-valuenow="totalHappyPercent"
                   aria-valuemin="0"
                   aria-valuemax="100"></div>
            </div>
          </li>
        </ul>
      </div>
    </div><!--/.card-->

    <div class="input-group">
      <input v-on:input="debounceInput" placeholder="Global search" class="form-control">
      <span class="input-group-btn">
          <button type="button" class="btn btn-primary">
            <i class="fa fa-search"></i> Find {{ tickets.length }} tickets
          </button>
        </span>
    </div>
    <table class="table table-hover table-outline mb-0">
      <thead class="thead-default">
      <tr>
        <th>Ticket</th>
        <th class="text-center">Status</th>
        <th>Tags</th>
        <th>Created</th>
        <th>Link</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="ticket in tickets">
        <td style="width:40%">
          <div><b>{{ ticket.name }}</b> - {{ ticket.email }}</div>
          <div class="small text-muted">
            <b>{{ ticket.subject }}</b><br/>
            {{ ticket.message }}
          </div>
        </td>
        <td class="text-center" v-bind:title="ticket.status">
          <i class="fa" v-bind:class="{ 'fa-plus-circle': ticket.status === 'new',
          'fa-trash': ticket.status === 'deleted', 'fa-remove ': ticket.status === 'closed',
          'fa-spinner ': ticket.status === 'pending', 'fa-check-square ': ticket.status === 'solved'}"></i>
        </td>
        <td>
          <strong>{{ticket.tags}}</strong>
        </td>
        <td>
          <strong>{{ticket.created}}</strong>
          <div class="small text-muted">Upadated: {{ticket.updated}}</div>
        </td>
        <td class="text-center" v-bind:title="ticket.status">
          <i class="fa fa-external-link"></i>
        </td>
      </tr>
      </tbody>
    </table>

  </div>
</template>

<script>
  import MainBarChart from './dashboard/MainBarChart'
  import CardLine3ChartExample from './dashboard/CardLine3ChartExample'
  import axios from 'axios'
  import _ from 'lodash'

  export default {
    name: 'dashboard',
    components: {
      MainBarChart,
      CardLine3ChartExample
    },
    data: () => ({
      isLoaded: false,
      totalTicket: 0,
      totalHappy: 0,
      totalUnhappy: 0,
      totalHappyPercent: 0,
      totalUnhappyPercent: 0,
      totalHappyThisWeek: 0,
      totalNewThisWeek: 0,
      totalUnhappyThisWeek: 0,
      datacollection: {},
      tickets: []
    }),
    mounted () {
      axios.get(`http://localhost:8080/ticket/main`)
        .then((response) => {
          this.datacollection = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October',
              'November', 'December'],
            datasets: [
              {
                label: 'All',
                backgroundColor: convertHex('#4dbd74', 10),
                borderColor: '#4dbd74',
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: response.data.all
              },
              {
                label: 'Happy',
                backgroundColor: convertHex('#20a8d8', 10),
                borderColor: '#20a8d8',
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: response.data.happy
              },
              {
                label: 'Unhappy',
                backgroundColor: convertHex('#f86c6b', 10),
                borderColor: '#f86c6b',
                pointHoverBackgroundColor: '#fff',
                borderWidth: 2,
                data: response.data.unhappy
              }
            ]
          }
          this.totalTicket = response.data.totalAll
          this.totalHappy = response.data.totalHappy
          this.totalUnhappy = response.data.totalUnhappy
          this.totalHappyPercent = Math.round(this.totalHappy / this.totalTicket * 100)
          this.totalUnhappyPercent = Math.round(this.totalUnhappy / this.totalTicket * 100)
          this.isLoaded = true
        })
      axios.get(`http://localhost:8080/ticket/trend/value/happy`)
        .then((response) => {
          this.totalHappyThisWeek = response.data
        })
      axios.get(`http://localhost:8080/ticket/trend/value/all`)
        .then((response) => {
          this.totalNewThisWeek = response.data
        })
      axios.get(`http://localhost:8080/ticket/trend/value/unhappy`)
        .then((response) => {
          this.totalUnhappThisWeek = response.data
        })
      axios.get(`http://localhost:8080/ticket/all`)
        .then((response) => {
          this.tickets = response.data
        })
    },
    methods: {
      debounceInput: _.debounce(
        function (e) {
          axios.post('http://localhost:8080/ticket/search', e.target.value)
            .then(function (response) {
              this.tickets = response.data
            }.bind(this))
        }, 500)
    }
  }

  function convertHex (hex, opacity) {
    hex = hex.replace('#', '')
    const r = parseInt(hex.substring(0, 2), 16)
    const g = parseInt(hex.substring(2, 4), 16)
    const b = parseInt(hex.substring(4, 6), 16)

    const result = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity / 100 + ')'
    return result
  }
</script>
