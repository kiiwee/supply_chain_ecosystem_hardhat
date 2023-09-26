<script setup>
import HelloWorld from './components/HelloWorld.vue'
import TheWelcome from './components/TheWelcome.vue'
</script>

<!-- <template>
  <header>
    <img alt="Vue logo" class="logo" src="./assets/logo.svg" width="125" height="125" />

    <div class="wrapper">
      <HelloWorld msg="You did it!" />
    </div>
  </header>

  <main>
    <TheWelcome />
  </main>
</template> -->

<template>
  <div class="centered-box">
    <div class="box">
      <!-- The box content goes here -->
    </div>
    <div class="box-title">
      <p>Item</p>
    </div>
  </div>
</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  .centered-box {
  display: flex;
  flex-direction: column; /* Stack elements vertically */
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  width: 200%;
}

.box {
  width: 400px;
  height: 400px;
  background-color: #3498db;
  border-radius: 10px;
  text-align: center;
  padding: 20px;
  color: white;
  font-size: 24px;
  margin-bottom: 20px; /* Add some spacing between the box and title */
}

.box-title {
  text-align: center; /* Center the text */
  font-size: 20px; /* You can adjust the font size as needed */
}
}
</style>
