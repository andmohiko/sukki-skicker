<template>
  <header class="header-container">
    <nav>
      <ul v-if="user.login">
        <li>
          {{ user.username.slice(0, 3) }}
        </li>
        <li>
          <nuxt-link to="/">すきを送る</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/skickers">火力</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/mypage">マイページ</nuxt-link>
        </li>
        <li>
          <nuxt-link to="/mypage"><img :src="user.profileIcon" alt="ic"></nuxt-link>
        </li>
      </ul>
      <ul v-else>
        <li>
          <nuxt-link to="/login">ログイン</nuxt-link>
        </li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {
  computed: {
    user () {
      return this.$store.state.user
    },
  }
}
</script>

<style scoped lang="scss">
.header-container {
  position: fixed;
  top: 0;
  right: 0;
  left: 0;
  background-color: white;
  width: 100vw;
  height: 70px;
  line-height: 70px;
  padding: 0px 5%;
  border-bottom-style: solid; 
  border-bottom-width: 0.5px;
  ul {
    display: flex;
    justify-content: space-between;
  }
  li {
    // margin-left: 90px;
    list-style-type: none;
  }
  a {
    // color: $gray;
    font-weight: bold;
    text-decoration: none;
    font-size: 16px;
    letter-spacing: 2px;
  }
  a:hover {
    opacity: 0.7;
  }
  img {
    width: 50px;
    height: 50px;
    margin-top: 15px;
  }
}
</style>
