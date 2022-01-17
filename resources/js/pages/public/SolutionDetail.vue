<template>
  <section class="content mt-4">
    <div class="container">
      <div class="row">
        <div class="col-12 col-md-12 col-xs-9 col-lg-9 col-xl-9">
          <div class="row info-solution" v-if="solution">
            <div class="col-12">
              <div class="row">
                <div class="col-8" v-if="solution.user">
                  <router-link
                    :to="{ name: 'portfolio', params: { username: solution.user.username } }"
                  >
                   <div class="author">
                      <div class="author-avatar">
                        <img v-if="solution.user.image" :src="'/' + solution.user.image" alt="" />
                        <img v-else :src="solution.user.photo_url" alt="" />
                      </div>
                      <span class="author-nickname">{{ solution.user.username }} </span>
                    </div>
                  </router-link>
                </div>
                <div class="col-4" v-if="solution.challenge">
                  <div v-if="auth" class="text-right demo-code-block">
                      <router-link v-if="auth.id==solution.user_id"
                      :to="{ name: 'editSolution', params: { slug: solution.challenge.slug } }"
                    ><button class="btn-view-code">Chỉnh sửa</button></router-link>
                  </div>
                </div>
              </div>

              <div class="solution-title">
                <h3>{{ solution.title }}</h3>
              </div>
              
              <div>
                <span class="solution-time" v-if="solution.time"> {{solution.time}}</span>
                <span style="display: inline-block; margin-left: 8px; margin-right: 8px"
                  >.</span
                >
              </div>
              
              <div class="solution-detail-des">
                <p v-html="solution.description"></p>
              </div>
            </div>
          </div>

          <div class="row content-preview-wrap mt-3">
            <div class="col-12">
              <div class="preview-content">
                <div class="preview-content-head">
                  <h3>Preview</h3>

                  <div class="demo-code-block">
                    <a :href="solution.demo_url" target="_blank"><button class="btn-demo">Demo</button></a>
                    <a :href="solution.link_github" target="_blank"><button class="btn-view-code">Code</button></a>
                  </div>
                </div>

                <div class="preview-content-body">
                  <iframe
                    :src="solution.demo_url"
                      width="100%"
                    height= "600px"
                    frameborder="0" 
                    >
                  </iframe>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <h3 class="feedback-title" id="feedback">Phản hồi</h3>
            </div>
          </div>

          <div class="feedback-wrapper" v-if="feedbacks.length>0">
            <div class="row feedback-row">
              <div class="col-12" v-for="(feedback,index) in feedbacks" :key="index">
              <div v-if="feedback.parent_id==0"> 
                <div class="feedback-content">
                  <div class="row">
                    <div class="col-lg-3 col-md-12 col-md-12">
                      
                      <div v-if="auth">
                        <div v-if="feedback.upvote.length>0">
                            <div v-for="(upvote,index) in feedback.upvote" :key="index">
                                <button v-if="upvote.user_id==auth.id" @click="upvoteFeedback(feedback.id)" type="button" class="upvote button-block" style="width:100%; background: #1bb21b;">
                                    <div class="icon">
                                  <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                                  </div>
                                  <span v-if="feedback.upvote" v-html="feedback.upvote.length == 0 ? 'Thích':feedback.upvote.length"></span>
                                </button>
                                <button v-if="upvote.user_id!=auth.id && feedback.upvote.length==index+1" @click="upvoteFeedback(feedback.id)" type="button" class="upvote button-block" style="width:100%;">
                                    <div class="icon">
                                  <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                                  </div>
                                  <span v-if="feedback.upvote" v-html="feedback.upvote.length == 0 ? 'Thích':feedback.upvote.length"></span>
                                </button>
                            </div>
                        </div>
                        <button v-else @click="upvoteFeedback(feedback.id)" type="button" class="upvote button-block" style="width:100%;">
                            <div class="icon">
                          <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                          </div>
                          <span v-if="feedback.upvote" v-html="feedback.upvote.length == 0 ? 'Thích':feedback.upvote.length"></span>
                        </button>
                      </div>
                      <div v-else>
                        <div class="button-block">
                          <div class="icon">
                            <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                        </div> 
                              <span v-if="feedback.upvote">{{feedback.upvote.length==0?'Thích':feedback.upvote.length}}</span>
                        </div>
                      </div>
                      <div class="feedback-user-section" v-if="feedback.users">
                        <router-link
                          :to="{ name: 'portfolio', params: { username: feedback.users.username } }"
                        >
                          <div class="feedback-user-info">
                            <div class="feedback-user-img">
                              <img v-if="feedback.users.image" :src="'/'+feedback.users.image" alt=""/>
                              <img v-else :src="feedback.users.photo_url" alt=""/>
                            </div>

                            <div>
                              <p class="feedback-user-name">{{feedback.users.username}}</p>
                              <!-- <span class="feedback-user-reputation">10 reputations</span> -->
                            </div>
                          </div>
                        </router-link>
                      </div>
                       <div class="mt-3" v-if="auth">
                            <button v-if="auth.id == feedback.user_id" ref="btnEdit" @click="editFeedback(index)" type="button" class="edit rounded btn btn-secondary mr-2" style="background-color:#6d2fff">
                              <svg class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit" focusable="false" viewBox="0 0 24 24" aria-hidden="true"><path d="M3 17.46v3.04c0 .28.22.5.5.5h3.04c.13 0 .26-.05.35-.15L17.81 9.94l-3.75-3.75L3.15 17.1c-.1.1-.15.22-.15.36zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a.9959.9959 0 00-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"></path></svg>
                            <span>Sửa</span>
                            </button>
                            <button v-if="auth.id == feedback.user_id" ref="btnSave" type="button" @click="saveFeedback(index,feedback.id)" class="edit rounded btn btn-secondary mr-2 d-none" style="background-color:#6d2fff">
                                <i class="ti-save"></i> <span> Lưu</span>
                            </button>
                            <button v-if="auth.id == feedback.user_id" @click="removeFeedback(feedback.id)" type="button" class="edit rounded btn btn-secondary">
                              <i class="ti-trash"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-12">
                      <div class="feedback-detail">
                        <p  ref="feedbackContent" v-html="feedback.feedback_content"></p>
                        <div v-if="auth">
                          <form action="" ref="formSave" v-if="auth.id == feedback.user_id" class="d-none">
                         <ckeditor 
                                  ref="content"
                                  v-model="feedback.feedback_content"
                                ></ckeditor>
                        </form>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="feedback-time">
                  <span v-if="feedback.time">{{feedback.time}}</span>
                </div>
              </div>
              <div v-if="feedback.parent_id>0">
                  <div class="row">
                    <div class="col-1"></div>
                    <div class="col-11 reply-feedback">
                      <div class="row">
                        <div class="col-lg-3 col-md-12">
                             <div v-if="auth">
                                  <div v-if="feedback.upvote.length>0">
                                      <div v-for="(upvote,index) in feedback.upvote" :key="index">
                                          <button v-if="upvote.user_id==auth.id" @click="upvoteFeedback(feedback.id)" type="button" class="upvote button-block" style="width:100%; background: #1bb21b;">
                                              <div class="icon">
                                            <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                                            </div>
                                            <span v-if="feedback.upvote" v-html="feedback.upvote.length == 0 ? 'Thích':feedback.upvote.length"></span>
                                          </button>
                                          <button v-else-if="upvote.user_id!=auth.id && feedback.upvote.length==index+1" @click="upvoteFeedback(feedback.id)" type="button" class="upvote button-block" style="width:100%;">
                                              <div class="icon">
                                            <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                                            </div>
                                            <span v-if="feedback.upvote" v-html="feedback.upvote.length == 0 ? 'Thích':feedback.upvote.length"></span>
                                          </button>
                                      </div>
                                  </div>
                                  <button v-else @click="upvoteFeedback(feedback.id)" type="button" class="upvote button-block" style="width:100%;">
                                      <div class="icon">
                                    <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                                    </div>
                                    <span v-if="feedback.upvote" v-html="feedback.upvote.length == 0 ? 'Thích':feedback.upvote.length"></span>
                                  </button>
                             </div>
                            <div v-else>
                              <div class="button-block">
                                <div class="icon">
                                  <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                              </div> 
                                    <span v-if="feedback.upvote">{{feedback.upvote.length==0?'Thích':feedback.upvote.length}}</span>
                              </div>
                            </div>
                            <router-link
                              :to="{ name: 'portfolio', params: { username: feedback.users.username } }"
                            >
                            <div class="reply-feedback-user-info" v-if="feedback.users">
                              <div class="feedback-user-img">
                               <img v-if="feedback.users.image" :src="'/'+feedback.users.image" alt=""/>
                                <img v-else :src="feedback.users.photo_url" alt=""/>
                              </div>

                              <div>
                                <p class="feedback-user-name">{{feedback.users.username}}</p>
                                <!-- <span class="feedback-user-reputation"
                                  >10 reputations</span> -->
                              </div>
                            </div>
                          </router-link>
                            <div v-if="auth">
                              <button v-if="auth.id == feedback.user_id" ref="btnEdit" @click="editFeedback(index-1)" type="button" class="edit button-block">
                                <div class="icon">
                               <svg class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit" focusable="false" viewBox="0 0 24 24" aria-hidden="true"><path d="M3 17.46v3.04c0 .28.22.5.5.5h3.04c.13 0 .26-.05.35-.15L17.81 9.94l-3.75-3.75L3.15 17.1c-.1.1-.15.22-.15.36zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34a.9959.9959 0 00-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z"></path></svg>
                              </div>
                              <span>Sửa</span>
                              </button>

                            <button v-if="auth.id == feedback.user_id" ref="btnSave" type="button" @click="saveFeedback(index-1,feedback.id)" class="edit button-block d-none">
                                <div class="icon">
                                    <svg class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit" focusable="false" viewBox="0 0 24 24" aria-hidden="true"><path d="M17.59 3.59c-.38-.38-.89-.59-1.42-.59H5c-1.11 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V7.83c0-.53-.21-1.04-.59-1.41l-2.82-2.83zM12 19c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm1-10H7c-1.1 0-2-.9-2-2s.9-2 2-2h6c1.1 0 2 .9 2 2s-.9 2-2 2z"></path></svg>
                                </div>
                                <span>Lưu</span>
                            </button>
                            </div>
                        </div>

                        <div class="col-lg-9 col-md-12">
                          <div class="reply-feedback-detail">
                              <p ref="feedbackContent" v-html="feedback.feedback_content"></p>
                              <div v-if="auth">
                                <form action="" ref="formSave" v-if="auth.id == feedback.user_id" class="d-none">
                                
                                <ckeditor
                                  ref="content"
                                  v-model="feedback.feedback_content"
                                ></ckeditor>
                              </form>
                              </div>
                               
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="feedback-time">
                      <span v-if="feedback.time">{{feedback.time}}</span>
                  </div>
              </div>
              <!-- Thêm feedback theo parent_id -->
              <div v-if="feedbacks[index+1] && auth">
                <div v-if="feedbacks[index+1].parent_id==0" class="row">
                  
                  <div class="col-1"></div>
                  <div class="col-11">
                    <div class="row">
                      <div class="col-12">
                        <form  @submit.prevent="replyFeedback(index-1,feedback.parent_id==0 ? feedback.id: feedback.parent_id)"
                          @keydown="form.onKeydown($event)">
                              <textarea class="form-control" ref="feedback_content" style="height: 100px"></textarea>
                        <div
                          class="text-danger"
                          v-if="form.errors.has('feedback_content')"
                          v-html="form.errors.get('feedback_content')"
                        />
                          <div style="float: right">
                            <button type="submit" class="send-feedback">Gửi</button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div v-if="!feedbacks[index+1] && auth" class="row">
                <div class="col-1"></div>
                <div class="col-11">
                  <div class="row">
                    <div class="col-12">
                      <form  @submit.prevent="replyFeedback(index,feedback.parent_id==0 ? feedback.id: feedback.parent_id)"
                        @keydown="form.onKeydown($event)">
                       
                      <textarea class="form-control" ref="feedback_content" style="height: 100px"></textarea>
                      <div
                        class="text-danger"
                        v-if="form.errors.has('feedback_content')"
                        v-html="form.errors.get('feedback_content')"
                      />
                        <div style="float: right">
                          <button type="submit" class="send-feedback">Gửi</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            </div>
          </div>
            <!-- Gửi feedback -->
          <div class="row" v-if="auth">
            <div class="col-12">
              <div class="row">
                <div class="col-12">
                  <form @submit.prevent="submitFeedback"
                    @keydown="form.onKeydown($event)">
                     <ckeditor
                    v-model="form.feedback_content"
                    :class="{ 'is-invalid': form.errors.has('feedback_content') }"
                  ></ckeditor>
                   <div
                    class="text-danger"
                    v-if="form.errors.has('feedback_content')"
                    v-html="form.errors.get('feedback_content')"
                  />
                    <div style="float: right">
                      <button type="submit" class="send-feedback">Gửi</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
          <div class="row" v-else>
            <div class="col-12"><p> Bạn cần đăng nhập mới có thể gửi phản hồi!</p></div>
          </div>
        </div>

        <div class="col-12 col-md-12 col-xs-3 col-lg-3 col-xl-3">
          <div class="row">
            <div class="col-12">
              <div class="content-item">
                <div class="solution-challenge">
                  <div class="row" v-if="solution.challenge">
                    <router-link
                      :to="{ name: 'chanllenge', params: { slug: solution.challenge.slug } }"
                    >
                    <div class="col-12">
                      <div class="challenge-img">
                        <img :src="'/'+solution.challenge.image" alt="" />
                      </div>
                    </div>
                    <div class="col-12">
                      <div class="challenge-name">
                        <p>{{ solution.challenge.title }}</p>
                      </div>

                      <div class="challenge-level">
                        <span v-if="solution.challenge.level==1">Beginner</span>
                        <span v-else-if="solution.challenge.level==2">Elementary</span>
                        <span v-else-if="solution.challenge.level==3">Intermediate</span>
                        <span v-else-if="solution.challenge.level==4">Upper intermediate</span>
                        <span v-else-if="solution.challenge.level==5">Advanced</span>
                        <span v-else>Proficient</span>
                      </div>
                    </div>
                    </router-link>
                  </div>
                </div>

                <div v-if="auth">
                  <button v-if="checkVote" @click="upvoteSolution()" type="button" class="upvote button-block" style="width:100%; background: #1bb21b;">
                    <div class="icon">
                  <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                  </div>
                  <span v-if="solution.upvote" v-html="solution.upvote.length == 0 ? 'Thích':solution.upvote.length"></span>
                </button>
                  <button v-if="!checkVote" @click="upvoteSolution()" type="button" class="upvote button-block" style="width:100%;">
                    <div class="icon">
                  <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                  </div>
                  <span v-if="solution.upvote" v-html="solution.upvote.length == 0 ? 'Thích':solution.upvote.length"></span>
                </button>
                </div>
                <div v-else>
                  <div class="button-block">
                    <div class="icon">
                      <svg focusable="false" viewBox="0 0 24 24" aria-hidden="true" class="MuiSvgIcon-root MuiSvgIcon-fontSizeInherit"><path d="M8 6.82v10.36c0 .79.87 1.27 1.54.84l8.14-5.18c.62-.39.62-1.29 0-1.69L9.54 5.98C8.87 5.55 8 6.03 8 6.82z"></path></svg>
                  </div> 
                        <span v-if="solution.upvote">{{solution.upvote.length==0?'Thích':solution.upvote.length}}</span>
                  </div>
                </div>
                  <a href="#feedback">
                    <div class="feedback button-block mt-2">
                    <i class="ti-comment"></i>
                  <span class="pl-2" v-if="solution.feedbacks" v-html="solution.feedbacks.length == 0 ?' Phản hồi': solution.feedbacks.length"></span>
                </div>
                  </a>
              </div>
            </div>
          </div>

          <!-- <div class="row">
            <div class="col-12">
              <div class="share-block">
                <div class="row">
                  <div class="col-6">
                    <h3>Chia sẻ</h3>
                  </div>

                  <div class="col-6 share-social">
                    <div>
                      <svg
                        class="MuiSvgIcon-root icon-share icon-share-hover"
                        focusable="false"
                        viewBox="0 0 24 24"
                        aria-hidden="true"
                      >
                        <path
                          d="M22.46 6c-.77.35-1.6.58-2.46.69.88-.53 1.56-1.37 1.88-2.38-.83.5-1.75.85-2.72 1.05C18.37 4.5 17.26 4 16 4c-2.35 0-4.27 1.92-4.27 4.29 0 .34.04.67.11.98C8.28 9.09 5.11 7.38 3 4.79c-.37.63-.58 1.37-.58 2.15 0 1.49.75 2.81 1.91 3.56-.71 0-1.37-.2-1.95-.5v.03c0 2.08 1.48 3.82 3.44 4.21a4.22 4.22 0 0 1-1.93.07 4.28 4.28 0 0 0 4 2.98 8.521 8.521 0 0 1-5.33 1.84c-.34 0-.68-.02-1.02-.06C3.44 20.29 5.7 21 8.12 21 16 21 20.33 14.46 20.33 8.79c0-.19 0-.37-.01-.56.84-.6 1.56-1.36 2.14-2.23z"
                        ></path>
                      </svg>
                    </div>
                    <div>
                      <svg
                        class="MuiSvgIcon-root icon-share icon-share-hover"
                        focusable="false"
                        viewBox="0 0 24 24"
                        aria-hidden="true"
                      >
                        <path
                          d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.32 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.79M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z"
                        ></path>
                      </svg>
                    </div>
                    <a
                      class="share-copy-link icon-share-hover"
                      title="Copy solution link"
                    >
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        height="22"
                        viewBox="0 0 24 24"
                        width="22"
                      >
                        <path d="M0 0h24v24H0V0z" fill="none"></path>
                        <path
                          d="M15 1H4c-1.1 0-2 .9-2 2v13c0 .55.45 1 1 1s1-.45 1-1V4c0-.55.45-1 1-1h10c.55 0 1-.45 1-1s-.45-1-1-1zm4 4H8c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h11c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm-1 16H9c-.55 0-1-.45-1-1V8c0-.55.45-1 1-1h9c.55 0 1 .45 1 1v12c0 .55-.45 1-1 1z"
                        ></path>
                      </svg>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div> -->

          <!-- <div class="row">
            <div class="col-12">
              <div class="share-block">
                 <div v-if="solution.user">
                    <div class="feedback-user-info">
                      <div class="feedback-user-img">
                        <img v-if="solution.user.image" :src="'/' + solution.user.image" alt="" />
                        <img v-else :src="solution.user.photo_url" alt="" />
                      </div>

                      <div>
                        <p class="feedback-user-name">{{solution.user.name}}</p>
                        <span class="feedback-user-reputation">1 reputations</span>
                      </div>
                    </div>
                  </div>
                <div class="user-skill-wrapper">
                  <div class="skill-list">
                    <button class="btn-feedback">
                      <span class="">Mentoring</span>
                      <svg
                        class="MuiSvgIcon-root icon-feedback"
                        focusable="false"
                        viewBox="0 0 24 24"
                        aria-hidden="true"
                      >
                        <path
                          d="M18 13h-5v5c0 .55-.45 1-1 1s-1-.45-1-1v-5H6c-.55 0-1-.45-1-1s.45-1 1-1h5V6c0-.55.45-1 1-1s1 .45 1 1v5h5c.55 0 1 .45 1 1s-.45 1-1 1z"
                        ></path>
                      </svg>
                    </button>
                    <button class="btn-feedback">
                      <span class="">Mentoring</span>
                      <svg
                        class="MuiSvgIcon-root icon-feedback"
                        focusable="false"
                        viewBox="0 0 24 24"
                        aria-hidden="true"
                      >
                        <path
                          d="M18 13h-5v5c0 .55-.45 1-1 1s-1-.45-1-1v-5H6c-.55 0-1-.45-1-1s.45-1 1-1h5V6c0-.55.45-1 1-1s1 .45 1 1v5h5c.55 0 1 .45 1 1s-.45 1-1 1z"
                        ></path>
                      </svg>
                    </button>
                  </div>
                  <span class="skill-more">more</span>
                </div>
              </div>
            </div>
          </div> -->
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      feedbacks: {},
      checkVote:null,
      form: new Form({
        feedback_content: "",
    }),
    };
  },
  computed: {
    solution() {
      return this.$store.state.solution.solution;
    },
    auth(){
      return this.$store.state.auth.user;
    }
  },
  created: function () {
    this.$store.dispatch("solution/fetchOne", this.$route.params.id);
    this.$store.dispatch('auth/fetchUser');
    this.getFeedback();
    this.checkUpvote();
  },
  methods:{
    getFeedback() {
        axios.get(route('solutionFeedback.feedback',this.$route.params.id))
        .then(response => {
          var result = response.data.data;
          this.feedbacks = result;
          this.$store.dispatch("challengecategory/fetchOne", this.solution.challenge.cate_challen_id);
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    },
    async submitFeedback() {
        await this.form.post(route('create.feedback',[0,this.$route.params.id]))
        .then(response => {
          if(response.data.status == 'success'){
            this.form.feedback_content="";
            this.getFeedback()
                Swal.fire(
                    'Thành công',
                    'Bình luận đang chờ duyệt.',
                    'success'
                );
          }
        })
          .catch(() => {
            Swal.fire({
              icon: "error",
              title: "Oops...",
              text: "Đã xảy ra lỗi!",
            });
          });
    },
    async replyFeedback(index,id) {
       this.form.feedback_content = this.$refs.feedback_content[index].value;
        await this.form.post(route('create.feedback',[id,this.$route.params.id]))
        .then(response => {
          if(response.data.status == 'success'){
            this.form.feedback_content="";
            this.getFeedback()
                Swal.fire(
                    'Thành công',
                    'Bình luận đang chờ duyệt.',
                    'success'
                );
            }
        })
          .catch(() => {
            Swal.fire({
              icon: "error",
              title: "Oops...",
              text: "Đã xảy ra lỗi!",
            });
          });
    },
    upvoteSolution(){
        axios.post(route('upvote.solution',this.$route.params.id))
        .then(response => {
          if(response.data.status == 'success'){
            this.checkUpvote();
            this.$store.dispatch("solution/fetchOne", this.$route.params.id);
          }
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    },
    saveFeedback(index,id){
       this.$refs.btnEdit[index].classList.remove("d-none");
       this.$refs.feedbackContent[index+1].classList.remove("d-none");
       this.$refs.btnSave[index].classList.add('d-none');
       this.$refs.formSave[index].classList.add('d-none');
       this.form.feedback_content = this.$refs.content[index].value;
       this.form.post(route('update.feedback',id))
        .then(response => {
          if(response.data.status == 'success'){
            this.form.feedback_content="";
                Swal.fire(
                    'Thành công',
                    'Sửa bình luận thành công.',
                    'success'
                );
            }
        })
          .catch(() => {
            Swal.fire({
              icon: "error",
              title: "Oops...",
              text: "Đã xảy ra lỗi!",
            });
          });
    },
    editFeedback(index){
       this.$refs.btnEdit[index].classList.add('d-none');
       this.$refs.feedbackContent[index+1].classList.add('d-none');
       this.$refs.btnSave[index].classList.remove("d-none");
       this.$refs.formSave[index].classList.remove("d-none");
    },
   async removeFeedback(id){
      this.$store.dispatch('feedback/deleteFeedback', id).then(
         await this.getFeedback()
      )
    },
    checkUpvote(){
      axios.get(route('checkUpvote.solution',this.$route.params.id))
        .then(response => {
          var result = response.data.data;
          this.checkVote = result;
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    },
    upvoteFeedback(id){
      axios.post(route('upvote.feedback',id))
        .then(response => {
          if(response.data.status == 'success'){
                this.getFeedback();
          }
        })
        // eslint-disable-next-line
        .catch(errors => {
            //Handle Errors
        })
    }

  }
};
</script>

<style lang="scss">
@import "../../../sass/solution-detail.scss";

</style>
