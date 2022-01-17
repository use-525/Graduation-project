<template>
  <section class="content">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1>Giải pháp</h1>
        </div>
      </div>

      <div class="row content-list">
        <div class="col-md-6 col-xs-12 col-lg-6 col-xl-4" v-for="solution in solutions" :key="solution.id">
          <div class="content-item">
            <router-link
              :to="{ name: 'portfolio', params: { username: solution.user.username } }"
              style="color: #fff; text-decoration: none"
            >
              <div class="solution-author">
                <div class="author-avatar">
                  <img v-if="solution.user.image" :src="'/' + solution.user.image" alt="" />
                  <img v-else :src="solution.user.photo_url" alt="" />
                </div>
                <span class="author-nickname" style="color: black">
                  {{ solution.user.name }}
                </span>
              </div>
            </router-link>
              <router-link
              :to="{ name: 'showDetailSolution', params: { id: solution.id } }"
              style="color: #fff; text-decoration: none"
            >
              <div class="solution-title">
                <h3 style="color: black">{{ solution.title }}</h3>
              </div>
              <div class="solution-help">
                <p v-if="solution.feedbacks.length==0" class="help-message" style="color: black">
                <span>Hãy là người đầu tiên phản hồi</span>
                </p>
                <p v-else class="help-message" style="color: black">
                  Tôi rất thích nghe phản hồi của bạn
                </p>
              </div>

              <div class="solution-challenges">
                <div class="row">
                  <div class="col-5">
                    <div class="challenge-name">
                      <p style="color: black">{{ solution.challenge.title }}</p>
                    </div>

                    <div class="challenge-level">
                        <span style="color: black" v-if="solution.challenge.level==1">Beginner</span>
                        <span style="color: black" v-else-if="solution.challenge.level==2">Elementary</span>
                        <span style="color: black" v-else-if="solution.challenge.level==3">Intermediate</span>
                        <span style="color: black" v-else-if="solution.challenge.level==4">Upper intermediate</span>
                        <span style="color: black" v-else-if="solution.challenge.level==5">Advanced</span>
                        <span style="color: black" v-else>Proficient</span>
                    </div>
                  </div>
                  <div class="col-7">
                    <div class="challenge-img">
                      <img :src="'/' + solution.challenge.image" alt="" />
                    </div>
                  </div>
                </div>
              </div>
            </router-link>

              <div class="solution-action">
                <div v-if="auth">
                  <div v-if="solution.upvote.length>0">
                      <div v-for="(upvote,index) in solution.upvote" :key="index">
                          <button v-if="upvote.user_id==auth.id" @click="upvoteSolution(solution.id)" type="button" class="upvote button-block-solution" style="width:100%; background: #1bb21b;">
                              <div class="icon">
                            <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                            </div>
                            <span v-if="solution.upvote" v-html="solution.upvote.length == 0 ? 'Thích':solution.upvote.length"></span>
                          </button>
                          <button v-else-if="upvote.user_id!=auth.id && solution.upvote.length==index+1" @click="upvoteSolution(solution.id)" type="button" class="upvote button-block-solution" style="width:100%;">
                              <div class="icon">
                            <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                            </div>
                            <span v-if="solution.upvote" v-html="solution.upvote.length == 0 ? 'Thích':solution.upvote.length"></span>
                          </button>
                      </div>
                  </div>
                  <button v-else @click="upvoteSolution(solution.id)" type="button" class="upvote button-block-solution" style="width:100%;">
                      <div class="icon">
                    <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                    </div>
                    <span v-if="solution.upvote" v-html="solution.upvote.length == 0 ? 'Thích':solution.upvote.length"></span>
                  </button>
                </div>
                <div v-else class="button-block-solution">
                  <div class="icon">
                    <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                  </div> 
                  <span v-if="solution.upvote">{{solution.upvote.length==0?'Thích':solution.upvote.length}}</span>
                </div>
                <router-link
              :to="{ name: 'showDetailSolution', params: { id: solution.id } }" style="width:48%; margin-left: 10px;"
            >
                 <div class="button-block-solution" style="width: 100%;">
                      <i class="ti-comment"></i>
                    <span class="pl-2" v-if="solution.feedbacks" v-html="solution.feedbacks.length"></span>
                  </div>
                </router-link>
              </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
    };
  },
  computed: {
    solutions() {
      return this.$store.state.solution.solutionByCate;
    },
     auth(){
      return this.$store.state.auth.user;
    }
  },
  created: function () {
    this.$store.dispatch("solution/byCate",this.$route.params.slug);
    this.$store.dispatch('auth/fetchUser');
    this.$store.dispatch("challengecategory/get_One_Data", this.$route.params.slug);
  },
  methods:{
    upvoteSolution(id){
        axios.post(route('upvote.solution',id))
        .then(response => {
          if(response.data.status == 'success'){
            this.$store.dispatch("solution/byCate",this.$route.params.slug);
          }
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    },
   
  }
};
</script>

<style lang="scss">
@import "../../../sass/solution.scss";
</style>