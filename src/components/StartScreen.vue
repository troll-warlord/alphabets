<template>
  <div
    class="d-flex flex-column align-items-center justify-content-center"
    style="height: 70vh"
  >
    <h1 class="mb-4">Alphabet Image Game</h1>
    <button class="btn btn-primary btn-lg" @click="$emit('start')">
      Start
    </button>
  </div>
</template>

<script>
export default {
  name: "StartScreen",
};
</script>
