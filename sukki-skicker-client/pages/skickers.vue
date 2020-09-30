<template>
  <div class="skickers">
    <template v-if="isShowBuySkickerModal">
      <BuySkickerModal :skicker="buyingSkicker" @close="closeModal" />
    </template>
    <h1 class="title">すきっかーで火力をあげよう</h1>
    <div class="skickers-own flex flex-col items-center justify-center">
      <h2>セットされているすきっかー</h2>
      <p>名前: {{ currentSkicker.name }}</p>
      <p>火力: {{ currentSkicker.power }}</p>
    </div>
    <div class="skickers-own flex flex-col items-center justify-center">
      <h2>すでに持っているすきっかー</h2>
      <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
        <table class="table-fixed">
          <thead>
            <tr>
              <th class="w-1/2 px-4 py-2">すきっかー</th>
              <th class="w-1/4 px-4 py-2">火力</th>
              <th class="w-1/4 px-4 py-2">セットする</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="skicker in user_skickers"
              :key="skicker.id"
            >
              <td class="border px-4 py-2">{{ skicker.name }}</td>
              <td class="border px-4 py-2">{{ skicker.power }}</td>
              <td class="border px-4 py-2">
                <Button label-name="セット" :width="'100px'" @onClick="setSkicker(skicker)" />
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="skickers-all flex flex-col items-center justify-center">
      <h2>購入できるすきっかー一覧</h2>
      <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
        <table class="table-fixed">
          <thead>
            <tr>
              <th class="w-1/2 px-4 py-2">id</th>
              <th class="w-1/2 px-4 py-2">すきっかー</th>
              <th class="w-1/4 px-4 py-2">火力</th>
              <th class="w-1/4 px-4 py-2">コスト</th>
              <th class="w-1/4 px-4 py-2">購入</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="skicker in allSkickers"
              :key="skicker.id"
            >
              <td class="border px-4 py-2">{{ skicker.id }}</td>
              <td class="border px-4 py-2">{{ skicker.name }}</td>
              <td class="border px-4 py-2">{{ skicker.power }}</td>
              <td class="border px-4 py-2">{{ skicker.cost }}</td>
              <td class="border px-4 py-2">
                <Button v-if="isAlreadyOwn(skicker)" :label-name="'購入'" :width="'100px'" :is-disabled="true" />
                <Button v-else :label-name="'購入'" :width="'100px'" @onClick="buySkicker(skicker)" />
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios"
import Button from "@/components/Button.vue";
import BuySkickerModal from "@/components/BuySkickerModal.vue";

export default {
  middleware: 'authLogin',
  components: {
    Button,
    BuySkickerModal
  },
  async asyncData({ store }) {
    const sukipis_data = await axios.get(`/sukipis?uid=${store.state.user.uid}`)
    store.commit('setSukipis', sukipis_data.data.value)
    const all_skickers_data = await axios.get(`/skickers`)
    return {
      allSkickers: all_skickers_data.data.value
    }
  },
  data() {
    return {
      allSkickers: [],
      usersSkickers: [],
      buyingSkicker: {},
      isShowBuySkickerModal: false
    }
  },
  computed: {
    user() {
      return this.$store.state.user
    },
    user_skickers() {
      return this.$store.state.user_skickers
    },
    currentSkicker() {
      return this.$store.state.currentSkicker
    },
    user_skickers_id() {
      return this.user_skickers.map(skicker => skicker.id)
    }
  },
  methods: {
    show() {
      console.log(this.$store.state.user_skickers)
      console.log(this.user)
    },
    setSkicker(skicker) {
      this.$store.commit('setCurrentSkicker', {
        name: skicker.name,
        power: skicker.power
      })
    },
    buySkicker(skicker) {
      this.buyingSkicker = skicker
      this.isShowBuySkickerModal = true
    },
    closeModal() {
      this.isShowBuySkickerModal = false
    },
    isAlreadyOwn(skicker) {
      return this.user_skickers_id.includes(skicker.id)
    }
  }
}
</script>

<style scoped lang="scss">
.skickers {
  margin-top: 70px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}
h1 {
  font-size: 30px;
  margin: 30px
}
h2 {
  font-size: 24px;
  margin: 16px
}
</style>