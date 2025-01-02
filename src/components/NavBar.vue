<template>
  <nav class="navbar">
    <button>登入</button>
    <button class="tomato">番茄</button>
  </nav>
</template>

<script setup></script>

<style lang="scss" scoped>
.navbar {
  width: 100%;
  padding-top: 20px;
  height: 50px;

  button {
    float: right;
    margin: 0 15px;
    border: none;
    background-color: transparent;
    font-size: 1.1rem;
    &:hover {
    }
  }

  .tomato {
    color: tomato;
  }
}
</style>
