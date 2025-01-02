<template>
  <main>
    <h1>懶人計畫</h1>
    <button class="add-btn" @click="openAdd">+</button>
    <div class="listBox">
      <div class="list">
        <b>健身 <span>總時間:兩小時</span></b>
        <div class="line"></div>
        <label class="check-box">
          <input type="checkbox" />
          <span>把冰箱發霉的檸檬拿去丟</span>
        </label>
      </div>
      <div class="list">2</div>
      <div class="list">3</div>
      <div class="list">4</div>
      <div class="list">5</div>
    </div>
  </main>

  <div class="add-popup" v-if="addPopupRef">
    <div class="add-bg">
      <button class="close-btn" @click="addPopupRef = false">X</button>
      <from class="add-from">
        <input type="text" placeholder="輸入你的目標" />
        <div class="line"></div>
        <div class="itemBox" v-for="item in items" :key="item.id">
          <input v-model="item.content" type="text" placeholder="輸入你的短期目標" />
          <input v-model="item.reset" type="text" placeholder="輸入你的短期目標" />
        </div>

        <button class="" @click="addItem">新增項目</button>
        <button class="" @click="addRest">新增休息</button>
      </from>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

// 彈窗
const addPopupRef = ref(false);

const openAdd = () => {
  addPopupRef.value = true;
};

const items = ref([
  {
    content: "",
    reset: 10,
    id: 1,
  },
]);
const addItem = () => {
  items.value.push({
    content: "",
    id: items.value.length + 1, // 保持唯一的 id
  });
};

const addRest = () => {
  items.value.push({
    reset: "",
    content: null,
    id: items.value.length + 1, // 保持唯一的 id
  });
};
</script>

<style lang="scss">
main {
  width: 100%;
  h1 {
    font-size: 3rem;
    text-align: center;
    font-weight: 600;
  }

  .add-btn {
    font-size: 1.3rem;
    cursor: pointer;
  }
  .listBox {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;

    .list {
      border-radius: 15px;
      background-color: #ffffff;
      margin: 15px;
      color: #1b1b1b;
      height: 35vh;
      display: flex;
      flex-direction: column;

      b {
        text-align: center;
        font-size: 1.3rem;
        font-weight: 600;
        margin-top: 10px;
        color: #2c3e50;

        span {
          font-size: 0.9rem;
        }
      }

      .check-box {
        padding-left: 20px;
      }

      .check-box span {
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

.add-popup {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  height: 100%;
  z-index: 1;
  background-color: rgba(0, 0, 0, 0.8);

  .add-bg {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 40vw;
    height: 70vh;
    border-radius: 25px;
    background-color: #e8e8e8;
  }

  .add-from {
    display: flex;
    flex-direction: column;
    align-items: center;
    input {
      font-size: 1.5rem;
      border: none;
      outline: none;
    }
  }
}

.line {
  width: 90%;
  height: 1px;
  background-color: #ccc;
  margin: 10px auto;
}
</style>
