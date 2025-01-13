<template>
  <footer class="mt-5">
    <hr />
    <p>
      © Luna
      {{ year }} 製作
    </p>
  </footer>
</template>
<style lang="scss" scoped></style>
<script setup>
import { ref } from "vue";

const year = ref(new Date().getFullYear());
</script>
