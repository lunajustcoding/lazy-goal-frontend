<template>
  <header>
    <h1>lazy</h1>
  </header>
  <main>
    <div class="list h-auto p-5">
      <div class="titleBox box">
        <p class="text-center text-base font-bold">📋我的待辦事項</p>
      </div>
      <div class="inputBox text-center m-3 flex item-center justify-center">
        <input
          type="text"
          placeholder="請輸入新的事項"
          class="text-base outline-none"
          v-model="inputRef"
        />
        <button class="ml-3 border-none bg-transparent cursor-pointer" @click="addItem">
          <el-icon><Plus /></el-icon>
        </button>
      </div>
      <div class="todoBox justify-center flex flex-col items-left m-3">
        <label
          class="check-box flex items-left justify-between"
          v-for="item in list"
          :key="item.id"
        >
          <div class="text-box">
            <input type="checkBox" :value="item.checked" />
            <span class="ml-1">{{ item.content }}</span>
          </div>
          <button
            class="border-none bg-transparent color-red font-medium cursor-pointer"
            @click="deleteItem(item.id)"
          >
            <el-icon><Close /></el-icon>
          </button>
        </label>
        <label class="check-box flex items-center justify-between">
          <div class="text-box">
            <input type="checkBox" value="" /><span class="ml-1"
              >買奇異果給家裡的狗吃</span
            >
          </div>
          <button class="border-none bg-transparent color-red font-medium cursor-pointer">
            <el-icon><Close /></el-icon>
          </button>
        </label>
      </div>
      <hr />
      <div class="tomatoBox box m-3">
        <p class="text-base font-bold">🍅專注模式</p>
        <p class="text-3xl m-3 font-bold">⏳{{ fomatTimer }}</p>
        <div class="playBox w-50 flex items-center justify-around">
          <button @click="startTimer" :disabled="isRunning">▶️開始</button>
          <button @click="pauseTimer" :disabled="!isRunning">⏸️暫停</button>
          <button @click="resetTimer">🔁重置</button>
        </div>
      </div>
      <hr />
      <div class="totalBox box m-3">
        <p>番茄數量: 3</p>
        <button
          class="border-none bg-transparent cursor-pointer color-gray-400"
          @click="doneShow"
        >
          [ {{ doneShowRef.text }}已完成事項 ]
        </button>
        <div
          class="doneList w-80 h-auto max-h-90px overflow-auto border flex flex-col items-center"
          v-if="doneShowRef.switch"
        >
          <p>✔️睡午覺( 1 🍅)</p>
          <p>✔️去洗碗( 2 🍅)</p>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
import { computed, ref, onUnmounted } from "vue";

// 初始化
const list = ref([]);
const doneShowRef = ref({
  text: "顯示",
  switch: false,
});
const inputRef = ref("");

const totalSecRef = ref(1 * 60);
const isRunning = ref(false);

let timer = null;

