<script setup>
import { RouterLink, RouterView } from "vue-router";
import NavBar from "./components/NavBar.vue";
import Footer from "./components/MainFooter.vue";
</script>

<template>
  <NavBar />
  <RouterView />
  <Footer />
</template>

<style lang="scss" scoped></style>
