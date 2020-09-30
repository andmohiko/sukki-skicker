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
      <Button :label-name="'Twitterでログインし直す'" @onClick="loginTwitter" />
    </div>
    <div class="sukipis">
      <h2 class="title">選択中のすきぴ</h2>
      <p>{{ currentSukipi.name }}, {{ currentSukipi.suki }}</p>
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
            @click="setSukipi(sukipi)"
          >
            この人にすきを送る
          </button>
        </li>
      </ul>
      <div class="sukipis-add">
        <Button :label-name="'すきを送りたい人を追加する'" :width="'250px'" @onClick="openModal" />
      </div>
      <template v-if="isShowAddSukipiModal">
        <AddSukipiModal @resetSuki="resetSuki" @close="closeModal" />
      </template>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios"
import Button from "@/components/Button.vue";
import AddSukipiModal from "@/components/AddSukipiModal.vue";

export default {
  middleware: 'authLogin',
  components: {
    Button,
    AddSukipiModal
  },
  async asyncData({ store }) {
    const sukipis_data = await axios.get(`/sukipis?uid=${store.state.user.uid}`)
    store.commit('setSukipis', sukipis_data.data.value)
  },
  data() {
    return {
      isShowAddSukipiModal: false
    }
  },
  computed: {
    user() {
      return this.$store.state.user
    },
    sukipis() {
      return this.$store.state.sukipis
    },
    currentSukipi() {
      return this.$store.state.currentSukipi
    }
  },
  methods: {
    setSukipi(sukipi) {
      this.$store.commit('setCurrentSukipi', {
        name: sukipi.name,
        suki: sukipi.suki,
        sukipi_id: sukipi.id
      })
    },
    loginTwitter() {
      this.$store.dispatch('loginTwitter')
    },
    openModal() {
      this.isShowAddSukipiModal = true
    },
    closeModal() {
      this.isShowAddSukipiModal = false
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
  margin: 100px 0;
}
img {
  width: 100px;
  height: auto;
}
.title {
  font-size: 24px;
  margin-top: 40px;
}
.sukipi-name {
  margin: 20px;
}
</style>
