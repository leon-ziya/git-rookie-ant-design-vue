<template>
  <div class="spatialSampling">
    <div id="map_container"></div>
  </div>
</template>

<script>
  import {WebsocketMixin} from '@/mixins/WebsocketMixin'
  export default {
    name: 'ClassificationPoints',
    mixins: [WebsocketMixin],
    components: {},
    data() {
      return {
        points:[]
      };
    },
    created() {},
    mounted() {
      var map = initMap({
        tilt: 48.8,
        heading: 0,
        center: [104.063994,30.626813],
        zoom: 15,
        style: purpleStyle
      });

      var view = new mapvgl.View({
        map: map
      });
      var data1=[]
      var data2 = []
      var pointflage = {
        geometry:{
          type:"Point",
          coordinates:[104.063994,30.626813]
        },
        properties:{
          cluster: 1,
          types:1
        }
      }
      /*for(var i =0; i< this.points.length -1; i++){
        var geoPoint = this.points[i]
        if(this.points[i].cluster == 1){
          console.log("看看输出点数据了吗：===============\n",this.points[i])
          data1.push({
            geometry:{
              type:"Point",
              coordinates: [geoPoint.lng, geoPoint.lat]
            },
            properties:{
              cluster: geoPoint.cluster,
              type: geoPoint.types
            }
          })
        }else{
          data2.push({
            geometry:{
              type:"Point",
              coordinates: [geoPoint.lng, geoPoint.lat]
            },
            properties:{
              cluster: geoPoint.cluster,
              type: geoPoint.types
            }
          })
        }
      }

      view.addLayer(
        new mapvgl.PointLayer({
          blend: "lighter",
          shape: "circle",
          color: "rgba(255, 77, 77, 0.8)", // 点图层1颜色
          data: data1,
          size: 10
        })
      );

      view.addLayer(
        new mapvgl.PointLayer({
          blend: "lighter",
          shape: "circle",
          color: "rgba(255, 204, 0, 0.6)", // 点图层2颜色
          data: data2,
          size: 15
        })
      );
*/
      view.addLayer(
        new mapvgl.PointLayer({
          blend: "lighter",
          shape: "circle",
          color: "rgba(255, 77, 77, 0.8)", // 点图层2颜色
          data: pointflage,
          size: 5
        })
      );


    },
    computed: {},
    // watch:{
    //   deep:true,
    //   classificationPositionMessage: function (newVal, oldVal) {
    //     const points1 =[]
    //     console.log("数据条数：======>", newVal.length)
    //     for (var i=0; i< newVal.length; i++){
    //       const position = {lng: newVal[i].longitude, lat: newVal[i].latitude, cluster: newVal[i].cluster, types: newVal[i].types}
    //       points1.push(position)
    //     }
    //     this.points = points1
    //   }
    //
    // },
    methods: {}
  };
</script>

<style lang="scss">
  .spatialSampling {
    width: 100%;
    height: 100%;
    border: 1px solid red;
    #map_container {
      width: 100%;
      height: 850px;
    }
  }
</style>