<template>
  <baidu-map class="map" :center="{lng: 104.073193, lat: 30.663475}"  :zoom="zoom"  :scroll-wheel-zoom="true"  :mapStyle="mapStyle">
    <bm-point-collection :points="points1" shape="BMAP_POINT_SHAPE_CIRCLE" :color="color1"  size="BMAP_POINT_SIZE_SMALL" @click="clickHandler"></bm-point-collection>
  </baidu-map>
</template>

<script>
  import {WebsocketMixin} from '@/mixins/WebsocketMixin'
  export default {
      name: 'RealtimePosition',
      mixins: [WebsocketMixin],
      data(){
          return{
            points1:[],
            zoom: 15,
            mapStyle: {
              styleJson: [
                {
                  featureType: "land",
                  elementType: "geometry",
                  stylers: {
                    color: "#212121",
                  },
                },
                {
                  featureType: "building",
                  elementType: "geometry",
                  stylers: {
                    color: "#2b2b2b",
                  },
                },
                {
                  featureType: "highway",
                  elementType: "all",
                  stylers: {
                    lightness: -42,
                    saturation: -91,
                  },
                },
                {
                  featureType: "arterial",
                  elementType: "geometry",
                  stylers: {
                    lightness: -77,
                    saturation: -94,
                  },
                },
                {
                  featureType: "green",
                  elementType: "geometry",
                  stylers: {
                    color: "#1b1b1b",
                  },
                },
                {
                  featureType: "water",
                  elementType: "geometry",
                  stylers: {
                    color: "#181818",
                  },
                },
                {
                  featureType: "subway",
                  elementType: "geometry.stroke",
                  stylers: {
                    color: "#181818",
                  },
                },
                {
                  featureType: "railway",
                  elementType: "geometry",
                  stylers: {
                    lightness: -52,
                  },
                },
                {
                  featureType: "all",
                  elementType: "labels.text.stroke",
                  stylers: {
                    color: "#313131",
                  },
                },
                {
                  featureType: "all",
                  elementType: "labels.text.fill",
                  stylers: {
                    color: "#8b8787",
                  },
                },
                {
                  featureType: "manmade",
                  elementType: "geometry",
                  stylers: {
                    color: "#1b1b1b",
                  },
                },
                {
                  featureType: "local",
                  elementType: "geometry",
                  stylers: {
                    lightness: -75,
                    saturation: -91,
                  },
                },
                {
                  featureType: "subway",
                  elementType: "geometry",
                  stylers: {
                    lightness: -65,
                  },
                },
                {
                  featureType: "railway",
                  elementType: "all",
                  stylers: {
                    lightness: -40,
                  },
                },
                {
                  featureType: "boundary",
                  elementType: "geometry",
                  stylers: {
                    color: "#8b8787",
                    weight: "1",
                    lightness: -29,
                  },
                },
              ],
            },
            color1: 'red',
          }
      },
      watch:{
        deep:true,
        classificationPositionMessage: function (newVal, oldVal) {
          const points1 =[]
          const points2 =[]
          console.log("数据条数：======>", newVal.length)
          for (var i=0; i< newVal.length; i++){
          const position = {lng: newVal[i].longitude, lat: newVal[i].latitude, cluster: newVal[i].cluster, types: newVal[i].types}
            points1.push(position)
          }
          this.points1 = points1
          this.points2 = points2
        }

      },
      methods:{
        clickHandler (e) {
          alert(`单击点的坐标为：${e.point.lng}, ${e.point.lat}`);
        },
        // addPoints(){
        //   const position = {long: this.positionMessage.longitude, lat: this.positionMessage.latitude}
        //   this.points .push(position)
        // }
      },
    // created() {
    //     this.addPoints();
    // }
  }
</script>

<style >
  .map {
    width: 100%;
    height: 810px;
  }
</style>