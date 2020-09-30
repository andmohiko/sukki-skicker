<template>
  <button
    v-if="isDisabled"
    class="bg-blue-500 text-white font-bold py-2 px-4 rounded opacity-50 cursor-not-allowed"
    type="button"
    :style="[widthStyle]"
    @click="$emit('onClick')"
  >
    {{ labelName }}
  </button>

  <button
    v-else
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
      default: 'ボタン',
      required: true
    },
    width: {
      default: '100%',
    },
    isDisabled: {
      default: false
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