const fomatTimer = computed(() => {
  const m = Math.floor(totalSecRef.value / 60);
  const s = totalSecRef.value % 60;
  return `${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
});

const startTimer = () => {
  if (!isRunning.value) {
    isRunning.value = true;
    timer = setInterval(() => {
      if (totalSecRef.value > 0) {
        totalSecRef.value--;
      } else {
        resetTimer();
      }
    }, 1000);
  }
};

const resetTimer = () => {
  pauseTimer();
  totalSecRef.value = 25 * 60;
};

const stopTimer = () => {
  clearInterval(timer);
  isRunning.value = false;
};

const pauseTimer = () => {
  isRunning.value = false;
  clearInterval(timer);
};

onUnmounted(() => {
  stopTimer();
});

const addItem = () => {
  if (inputRef.value == "") {
    console.log("請輸入事項");
    return;
  }
  list.value.push({
    content: inputRef.value,
    id: new Date().getTime(),
    checked: false,
  });
  localStorage.setItem("TodoList", "Tom");
  inputRef.value = "";
};

const deleteItem = (id) => {
  const item = list.value.findIndex((i) => i.id == id);
  if (item !== -1) {
    list.value.splice(item, 1);
  }
};

const doneShow = () => {
  doneShowRef.value.switch = !doneShowRef.value.switch;
  doneShowRef.value.text == "顯示"
    ? (doneShowRef.value.text = "隱藏")
    : (doneShowRef.value.text = "顯示");
};
</script>

<style lang="scss">
header {
  h1 {
    font-size: 3rem;
    text-align: center;
    font-weight: 600;
  }
}
main {
  padding: 20px 0;
  width: 100%;

  .list {
    margin: 0 auto;
    width: 350px;
    background-color: #fff;
    box-shadow: 5px 8px 10px rgb(0, 0, 0, 0.4);

    .todoBox {
      .check-box {
        .text-box {
          padding-left: 0px;

          span {
            padding-left: 23px;
            position: relative;
            cursor: pointer;
            font-size: 1rem;

            &::before {
              content: "";
              left: 0;
              top: 2px;
              position: absolute;
              outline: 1px solid #333333;
              border-radius: 5px;
              width: 16px;
              height: 16px;
            }

            &::after {
              display: none; //預設為不可視狀態
              content: "";
              left: 5px;
              top: 2px;
              position: absolute;
              width: 7px;
              height: 14px;
              border-right: 2px solid #f39800;
              border-bottom: 2px solid #f39800;
              transform: rotate(40deg);
            }
          }

          input[type="checkbox"] {
            display: none;
          }
          input[type="checkbox"]:checked + span {
            text-decoration: line-through;
            color: rgba(51, 51, 51, 0.3);
          }
          input[type="checkbox"]:checked + span::before {
            display: none; //點擊後將框框設為不可視
          }
          input[type="checkbox"]:checked + span::after {
            display: block; //點擊後將勾勾設為可視
          }
        }
      }
    }
  }

  .box {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  // .btn {
  //   font-size: 1.3rem;
  //   cursor: pointer;
  // }
  // .listBox {
  //   display: grid;
  //   grid-template-columns: 1fr 1fr 1fr 1fr;
  //   .list {
  //     max-width: 300px;
  //     border-radius: 15px;
  //     background-color: #ffffff;
  //     margin: 15px;
  //     color: #1b1b1b;
  //     height: auto;
  //     padding: 10px 0;
  //     display: flex;
  //     flex-direction: column;
  //     .top {
  //       display: grid;
  //       align-items: center;
  //       padding: 0 15px;
  //       grid-template-columns: 3fr 0.5fr;
  //       .goal-title {
  //         text-align: center;
  //         font-size: 1.3rem;
  //         font-weight: 600;
  //         color: #2c3e50;
  //         display: flex;
  //         flex-direction: column;
  //         align-items: flex-start;
  //       }
  //       span {
  //         font-size: 0.9rem;
  //       }
  //       .btn-box {
  //         display: flex;
  //         justify-content: right;
  //         align-items: center;
  //         button {
  //           margin: 0;
  //           padding: 0;

  //           background-color: transparent;
  //           border: none;
  //           cursor: pointer;
  //         }
  //       }
  //     }

  //     .set-time {
  //       float: right;
  //       padding-right: 23px;
  //     }

  //     .reset-time {
  //       margin: 5px 0;
  //       text-align: center;
  //       color: #2c3e50;
  //     }

  //     .check-box {
  //       padding-left: 20px;
  //     }

  //     .check-box span {
  //       padding-left: 23px;
  //       position: relative;
  //       cursor: pointer;
  //       font-size: 1rem;

  //       &::before {
  //         content: "";
  //         left: 0;
  //         top: 2px;
  //         position: absolute;
  //         outline: 1px solid #333333;
  //         border-radius: 5px;
  //         width: 16px;
  //         height: 16px;
  //       }

  //       &::after {
  //         display: none; //預設為不可視狀態
  //         content: "";
  //         left: 5px;
  //         top: 2px;
  //         position: absolute;
  //         width: 7px;
  //         height: 14px;
  //         border-right: 2px solid #f39800;
  //         border-bottom: 2px solid #f39800;
  //         transform: rotate(40deg);
  //       }
  //     }

  //     input[type="checkbox"] {
  //       display: none;
  //     }
  //     input[type="checkbox"]:checked + span {
  //       text-decoration: line-through;
  //       color: rgba(51, 51, 51, 0.3);
  //     }
  //     input[type="checkbox"]:checked + span::before {
  //       display: none; //點擊後將框框設為不可視
  //     }
  //     input[type="checkbox"]:checked + span::after {
  //       display: block; //點擊後將勾勾設為可視
  //     }
  //   }
  // }
}
</style>
