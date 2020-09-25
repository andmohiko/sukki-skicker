<template>
  <div class="mypage">
    <h1 class="text-center text-lg">マイページ</h1>
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <div v-if="user.login" class="bg-white rounded-lg p-6">
        <img class="h-16 w-16 rounded-full mx-auto" :src="user.profileIcon">
        <div class="text-center">
          <h2 class="text-lg">{{ user.username }}</h2>
        </div>
      </div>
    </div>
    <div class="sukipis">
      <h2 class="title">すきぴ一覧</h2>
      <ul class="sukipis-list">
        <li
          v-for="sukipi in sukipis"
          :key="sukipi.id"
          class="sukipi-name"
        >
          {{ sukipi.name }} , {{ sukipi.suki }}
          <button
            class="bg-blue hover:bg-blue-dark text-black font-bold py-2 px-4 rounded"
            type="button"
            @click="selectSukipi(sukipi)"
          >
            この人にすきを送る
          </button>
        </li>
      </ul>
      <div class="sukipis-add">
        coming soon
      </div>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    user() {
      return this.$store.state.user
    },
    sukipis() {
      return this.$store.state.sukipis
    }
  },
  methods : {
    selectSukipi(sukipi) {
      this.$store.commit('setSukipi', {
        name: sukipi.name,
        suki: sukipi.suki,
        sukipi_id: sukipi.id
      })
      console.log('set sukipi', this.$store.state.sukipi)
    }
  }
}
</script>

<style scoped lang="scss">
.mypage {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  margin-top: 100px;
}
img {
  width: 100px;
  height: auto;
}
.title {
  font-size: 24px;
  margin-top: 40px;
}
</style>
