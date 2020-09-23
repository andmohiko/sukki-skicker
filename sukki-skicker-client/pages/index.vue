<template>
  <div class="container">
    <button
      class="skick"
      type="button"
      @click="skick"
    >❤️</button>
    <div class="suki">
      {{ suki }}
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import axios from '@/plugins/axios'

export default Vue.extend({
  data() {
    return {
      suki: 0
    }
  },
  components: {
  },
  methods : {
    skick() {
      this.suki = this.suki + 1
    }
  }
})
</script>

<style lang="scss">
.container {
  margin: 0 auto;
  min-height: calc(100vh - 80px);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}
.skick {
  font-size: 100px;
}
.suki {
  font-size: 100px;
}
</style>