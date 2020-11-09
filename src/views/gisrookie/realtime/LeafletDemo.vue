<template>
  <div id="map" class="test" style="width:100%;height: 850px;"></div>
</template>

<script>
  import L from  'leaflet'
  import Provider from 'leaflet.chinatmsproviders'
      export default {
      mounted() {
        Provider(L)
        this.getMap()
      },
      methods:{
        getMap(){
          var map = L.map("map", {
            center: [30.626813, 104.063994],
            zoom: 12,
            layers: [normal],
            zoomControl: false
          });

         L.tileLayer.chinaProvider('TianDiTu.Normal.Map',{
           key:'af2ddfc2b9ad28d338fc8e5a989717fa',
           maxZoom:18,
           minZoom:5,
         }).addTo(map);
          L.tileLayer.chinaProvider('TianDiTu.Normal.Annotion',{
            maxZoom:18,
            minZoom:5,
            key:'af2ddfc2b9ad28d338fc8e5a989717fa',
          }).addTo(map);
        }
      }
    }
</script>

<style>
</style>