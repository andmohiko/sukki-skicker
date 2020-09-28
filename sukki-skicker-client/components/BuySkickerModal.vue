<template>
  <div class="buy-skicker">
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <h2>だれのすきを使って買いますか？</h2>
      <p>{{ skicker.id }}, {{ skicker.name }}, {{ skicker.power }}, {{ skicker.cost }}</p>
      <div class="sukipis">
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
              @click="selectSukipiAndBuy(sukipi)"
            >
              この人のすきを消費する
            </button>
          </li>
        </ul>
      </div>
    </div>  
  </div>
</template>

<script>
import axios from "@/plugins/axios"
export default {
  props: {
    skicker: {
      required: true
    }
  },

  data() {
    return {
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
  methods: {
    async selectSukipiAndBuy(sukipi) {
      console.log(this.skicker.cost)
      console.log(sukipi.suki)
      console.log(sukipi.id)
      if (this.skicker.cost > sukipi.suki) return
      try {
        const buyingSkicker = {
          user_id: this.user.user_id,
          skicker_id: this.skicker.id
        }
        console.log(buyingSkicker)
        const boughtSkicker = await axios.post("/skicker_users", buyingSkicker)
        console.log('boughtSkicker', boughtSkicker)
        const updatedSukipi = await axios.put(`/sukipis/${sukipi.id}`, {
          suki: sukipi.suki - this.skicker.cost
        })
        console.log('minus sukis', updatedSukipi)
        const users_skickers_data = await axios.get(`skicker_users?uid=${this.user.uid}`)
        commit('setUserSkickers', users_skickers_data.data.value)
        this.$store.commit('setCurrentSkicker', {
          name: this.skicker.name,
          power: this.skicker.power
        })
      } catch {
        console.log('error in buying')
      }
    }
  }
}
</script>

<style lang="scss">
.buy-skicker {
  border: yellow;
}
h2 {
  font-size: 24px;
  margin: 16px
}
</style>
