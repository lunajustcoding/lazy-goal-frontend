<template>
  <main>
    <h1>lazy</h1>
    <div class="btn-box">
      <button class="btn" @click="startGoal">開始專注</button>
      <button class="btn ml-5" @click="addGoal">暫停</button>
      <span class="mr-5 ml-5">|</span>
      <button class="btn" @click="addGoal">+</button>
      <button class="btn ml-5" @click="deleteGoalOpen">
        <el-icon :size="15"> <Delete /> </el-icon>
      </button>
    </div>
    <div class="listBox">
      <div class="list" v-for="mainGoal in lists" :key="mainGoal.id">
        <div class="top">
          <b v-if="mainGoal.goal !== ''" class="goal-title">{{ mainGoal.goal }}</b>

          <div class="btn-box">
            <el-button @click="openEdit(mainGoal.id)">
              <el-icon :size="20"> <Edit /> </el-icon
            ></el-button>
            <el-button v-if="deleteGoalBtn" @click="deleteGoal(mainGoal.id)" class="ml-5">
              <el-icon :size="20"><CloseBold /></el-icon>
            </el-button>
          </div>
          <span>總時間: {{ mainGoal.timing }} </span>
          <div class="tag-bx">
            <el-tag type="danger" effect="dark" v-if="mainGoal.priority == 'high'"
              >高優先</el-tag
            >
            <el-tag type="warning" effect="dark" v-if="mainGoal.priority == 'medium'"
              >中等</el-tag
            >
            <el-tag type="success" effect="dark" v-if="mainGoal.priority == 'low'"
              >一般</el-tag
            >
          </div>
        </div>
        <div class="line"></div>
        <div class="itemBox" v-for="subGoal in mainGoal.subGoals" :key="subGoal.id">
          <label class="check-box" v-if="subGoal.type == 'item'">
            <input type="checkbox" :value="subGoal.checked" />
            <span
              >{{ subGoal.content }}
              <p class="set-time" v-if="subGoal.timing !== undefined">
                {{ subGoal.timing }} m
              </p></span
            >
          </label>

          <p v-if="subGoal.type == 'rest'" class="reset-time">
            休息時間：{{ subGoal.timing }} 分鐘
          </p>
        </div>
      </div>
    </div>
  </main>

  <el-dialog
    v-model="dialogFormRef"
    title="新增目標"
    width="650"
    :before-close="handleClose"
  >
    <el-form :model="form" label-width="auto" style="max-width: 650px">
      <el-form-item label="主目標">
        <el-input v-model="form.goal" />
      </el-form-item>
      <el-form-item label="設定總時間">
        <el-slider v-model="form.timing" :step="10" show-stops />
      </el-form-item>
      <hr />
      <div v-if="step == 0">
        <div v-for="item in form.subGoals" :key="item.id">
          <el-form-item
            class="mt-5 items-center justify-center"
            v-if="item.type === 'item'"
          >
            <el-row :gutter="20" justify="center">
              <el-col :span="13">
                <el-form-item label="執行項目">
                  <el-input v-model="item.content" placeholder="請輸入細節" />
                </el-form-item>
              </el-col>
              <el-col :span="9">
                <el-form-item label="花費分鐘">
                  <el-input-number v-model="item.timing" max="15" min="0" step-strictly />
                </el-form-item>
              </el-col>

              <el-col :span="1">
                <el-button @click="deleteItem(item.id)">
                  <el-icon><Delete /></el-icon
                ></el-button>
              </el-col>
            </el-row>
          </el-form-item>

          <el-form-item class="mt-5" v-if="item.type === 'rest'">
            休息時間
            <el-input-number
              v-model="item.timing"
              :step="5"
              max="15"
              min="0"
              step-strictly
              class="mr-3 ml-3"
            />
            分鐘
            <el-button @click="deleteItem(item.id)" class="ml-3">
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
          <el-button type="primary" @click="saveGoal(form)">儲存目標</el-button>
        </div>
      </div>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";

const step = ref(0);
// const totalSteps = ref(1);

const dialogFormRef = ref(false);
const deleteGoalBtn = ref(false);

const form = ref({
  goal: "",
  id: new Date().getTime(),
  timing: "",
  hashtag: [],
  priority: "",
  subGoals: [],
});

const lists = ref([
  {
    goal: "整理房間",
    id: new Date().getTime(),
    timing: 10,
    hashtag: [],
    priority: "medium",
    subGoals: [
      {
        type: "item",
        content: "123",
        checked: false,
        timing: 20,
        id: new Date().getTime(),
      },
      {
        type: "rest",
        timing: 15,
        id: Date.now(),
      },
    ],
  },
]);

const addGoal = () => {
  step.value = 0;
  dialogFormRef.value = true;
  form.value = {
    goal: "",
    id: new Date().getTime(),
    timing: "",
    hashtag: [],
    priority: "",
    subGoals: [],
  };
};

const minutesToHours = (min) => {
  const d = new Date(0, 0, 0, 0, min);
  const h = d.getHours();
  const m = d.getMinutes();
  const text = h == 0 ? `${m}分鐘` : `${h}小時${m}分鐘`;
  return text;
};

const deleteGoalOpen = () => {
  deleteGoalBtn.value = !deleteGoalBtn.value;
};

const openEdit = (id) => {
  console.log(id);

  dialogFormRef.value = true;
  step.value = 0;
  const item = lists.value.find((i) => i.id == id);
  if (item) {
    Object.assign(form.value, JSON.parse(JSON.stringify(item)));
  }
};

const addItem = () => {
  form.value.subGoals.push({
    type: "item",
    id: new Date().getTime(),
    content: "",
    checked: false,
    timing: 0,
  });
};

const addRest = () => {
  form.value.subGoals.push({
    type: "rest",
    id: new Date().getTime(),
    timing: 0,
  });
};

const deleteItem = (id) => {
  const index = form.value.subGoals.findIndex((i) => i.id == id);
  if (index !== -1) {
    form.value.subGoals.splice(index, 1);
  }
};

const saveGoal = (form) => {
  if (typeof form.timing == "number") {
    form.timing = minutesToHours(form.timing);
  }
  const index = lists.value.findIndex((i) => i.id === form.id);
  if (index !== -1) {
    lists.value[index] = { ...form };
  } else {
    lists.value.push(form);
  }
  dialogFormRef.value = false;
};

const deleteGoal = (id) => {
  const item = lists.value.findIndex((i) => id == i.id);
  if (item !== -1) {
    lists.value.splice(item, 1);
  }
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
      max-width: 300px;
      border-radius: 15px;
      background-color: #ffffff;
      margin: 15px;
      color: #1b1b1b;
      height: auto;
      padding: 10px 0;
      display: flex;
      flex-direction: column;

      .top {
        display: grid;
        align-items: center;
        padding: 0 15px;
        grid-template-columns: 3fr 0.5fr;
        .goal-title {
          text-align: center;
          font-size: 1.3rem;
          font-weight: 600;
          color: #2c3e50;
          display: flex;
          flex-direction: column;
          align-items: flex-start;
        }
        span {
          font-size: 0.9rem;
        }
        .btn-box {
          display: flex;
          justify-content: right;
          align-items: center;
          button {
            margin: 0;
            padding: 0;

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
