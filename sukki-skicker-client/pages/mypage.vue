<template>
  <div class="mypage">
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <h1 class="text-center text-lg">マイページ</h1>
      <div v-if="user.login" class="bg-white rounded-lg p-6">
        <img class="h-16 w-16 rounded-full mx-auto" :src="user.profileIcon">
        <div class="text-center">
          <h2 class="text-lg">{{ user.username }}</h2>
        </div>
      </div>
    </div>
    <div class="skickers">
      <div class="title">
        すきっかー一覧
      </div>
      <div
        v-for="skicker in skickers"
        :key="skicker.id"
        class="skickers-list"
      >
        名前: {{ skicker.name }}
        {{ skicker }}
        <button
          class="bg-blue hover:bg-blue-dark text-black font-bold py-2 px-4 rounded"
          type="button"
          @click="selectSukipi(skicker)"
        >
          この人にすきを送る
        </button>
      </div>
      <div class="title">
        すきっかー追加
      </div>
      comming soon
      <button
        class="bg-blue hover:bg-blue-dark text-black font-bold py-2 px-4 rounded"
        type="button"
        @click="reflectSukki"
      >
        すきを反映する
      </button>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios"

export default {
  components: {
  },
  computed: {
    user () {
      return this.$store.state.user
    },
    skickers() {
      return this.$store.state.skickers
    }
  },
  methods : {
    loginTwitter() {
      this.$store.dispatch('loginTwitter')
    },
    toSkicker() {
      this.$router.push("/");
    },
    toMypage() {
      this.$router.push("/mypage");
    },
    toLogin() {
      this.$router.push("/login");
    },
    selectSukipi(skicker) {
      console.log(skicker)
      this.$store.commit('setSukipi', {
        name: skicker.name,
        skicker_id: skicker.id,
        suki: this.$store.state.sukkis[0].suki
      })
      console.log('sukipi set')
    },
    async reflectSukki() {
      const sukkis_data = await axios.get(`/sukkis?uid=${this.user.uid}`)
      console.log('set sukkis data', sukkis_data.data.value)
      this.$store.commit('setSukkis', sukkis_data.data.value)
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
  margin-top: 40px;
  font-size: 24px;
}
</style>