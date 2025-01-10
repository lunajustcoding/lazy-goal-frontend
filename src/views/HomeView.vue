<template>
  <header>
    <h1>lazy</h1>
  </header>
  <main>
    <div class="list">
      <div class="titleBox box">
        <p class="text-center">📋我的待辦事項</p>
      </div>
      <div class="inputBox text-center">
        <input type="text" value="" placeholder="請輸入新的事項" />
        <button>+</button>
      </div>
      <div class="todoBox items-left justify-center">
        <label class="check-box">
          <input type="checkbox" value="" />
          <span>狗罐頭給姑姑吃</span>
          <button>X</button>
        </label>
        <label class="check-box">
          <input type="checkbox" value="" />
          <span>買奇異果給家裡的狗吃</span>
          <button>X</button>
        </label>
      </div>
      <div class="tomatoBox box">
        <p>🍅專注模式</p>
        <p>🕰️25:00</p>
        <div class="playBox">
          <button>▶️開始</button>
          <button>⏸️暫停</button>
          <button>🔁重置</button>
        </div>
      </div>
      <div class="totalBox box">
        <p>番茄數量</p>
        <p>已完成事項</p>
        <div class="doneList">
          <p>✔️睡午覺( 1 🍅)</p>
          <p>✔️去洗碗( 2 🍅)</p>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup>
import { ref } from "vue";
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
    padding: 25px;
    margin: 0 auto;
    width: 350px;
    height: 450px;
    background-color: #fff;
    box-shadow: 5px 8px 10px rgb(0, 0, 0, 0.4);
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
