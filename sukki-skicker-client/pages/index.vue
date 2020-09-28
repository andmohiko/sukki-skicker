<template>
  <div class="container">
    <div class="sukipi">
      <p class="sukipi-title">この人にすきを送る</p>
      <p class="sukipi-name">{{ sukipi.name }}</p>
    </div>
    <button
      class="skick"
      type="button"
      @click="skick"
    >❤️</button>
    <div class="suki">
      {{ suki }}
    </div>
    <div>
      <button
        class="bg-blue hover:bg-blue-dark text-black font-bold py-2 px-4 rounded"
        type="button"
        @click="reflectSukipi"
      >
        すきを反映する
      </button>
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
  },
  computed: {
    user() {
      return this.$store.state.user
    },
    sukipi() {
      return this.$store.state.sukipi
    },
    sukipis() {
      return this.$store.state.sukipis
    },
    currentSkicker() {
      return this.$store.state.currentSkicker
    }
  },
  methods : {
    skick() {
      this.suki = this.suki + this.currentSkicker.power
      axios.put(`/sukipis/${this.sukipi.sukipi_id}`, {
        suki: this.suki
      })
      this.$store.commit('setSukipi', {
        name: this.sukipi.name,
        suki: this.suki,
        sukipi_id: this.sukipi.sukipi_id
      })
    },
    async reflectSukipi() {
      const sukipis_data = await axios.get(`/sukipis?uid=${this.user.uid}`)
      this.$store.commit('setSukipis', sukipis_data.data.value)
    }
  }
})
</script>

<style scoped lang="scss">
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
.sukipi {
  margin: 20px;
  &-title {
    font-size: 16px;
    margin-bottom: 10px;
  }
  &-name {
    font-size: 24px;
  }
}
</style>