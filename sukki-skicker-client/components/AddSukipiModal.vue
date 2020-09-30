<template>
  <div class="modal-bg">
    <div class="add-sukipi-modal bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
      <div class="close" @click="onClose">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M6 18L18 6M6 6L18 18" stroke="#4A5568" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </div>
      <form>
        <div class="mb-4">
          <label class="block text-gray-700 text-sm font-bold mb-2" for="username">
            すきを送りたい人の名前
          </label>
          <input
            v-model="newSukipi"
            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
            type="text"
            placeholder="かれぴっぴ">
        </div>
        <div class="flex items-center justify-center">
          <Button
            :label-name="'追加'"
            :width="'100px'"
            @onClick="addSukipi"
          />
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios"
import Button from "@/components/Button.vue";

export default {
  components: {
    Button
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
  methods: {
    setSukipi(sukipi) {
      this.$store.commit('setCurrentSukipi', {
        name: sukipi.name,
        suki: sukipi.suki,
        sukipi_id: sukipi.id
      })
      this.$emit('resetSuki')
    },
    async addSukipi() {
      const new_sukipi = {
        name: this.newSukipi,
        user_id: this.user.user_id,
        suki: 0
      }
      try {
        const created_sukipi = await axios.post("/sukipis", new_sukipi)
        console.log('new sukipi created', created_sukipi.data.data)
        const sukipis_data = await axios.get(`/sukipis?uid=${this.user.uid}`)
        this.$store.commit('setSukipis', sukipis_data.data.value)
        console.log(this.sukipis)
        this.setSukipi({
          name: created_sukipi.data.data.name,
          suki: created_sukipi.data.data.suki,
          id: created_sukipi.data.data.id,
        })
        this.onClose()
      } catch {
        console.log('error adding sukipi')
      }
    },
    onClose() {
      this.$emit('close')
    }
  }
}
</script>

<style lang="scss">
.sukipis-add {
  border: yellow;
}
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
.add-sukipi-modal {
  position: relative;
}
.close {
  position: absolute;
  right: 0;
  top: 0;
}
</style>
