<template>
  <div class="spatialSampling">
    <div id="map_container"></div>
  </div>
</template>

<script>
  import { WebsocketMixin } from '@/mixins/WebsocketMixin'
  export default {
    name: 'ClassificationPoints',
    mixins: [WebsocketMixin],
    components: {},
    data() {
      return {
        view: null,
        pointLayer: null,
      }
    },
    created() {},
    watch: {
      deep: true,
      classificationPositionMessage: function (newVal, oldVal) {
        //this.view.removeLayer(this.pointLayer);
        //this.view.removeAllLayers()
        var datas = []
        var sourceJSON = JSON.stringify(newVal)
        var sourceData = JSON.parse(sourceJSON)
        for (var i=0; i< sourceData.length; i++) {
          var pointList = sourceData[i].points
          var data =[]
          for(var j = 0; j< pointList.length; j++){
            var wgsX = pointList[j].longitude;
            var wgsY = pointList[j].latitude
            var pointflage = {
              geometry: {
                type: 'Point',
                coordinates: [wgsX, wgsY]
              },
              properties: {
                cluster: 1,
                types: 1
              }
            }
            data.push(pointflage)
          }
          datas.push(data)
        }
        for(var k=0; k<datas.length; k++){
          console.log("种类===========>", datas.length)
          var red = Math.floor(Math.random() * Math.floor(255))
          var green = Math.floor(Math.random() * Math.floor(255))
          var blue = Math.floor(Math.random() * Math.floor(255))
          this.pointLayer = new mapvgl.PointLayer({
            blend: 'lighter',
            shape: 'circle',
            color: 'rgba('+red+',+'+ green+','+ blue+', 0.6)', // 点图层2颜色
            data: datas[k],
            size: 5
          })
          this.view.addLayer(this.pointLayer)
        }
      }
    },
    mounted() {
      var map = initMap({
        tilt: 48.8,
        heading: 0,
        center: [104.063994, 30.626813],
        zoom: 15,
        style: whiteStyle
      })
      this.view = new mapvgl.View({
        map: map
      })
    },
    computed: {},
    methods: {
    }
  }
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