<template>
  <main>
    <h1>lazy</h1>
    <button class="btn" @click="dialogVisible = true">+</button>

    <div class="listBox">
      <div class="list" v-for="mainGoal in lists" :key="mainGoal.id">
        <input type="text" v-if="mainGoal.goal == ''" />
        <div class="top">
          <b v-if="mainGoal.goal !== ''" class="goal-title"
            >{{ mainGoal.goal }}<span>總時間: {{ mainGoal.timing }} 分鐘</span></b
          >
          <el-tag type="danger" effect="dark" v-if="mainGoal.priority == 'high'"
            >高優先</el-tag
          >
          <el-tag type="warning" effect="dark" v-if="mainGoal.priority == 'medium'"
            >中等</el-tag
          >
          <el-tag type="success" effect="dark" v-if="mainGoal.priority == 'low'"
            >一般</el-tag
          >
          <div class="btn-box">
            <el-button @click="openEdit(mainGoal.id)" class="edit-btn">
              <el-icon :size="20"> <Edit /> </el-icon
            ></el-button>
          </div>
        </div>
        <div class="line"></div>
        <div class="itemBox" v-for="subGoal in mainGoal.subGoals" :key="subGoal.id">
          <label class="check-box" v-if="subGoal.type == 'item'">
            <input type="checkbox" />
            <span
              >{{ subGoal.content }}
              <p class="set-time" v-if="subGoal.timing !== undefined">
                {{ subGoal.timing }} m
              </p></span
            >
          </label>

          <p v-if="subGoal.type == 'rest'" class="reset-time">
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
    <el-form :model="form" label-width="auto" style="max-width: 500px">
      <el-form-item label="主目標">
        <el-input v-model="form.goal" />
      </el-form-item>
      <el-form-item label="設定總時間">
        <el-slider v-model="form.timing" :step="10" show-stops />
      </el-form-item>
      <hr />
      <div v-if="step == 0">
        <div v-for="item in form.subGoals" :key="item.id">
          <el-form-item class="mt-5" v-if="item.type === 'item'">
            <el-row :gutter="20">
              <el-col :span="1">
                <el-icon :size="20"><EditPen /> </el-icon>
              </el-col>

              <el-col :span="8">
                <el-input v-model="item.content" />
              </el-col>
              <el-col :span="10">
                <el-input-number
                  v-model="item.reset"
                  :step="5"
                  max="15"
                  min="0"
                  step-strictly
                />
              </el-col>

              <el-col :span="1">
                <el-button @click="deleteItem(item.id)">
                  <el-icon><Delete /></el-icon
                ></el-button>
              </el-col>
            </el-row>
          </el-form-item>

          <el-form-item class="mt-5" v-if="item.type === 'rest'">
            <el-icon class="mr-3" :size="20"><Timer /></el-icon>

            <el-input-number
              v-model="item.reset"
              :step="5"
              max="15"
              min="0"
              step-strictly
              class="mr-3"
            />
            分鐘
            <el-button @click="deleteItem(item.id)" class="ml-5">
              <el-icon><Delete /></el-icon
            ></el-button>
          </el-form-item>
        </div>
      </div>
      <div v-if="step == 1">
        <el-form-item label="優先程度" class="mt-5">
          <el-radio-group v-model="form.priority">
            <el-radio value="high"
              ><el-tag type="danger" effect="dark">高優先</el-tag></el-radio
            >
            <el-radio value="medium"
              ><el-tag type="warning" effect="dark">中等</el-tag></el-radio
            >
            <el-radio value="low"
              ><el-tag type="success" effect="dark">一般</el-tag></el-radio
            >
          </el-radio-group>
        </el-form-item>
        <el-form-item label="標籤" class="mt-5">
          <el-input-tag
            v-model="form.hashtag"
            draggable
            placeholder="若無請去設定新增hashtag"
            aria-label="Please click the Enter key after input"
          />
        </el-form-item>
      </div>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <div v-if="step == 0">
          <el-button @click="addRest">新增休息</el-button>
          <el-button @click="addItem">新增小目標</el-button>
          <el-button type="primary" @click="nextStep">下一頁</el-button>
        </div>
        <div v-if="step == 1">
          <el-button @click="backStep">回上一頁</el-button>
          <el-button type="primary" @click="saveGoal">儲存目標</el-button>
        </div>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, reactive } from "vue";

const step = ref(0);
// const totalSteps = ref(1);

const dialogVisible = ref(false);

const form = reactive({
  goal: "",
  timing: 0,
  hashtag: [],
  priority: "",
  subGoals: [],
});

const lists = reactive([
  {
    goal: "整理房間",
    id: Date.now(),
    timing: "01:30:00",
    hashtag: [],
    priority: "",
    subGoals: [
      { type: "item", content: "123", id: Date.now(), timing: 10 },
      {
        type: "rest",
        id: Date.now(),
        reset: 10,
      },
    ],
  },
]);

const openEdit = (id) => {
  const item = lists.findIndex((i) => i.id == id);
  console.log(item);
};

const addItem = () => {
  form.subGoals.push({
    type: "item",
    content: "",
    id: Date.now(),
  });
};

const addRest = () => {
  form.subGoals.push({
    type: "rest",
    id: Date.now(),
    reset: 10,
  });
};

const deleteItem = (id) => {
  const index = form.subGoals.findIndex((i) => i.id == id);
  if (index !== -1) {
    form.subGoals.splice(index, 1);
  }
};

const saveGoal = () => {
  lists.push(form);
  dialogVisible.value = false;
  console.log(lists);
};

const nextStep = () => {
  step.value++;
};

const backStep = () => {
  step.value--;
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
    grid-template-columns: 1fr 1fr 1fr 1fr;

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
