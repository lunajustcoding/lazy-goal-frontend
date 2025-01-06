<template>
  <hr />
  <p>
    © Luna
    {{ year }} 製作
  </p>
</template>
<style lang="scss" scoped></style>
<script setup>
import { ref } from "vue";

const year = ref(new Date().getFullYear());
</script>
