<template>
  <main>
    <h1>lazy</h1>
    <button class="btn" @click="openPopup">+</button>
    <el-button plain @click="dialogVisible = true"> Click to open the Dialog </el-button>

    <div class="listBox">
      <div class="list" v-for="mainGoal in lists" :key="mainGoal.id">
        <input type="text" v-if="mainGoal.goal == ''" />

        <div class="top">
          <b v-if="mainGoal.goal !== ''" class="goal-title"
            >{{ mainGoal.goal }}<span>總時間:{{ mainGoal.Timing }}</span></b
          >
          <div class="btn-box">
            <el-button @click="openPopup('edit', mainGoal.id)" class="edit-btn">
              <el-icon> <Edit /> </el-icon
            ></el-button>
          </div>
        </div>
        <div class="line"></div>
        <div class="itemBox" v-for="subGoal in mainGoal.subGoals" :key="subGoal.id">
          <label class="check-box">
            <input type="checkbox" />
            <input type="text" v-if="subGoal.content == ''" />
            <span v-else>{{ subGoal.content }}</span>
          </label>
          <span class="set-time">{{ subGoal.Timing }}</span>
          <br />
          <p v-if="subGoal.reset !== null" class="reset-time">
            休息時間：{{ subGoal.reset }} 分鐘
          </p>
        </div>
      </div>
    </div>
  </main>

  <el-dialog
    v-model="dialogVisible"
    title="新增目標"
    width="500"
    :before-close="handleClose"
  >
    <el-form :model="form" label-width="auto" style="max-width: 600px">
      <el-form-item label="主目標">
        <el-input v-model="form.goal" />
      </el-form-item>
      <el-form-item label="設定總時間">
        <el-slider v-model="form.reset" :step="10" show-stops />
      </el-form-item>
      <hr />
      <el-form-item
        class="mt-5"
        label="小目標"
        v-for="item in form.subGoals"
        :key="item.id"
      >
        <el-input v-model="form.item" />
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="dialogVisible = false">儲存</el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from "vue";

const dialogVisible = ref(false);

const form = reactive({
  goal: "",
  Timing: 0,
  subGoals: [
    {
      content: "",
      Timing: "",
      reset: 10,
      id: 1,
    },
  ],
});

const lists = reactive([
  {
    goal: "整理房間",
    id: Date.now(),
    Timing: "01:30:00",
    subGoals: [
      {
        content: "把冰箱發霉的檸檬拿去丟",
        Timing: "05:00",
        reset: 10,
        id: 1,
      },
    ],
  },
]);

const openPopup = () => {
  dialogVisible.value = true;
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

  .btn {
    font-size: 1.3rem;
    cursor: pointer;
  }
  .listBox {
    display: grid;
    grid-template-columns: 0.5fr 1fr 0.5fr;

    .list {
      border-radius: 15px;
      background-color: #ffffff;
      margin: 15px;
      color: #1b1b1b;
      height: auto;
      padding: 10px 0;
      display: flex;
      flex-direction: column;

      .top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        .goal-title {
          text-align: center;
          font-size: 1.3rem;
          font-weight: 600;
          margin-top: 10px;
          color: #2c3e50;
          display: flex;
          flex-direction: column;
          align-items: flex-start;
          padding-left: 15px;

          span {
            font-size: 0.9rem;
          }
        }

        .btn-box {
          padding-right: 10px;
          button {
            background-color: transparent;
            border: none;
            cursor: pointer;
          }
        }
      }

      .set-time {
        float: right;
        padding-right: 23px;
      }

      .reset-time {
        margin: 5px 0;
        text-align: center;
        color: #2c3e50;
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

.popup {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  height: 100%;
  z-index: 1;
  background-color: rgba(0, 0, 0, 0.8);

  .bg {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 40vw;
    height: auto;
    border-radius: 25px;
    padding: 15px 0;
    background-color: #e8e8e8;

    .timing {
      border: 1px solid red;
      display: flex;
    }

    .submit {
      display: block;
      border: none;
      text-align: center;
      font-size: 1rem;
      background-color: transparent;
      cursor: pointer;
      margin: 0 auto;
    }
  }

  .from {
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
