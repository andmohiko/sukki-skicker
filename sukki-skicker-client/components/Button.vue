<template>
  <button
    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    type="button"
    :style="[widthStyle]"
    @click="$emit('onClick')"
  >
    {{ labelName }}
  </button>
</template>

<script>

export default {
  props: {
    labelName: {
      type: String,
      default: 'ボタン',
      required: true
    },
    width: {
      default: '100%',
      type: String
    }
  },

  data() {
    return {
      widthStyle: {
        width: this.width
      }
    }
  }
}
</script>

<style lang="scss">
</style>
