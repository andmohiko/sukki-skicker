<template>
  <div class="container">
    <template v-if="isShowAddSukipiModal">
      <AddSukipiModal @resetSuki="resetSuki" @close="closeModal" />
    </template>
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
    <div style="margin: 0;">
      <a
        href="https://twitter.com/share?ref_src=twsrc%5Etfw"
        class="twitter-share-button"
        data-size="large"
        :data-url="originalReferer"
        :data-text="twitterShareText"
        data-show-count="false"
        >Tweet</a
      >
      <script
        async
        src="https://platform.twitter.com/widgets.js"
        charset="utf-8"
      ></script>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import axios from '@/plugins/axios'
import AddSukipiModal from "@/components/AddSukipiModal.vue";

const makeShareText = (
  suki, sukipi
) => `${sukipi.name} に ${suki} すき送ったよ`

export default Vue.extend({
  middleware: 'authLogin',
  components: {
    AddSukipiModal
  },
  data() {
    return {
      suki: 0,
      isShowAddSukipiModal: false
    }
  },
  mounted() {
    this.suki = this.$store.state.currentSukipi.suki
    if (this.$store.state.sukipis.length === 0) {
      this.isShowAddSukipiModal = true
    }
  },
  computed: {
    user() {
      return this.$store.state.user
    },
    sukipi() {
      return this.$store.state.currentSukipi
    },
    sukipis() {
      return this.$store.state.sukipis
    },
    currentSkicker() {
      return this.$store.state.currentSkicker
    },
    twitterShareText() {
      return makeShareText(this.suki, this.sukipi)
    // },
    // isShowAddSukipiModal() {
    //   return this.sukipis.length === 0
    }
  },
  methods : {
    skick() {
      this.suki = this.suki + this.currentSkicker.power
      axios.put(`/sukipis/${this.sukipi.sukipi_id}`, {
        suki: this.suki
      })
      this.$store.commit('setCurrentSukipi', {
        name: this.sukipi.name,
        suki: this.suki,
        sukipi_id: this.sukipi.sukipi_id
      })
    },
    async reflectSukipi() {
      const sukipis_data = await axios.get(`/sukipis?uid=${this.user.uid}`)
      this.$store.commit('setSukipis', sukipis_data.data.value)
    },
    resetSuki() {
      this.suki = 0
    },
    closeModal() {
      this.isShowAddSukipiModal = false
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