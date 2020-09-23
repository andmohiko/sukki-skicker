<template>
  <div class="login">
    <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col">
      <div class="flex items-center justify-between">
        <button
          class="bg-blue hover:bg-blue-dark text-black font-bold py-2 px-4 rounded"
          type="button"
          @click="loginTwitter"
        >
          Twitterでログイン
        </button>
      </div>
      <p v-if="user.login" class="text">ログイン済み</p>
    </div>
  </div>
</template>

<script>
export default {
  computed: {
    user () {
      return this.$store.state.user
    },
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
    }
  }
}
</script>

<style scoped lang="scss">
.login {
  margin-top: 100px;
}
</style>