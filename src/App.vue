<template>
  <div class="container py-4">
    <component
      :is="currentScreen"
      :images="images"
      @start="startGame"
      @gameOver="showResults"
      @restart="restartGame"
      :results="gameResults"
    />
  </div>
</template>

<script>
import StartScreen from "./components/StartScreen.vue";
import GameScreen from "./components/GameScreen.vue";
import ResultScreen from "./components/ResultScreen.vue";

export default {
  components: {
    StartScreen,
    GameScreen,
    ResultScreen,
  },
  data() {
    return {
      screen: "StartScreen",
      images: [],
      gameResults: [],
    };
  },
  computed: {
    currentScreen() {
      if (this.screen === "StartScreen") return "StartScreen";
      if (this.screen === "GameScreen") return "GameScreen";
      if (this.screen === "ResultScreen") return "ResultScreen";
      return "StartScreen";
    },
  },
  created() {
    // Dynamic import of images using Vite import.meta.globEager
    const imagesContext = require.context("./assets/images", false, /\.jpg$/);

    this.images = imagesContext.keys().map((key) => {
      const fileName = key.replace("./", "");
      return {
        name: fileName.replace(".jpg", ""),
        src: imagesContext(key),
      };
    });
    // const imagesContext = import.meta.globEager("./assets/images/*.jpg");
    // this.images = Object.entries(imagesContext).map(([path, module]) => {
    //   const filename = path.split("/").pop();
    //   return {
    //     src: module.default,
    //     name: filename.replace(".jpg", ""),
    //   };
    // });

    console.log(this.images);
  },
  methods: {
    startGame() {
      this.gameResults = [];
      this.screen = "GameScreen";
    },
    showResults(results) {
      this.gameResults = results;
      this.screen = "ResultScreen";
    },
    restartGame() {
      this.screen = "StartScreen";
    },
  },
};
</script>

<style>
.container {
  height: 100vh;
}
</style>
