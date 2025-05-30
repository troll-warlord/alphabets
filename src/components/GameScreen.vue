<template>
  <div class="row">
    <!-- Left panel: list of shown images with results -->
    <div
      class="col-md-4 order-2 order-md-1 border-end answer"
      style="max-height: 100vh; overflow-y: auto"
    >
      <h5>Progress</h5>

      <ul class="list-group">
        <li
          v-for="(entry, idx) in answers"
          :key="idx"
          class="list-group-item d-flex align-items-center"
        >
          <img
            :src="entry.image.src"
            :alt="entry.image.name"
            width="40"
            class="me-2 rounded"
          />
          <div class="flex-grow-1">
            <div>{{ entry.image.name }}</div>
            <small>Selected: {{ entry.selected.toUpperCase() }}</small>
          </div>
          <div>
            <i
              v-if="entry.correct"
              class="bi bi-check-circle-fill text-success fs-4"
            ></i>
            <i v-else class="bi bi-x-circle-fill text-danger fs-4"></i>
          </div>
        </li>
      </ul>
      <button
        class="btn btn-danger mt-3 restart"
        v-if="this.answers.length > 0"
        @click="resetGame"
      >
        Restart
      </button>
      <button
        class="btn btn-primary mt-3 show-score"
        v-if="this.answers.length > 0"
        @click="showScore"
      >
        Show Score
      </button>
    </div>

    <!-- Right panel: current image and alphabet buttons -->
    <div
      class="col-md-8 order-1 order-md-2 d-flex flex-column align-items-center justify-content-center"
    >
      <div class="mb-4">
        <img
          :src="currentImage.src"
          :alt="currentImage.name"
          class="img-fluid rounded border image-fixed"
          :class="{
            'border-success': feedback === 'correct',
            'border-danger': feedback === 'wrong',
            'animate__animated animate__pulse': feedback !== null,
          }"
        />
      </div>

      <form @submit.prevent="submitAnswer">
        <div class="d-flex align-items-center">
          <input
            ref="answerInput"
            v-model="userAnswer"
            maxlength="1"
            class="form-control d-inline-block text-center input-highlight"
            @input="handleInput"
          />
          <div v-if="userAnswer" class="ms-2">
            <i
              v-if="feedback == 'correct'"
              class="bi bi-check-circle-fill text-success fs-1"
            ></i>
            <i v-else class="bi bi-x-circle-fill text-danger fs-1"></i>
          </div>
        </div>
      </form>

      <!-- <div class="d-flex flex-wrap justify-content-center gap-2">
        <button
          v-for="letter in letters"
          :key="letter"
          class="btn btn-outline-primary"
          @click="selectLetter(letter)"
          :disabled="feedback !== null"
        >
          {{ letter }}
        </button>
      </div> -->
    </div>
  </div>
</template>

<script>
export default {
  name: "GameScreen",
  props: {
    images: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      shuffledImages: [],
      currentIndex: 0,
      answers: [],
      userAnswer: "",
      feedback: null,
      letters: "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(""),
    };
  },
  computed: {
    currentImage() {
      return this.shuffledImages[this.currentIndex] || {};
    },
  },
  mounted() {
    this.$refs.answerInput.focus();
  },
  created() {
    this.initGame();
    this.focusInput();
  },
  methods: {
    handleInput(event) {
      const letter = event.target.value.toUpperCase().slice(0, 1);
      this.userAnswer = letter;
      this.selectLetter(letter);
    },
    shuffle(array) {
      return array
        .map((value) => ({ value, sort: Math.random() }))
        .sort((a, b) => a.sort - b.sort)
        .map(({ value }) => value);
    },
    initGame() {
      this.shuffledImages = this.shuffle(this.images);
      this.currentIndex = 0;
      this.answers = [];
      this.feedback = null;
    },
    showScore() {
      this.$emit("gameOver", this.answers);
    },
    focusInput() {
      this.$nextTick(() => {
        this.$refs.answerInput?.focus();
      });
    },
    selectLetter(letter) {
      if (this.feedback !== null) return;

      const firstLetter = this.currentImage.name.trim()[0].toUpperCase();
      const isCorrect = letter === firstLetter;

      this.answers.push({
        image: this.currentImage,
        selected: letter,
        correct: isCorrect,
      });

      this.feedback = isCorrect ? "correct" : "wrong";

      setTimeout(() => {
        this.feedback = null;
        this.currentIndex++;
        this.userAnswer = ""; // ⬅️ Clear the input field
        this.focusInput();

        if (this.currentIndex >= this.shuffledImages.length) {
          this.$emit("gameOver", this.answers);
        }
      }, 1000);
    },
    resetGame() {
      this.initGame();
      this.$emit("restart");
    },
  },
};
</script>

<style scoped>
@import "https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css";
@import "https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css";

img {
  transition: border-color 0.5s ease;
}

.row {
  height: 100%;
}
.answer {
  height: 100%;
}
.progress-header {
  display: inline;
  align-items: center;
  width: 100%;
  height: 30px;
}
.restart {
  margin-right: 0;
}
.image-fixed {
  width: 350px; /* or 100% in a container */
  height: 350px;
}
.show-score {
  float: right;
}
form {
  width: 50px;
}
.input-highlight {
  width: 60px;
  height: 60px;
  font-size: 2rem;
  padding: 0;
  border: 2px solid #007bff;
  border-radius: 8px;
}
.input-highlight:focus {
  border: 2px solid #007bff;
  box-shadow: 0 0 8px #007bff;
  outline: none;
}
</style>
