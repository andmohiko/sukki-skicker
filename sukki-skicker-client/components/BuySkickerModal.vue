<template>
  <div class="modal-bg">
    <div class="buy-skicker bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <div class="close" @click="onClose">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M6 18L18 6M6 6L18 18" stroke="#4A5568" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </div>
      <h2>だれのすきを使って買いますか？</h2>
      <p class="notice">{{ flashMessage }}</p>
      <p>{{ skicker.id }} {{ skicker.name }} {{ skicker.power }} {{ skicker.cost }}</p>
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
      flashMessage: ''
    }
  },
  computed: {
    user() {
      return this.$store.state.user
    },
    sukipis() {
      return this.$store.state.sukipis
    },
    user_skickers() {
      return this.$store.state.user_skickers
    }
  },
  methods: {
    async selectSukipiAndBuy(sukipi) {
      if (this.skicker.cost > sukipi.suki) {
        this.flashMessage = 'すきが足りません。もっとタップしてください'
        return
      }
      try {
        const buyingSkicker = {
          user_id: this.user.user_id,
          skicker_id: this.skicker.id
        }
        const boughtSkicker = await axios.post("/skicker_users", buyingSkicker)
        const updatedSukipi = await axios.put(`/sukipis/${sukipi.id}`, {
          suki: sukipi.suki - this.skicker.cost
        })
        const users_skickers_data = await axios.get(`skicker_users?uid=${this.user.uid}`)
        this.$store.commit('setUserSkickers', users_skickers_data.data.value)
        this.$store.commit('setCurrentSkicker', {
          name: this.skicker.name,
          power: this.skicker.power
        })
      } catch {
        console.log('error in buying')
      }
      this.onClose()
    },
    onClose() {
      this.$emit('close')
    }
  }
}
</script>

<style lang="scss">
h2 {
  font-size: 24px;
  margin: 16px
}
.modal-bg {
  position: fixed;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  width: 100%;
  top: 0;
  left: 0;
  background: rgba(21, 28, 56, 0.568);
  z-index: z(UpperMiddle);
}
.buy-skicker {
  position: relative;
}
.close {
  position: absolute;
  right: 0;
  top: 0;
}
.notice {
  color: red;
  font-size: 16px;
}
</style>
