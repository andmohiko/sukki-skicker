<template>
  <div class="login">
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <div class="flex items-center justify-between">
        <div
          v-for="skicker in skickers"
          :key="skicker.id"
        >
          名前：{{ skicker.name }}
          火力：{{ skicker.power }}
          コスト：{{ skicker.cost }}
        </div>
        
      </div>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios"

export default {
  async asyncData() {
    const skickers_data = await axios.get(`/skickers`)
    return {
      skickers: skickers_data.data.value
    }
  },
  data() {
    return {
      skickers: []
    }
  },
  computed: {
    user () {
      return this.$store.state.user
    }
  },
  methods : {
  }
}
</script>

<style scoped lang="scss">
.login {
  margin-top: 100px;
}
</style>