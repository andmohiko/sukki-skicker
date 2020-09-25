<template>
  <div class="container">
    {{ sukipi.name }}
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
  mounted() {
    this.suki = this.$store.state.sukipi.suki
    console.log('sukkis', this.$store.state.sukkis)
  },
  computed: {
    user () {
      return this.$store.state.user
    },
    skickers() {
      return this.$store.state.skickers
    },
    sukipi() {
      return this.$store.state.sukipi
    }
  },
  methods : {
    skick() {
      try {
        this.suki = this.suki + 1
        axios.patch(`/sukkis/${this.sukipi.skicker_id}`, {
          suki: this.suki
        })
      } catch {
        console.log('failed to skick')
      }
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