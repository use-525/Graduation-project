<template>
  <section class="content mt-4 payment">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h2>Thanh toán</h2>
        </div>
      </div>
      <br />
      <div class="row">
        <div class="col-7">
          <h3>Chọn hình thức thanh toán</h3>
          <div class="payment-list">
            <div  @click="checkoutBanking()" class="payment-item payment-with-bank">
              <img src="/images/bank-icon.png" width="30" />
              <p>Thanh toán qua chuyển khoản ngân hàng</p>
            </div>

            <div class="payment-item payment-with-momo">
              <img src="/images/momo_logo.png" width="30" />
                <p><button type="button" style="border: none; cursor: pointer;background: transparent;"
                @click="checkout()">Thanh toán qua ví điện tử MOMO</button></p>
            </div>
          </div>
        </div>

        <div class="col-5">
          <h3>Thông tin chuyển khoản</h3>
          <div class="info-user-payment" v-if="auth">
            <p><b>Họ và tên:</b> TA NGOC NINH</p>
            <p><b>Số tài khoản:</b> 48810000079810</p>
            <p><b>Ngân Hàng:</b> BIDV</p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: mapGetters({
    auth: 'auth/user'
  }),
  
  created () {
    this.$store.dispatch('auth/fetchUser');
  },
  methods:{
    checkout(){
       axios.post(route('order.purchase',this.$route.params.upgrade_id)).then(response => {
             var result = response.data.data;
             console.log(result)
             window.location.href =result;
          })
          // eslint-disable-next-line
          .catch(errors => {
              //Handle Errors
          })
    },
    checkoutBanking(){
         Swal.fire({
              icon: "info",
              title: "Nội Dung Chuyển Khoản",
              text: "Kích Hoạt Tài Khoản: "+this.auth.email,
            });
    }
  }
};
</script>

<style scoped>
.overlay {
  display: none;
}
.payment h3 {
  margin-bottom: 12px;
  font-family: "Lato", sans-serif;
  font-weight: 600;
  color: var(--black);
}

.payment h2 {
  padding: 12px;
  background: linear-gradient(to right, #6d2fff, #6f42c1);
  color: #fff;
  font-weight: 600;
  border-radius: 4px;
}
.payment-item {
  padding: 16px;
  border: 1px solid #d5d5d5;
  border-radius: var(--border-radius-main);
  margin-bottom: 24px;
  background-color: var(--background-light);
  box-shadow: 0 1px 3px 0 rgb(0 0 0 / 6%), 0 1px 2px 0 rgb(0 0 0 / 4%);
  transition: 0.3s;
  cursor: pointer;
  display: flex;
  align-items: center;
}

.payment-item:hover {
  border: 1px solid var(--grey-color);
}

.payment-item p {
  margin: 0;
  font-size: 1rem;
}

.payment-pop-momo,
.payment-pop-bank {
  position: fixed;
  width: 640px;
  min-height: 68%;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: var(--background-light);
  font-size: 1.1rem;
  color: var(--black);
  display: none;
  box-shadow: none;
  padding-top: 0;
}

.payment-pop-bank {
  width: 440px;
}

.payment-pop-bank .payment-pop-body {
  font-size: 1rem;
}

.payment-pop-bank .payment-pop-body span {
  font-size: 1rem;
  display: inline-block;
  margin-top: 12px;
}

.payment-info {
  padding-bottom: 16px;
  border-bottom: 1px solid #ccc;
}

.payment-pop-head {
  display: flex;
  align-items: center;
  padding: 20px 0;
  border-bottom: 1px solid #ccc;
  padding: 0 -16px;
  margin: 0 -20px;
  margin-bottom: 30px;
}

.payment-pop-head img,
.payment-item img {
  margin-right: 20px;
}

.payment-pop-head h3,
.payment-pop-body h3 {
  font-size: 18px;
  margin: 0;
  font-weight: 600;
}

.qr-code-momo {
  border-radius: var(--border-radius-main);
  background-color: #ccc;
  padding: 12px;
}

.total-price {
  margin-top: 8px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 1rem;
  font-weight: 600;
}

.payment-end-time {
  background: linear-gradient(to right, #6d2fff, #6f42c1);
  padding: 16px;
  border-radius: var(--border-color-grey);
  border-radius: 4px;
  text-align: center;
  color: #fff;
  margin-top: 8px;
}

.payment-end-time span {
  display: inline-block;
  padding: 6px;
  background: #fff;
  color: #000;
  border-radius: var(--border-radius-main);
  font-weight: 600;
}

.payment-end-time .seperate {
  background: none;
  color: #fff;
}

.info-user-payment {
  padding: 16px;
  border: 1px solid #d5d5d5;
  border-radius: var(--border-radius-main);
  background-color: var(--background-light);
  box-shadow: 0 1px 3px 0 rgb(0 0 0 / 6%), 0 1px 2px 0 rgb(0 0 0 / 4%);
  transition: 0.3s;
  font-size: 1rem;
}
</style>
