<template>
  <div class="mypage">
    <h1 class="text-center text-lg">マイページ</h1>
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <div v-if="user.login" class="bg-white rounded-lg p-6">
        <p class="text">ログイン済み</p>
        <img class="h-16 w-16 rounded-full mx-auto" :src="user.profileIcon">
        <div class="text-center">
          <h2 class="text-lg">{{ user.username }}</h2>
        </div>
      </div>
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        type="button"
        @click="loginTwitter"
      >
        Twitterでログイン
      </button>
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
        <div class="w-full max-w-xs">
          <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <div class="mb-4">
              <label class="block text-gray-700 text-sm font-bold mb-2" for="username">
                すきぴの名前
              </label>
              <input
                v-model="newSukipi"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                type="text"
                placeholder="かれぴっぴ">
            </div>
            <div class="flex items-center justify-center">
              <button
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button"
                @click="addSukipi"
              >
                追加
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios"

export default {
  components: {
  },
  data() {
    return {
      newSukipi: ''
    }
  },
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
    },
    async addSukipi() {
      const new_sukipi = {
        name: this.newSukipi,
        user_id: this.user.user_id,
        suki: 0
      }
      try {
        axios.post("/sukipis", new_sukipi)
        console.log('new sukipi created', new_sukipi)
        const sukipis_data = await axios.get(`/sukipis?uid=${this.user.uid}`)
        this.$store.commit('setSukipis', sukipis_data.data.value)
        console.log(this.sukipis)
      } catch {
        console.log('error adding sukipi')
      }
    },
    loginTwitter() {
      this.$store.dispatch('loginTwitter')
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
