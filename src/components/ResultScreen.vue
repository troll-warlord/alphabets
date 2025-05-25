<template>
  <div class="text-center">
    <h2>Your Score: {{ score }} / {{ total }}</h2>
    <div class="row mt-4" style="max-height: 80vh; overflow-y: auto">
      <div v-for="(entry, idx) in results" :key="idx" class="col-md-2 mb-3">
        <div
          class="card"
          :class="entry.correct ? 'border-success' : 'border-danger'"
        >
          <img
            :src="entry.image.src"
            class="card-img-top"
            :alt="entry.image.name"
          />
          <div class="card-body">
            <h5 class="card-title text-capitalize">{{ entry.image.name }}</h5>
            <p>
              Selected: <strong>{{ entry.selected.toUpperCase() }}</strong
              ><br />
              <span v-if="entry.correct" class="text-success">Correct</span>
              <span v-else class="text-danger">Wrong</span>
            </p>
          </div>
        </div>
      </div>
    </div>
    <button class="btn btn-primary mt-4" @click="$emit('restart')">
      Play Again
    </button>
  </div>
</template>

<script>
export default {
  name: "ResultScreen",
  props: {
    results: {
      type: Array,
      required: true,
    },
  },
  computed: {
    total() {
      return this.results.length;
    },
    score() {
      return this.results.filter((r) => r.correct).length;
    },
  },
};
</script>

<style scoped>
.card {
  min-height: 100px;
  min-width: 100px;
}
.card img {
  height: 50px;
  object-fit: contain;
}
</style>
