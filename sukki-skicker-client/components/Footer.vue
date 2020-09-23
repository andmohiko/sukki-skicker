<template>
  <div class="footer-container">
    <div class="copyright">
      <p>
        <small>© 2020 @andmohiko</small>
      </p>
    </div>
  </div>
</template>

<style scoped lang="scss">
.footer-container {
  height: 80px;
  background-color: #111;
  display: flex;
  padding: 33px;
  justify-content: space-between;
}

.copyright {
  display: flex;
  justify-content: right;
  align-items: center;

  p {
    line-height: 80px;
    color: #ccc;
    font-size: 12px;
  }
}
</style>