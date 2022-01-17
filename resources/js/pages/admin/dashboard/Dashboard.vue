<template>
    <div class="content-wrapper">
            <!-- Main content -->
            <div class="page-content fade-in-up">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="ibox bg-success color-white widget-stat">
                            <div class="ibox-body">
                                <h2 class="m-b-5 font-strong" v-if="challenges">{{challenges.length}}</h2>
                                <h2 class="m-b-5 font-strong" v-else>0</h2>
                                <div class="m-b-5">Thử thách</div><i class="ti-bar-chart widget-stat-icon"></i>
                                <!-- <div><i class="fa fa-level-up m-r-5"></i><small>25% higher</small></div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="ibox bg-info color-white widget-stat">
                            <div class="ibox-body">
                                <h2 class="m-b-5 font-strong" v-if="solutions">{{solutions.length}}</h2>
                                <h2 class="m-b-5 font-strong" v-else>0</h2>
                                <div class="m-b-5">Giải pháp</div><i class="ti-light-bulb widget-stat-icon"></i>
                                <!-- <div><i class="fa fa-level-up m-r-5"></i><small>17% higher</small></div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="ibox bg-warning color-white widget-stat">
                            <div class="ibox-body">
                                <h2 class="m-b-5 font-strong" v-if="categories">{{categories.length}}</h2>
                                <h2 class="m-b-5 font-strong" v-else>0</h2>
                                <div class="m-b-5">Danh mục</div><i class="ti-wallet widget-stat-icon"></i>
                                <!-- <div><i class="fa fa-level-up m-r-5"></i><small>22% higher</small></div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="ibox bg-danger color-white widget-stat">
                            <div class="ibox-body">
                                <h2 class="m-b-5 font-strong" v-if="users">{{users.length}}</h2>
                                <h2 class="m-b-5 font-strong" v-else>0</h2>
                                <div class="m-b-5">Tài khoản</div><i class="ti-user widget-stat-icon"></i>
                                <!-- <div><i class="fa fa-level-down m-r-5"></i><small>-12% Lower</small></div> -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6">
                        <apexchart type="area" width="100%" :options="areaOptions" :series="areaSeries"></apexchart>
                    </div>
                    <div class="col-6">
                        <apexchart type="polarArea" width="100%" :options="polarAreaOptions" :series="polarAreaSeries"></apexchart>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <apexchart width="100%" type="bar" :options="chartOptions" :series="series"></apexchart>
                    </div>
                </div>
            </div>
            <Footer></Footer>
    </div>
</template>
<script>
import { mapGetters } from 'vuex'
import Footer from '../../../components/AdminFooter.vue';
export default {
    data() {
        return {
        title: 'Dashboard',
        areaSeries: [{
            name: "Số tiền",
            data: []
          }],
        areaOptions: {
            chart: {
              type: 'area',
              height: 400,
              zoom: {
                enabled: false
              }
            },
            dataLabels: {
              enabled: false
            },
            stroke: {
              curve: 'smooth'
            },
            title: {
              text: 'Doanh thu trong năm',
              align: 'left'
            },
            subtitle: {
              text: 'Đơn vị (VNĐ)',
              align: 'left'
            },
            xaxis: {
              categories: [],
              title: {
                    text: 'Tháng'
                },
            },
            yaxis: {
              opposite: true
            },
            legend: {
              horizontalAlign: 'left'
            }
          },
        chartOptions: {
            chart: {
                id: 'vuechart-user',
                height: 350
            },
            plotOptions: {
              bar: {
                horizontal: false,
                columnWidth: '55%',
                endingShape: 'rounded'
              },
            },
            dataLabels: {
              enabled: false
            },
            stroke: {
              show: true,
              width: 2,
              colors: ['transparent']
            },
            title: {
                text: 'Số thử thách, giải pháp và người dùng trong năm',
                align: 'left'
            },
            xaxis: {
                categories: [1,2,3,4,5,6,7,8,9,10,11,12],
                title: {
                    text: 'Tháng'
                },
            },
             yaxis: {
                // title: {
                //     text: 'Số lượng'
                // },
                min: 0,
            },
            fill: {
              opacity: 1
            },
        },
        series: [
            {
            name: 'Tài khoản',
            data: []
            },
            {
            name: 'Thử thách',
            data: []
            },
            {
            name: 'Giải pháp',
            data: []
            },
        ],
        polarAreaSeries: [4,6,2],
        polarAreaOptions: {
            chart: {
              type: 'polarArea',
            },
             dataLabels: {
                enabled: true,
                formatter: function (val) {
                return Math.round(val * 100)/100 + "%"
                },
                
            },
            stroke: {
              colors: ['#fff']
            },
            fill: {
              opacity: 0.8
            },
            labels: [],
            responsive: [{
              breakpoint: 480,
              options: {
                chart: {
                  width: 200
                },
                legend: {
                  position: 'bottom'
                }
              }
            }]
          },
        };
    },
    computed: mapGetters({
        users: 'user/all',
        challenges: 'challenge/all',
        categories: 'challengecategory/all',
        solutions: 'solution/all',
    }),
    created () {
        this.chartCate();
        this.userChart();
        this.chartRevenue();
        this.$store.dispatch('user/all');
        this.$store.dispatch('challenge/all');
        this.$store.dispatch('challengecategory/all');
        this.$store.dispatch('solution/all');
    },
  components:{
      Footer,
  },
  methods:{
     async userChart(){
          await axios.get(route("chart.user"))
            .then(response => {
            var data =response.data.data;
             this.series = [
                {
                    data: data.user
                },
                {
                    data: data.challenge
                },
                {
                    data: data.solution
                }
            ]
        })
    },
     async chartRevenue(){
          await axios.get(route("chart.order"))
            .then(response => {
            var data =response.data.data;
             this.areaSeries = [
                {
                    data: data.amount
                }
            ];
            this.areaOptions= {...this.areaOptions, ...{
                xaxis: {
                    categories: data.month
                }
            }};
        })
    },
     async chartCate(){
          await axios.get(route("chart.challengecategory"))
            .then(response => {
            var data =response.data.data;
            this.polarAreaSeries = data.amount;
            this.polarAreaOptions= {...this.polarAreaOptions, ...{
                labels: data.cate
            }};
        })
    }
  }
}
</script>