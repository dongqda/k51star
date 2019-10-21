import Vue from 'vue'
import App from './App.vue'
import '@babel/polyfill'
import 'mutationobserver-shim'
import './plugins/bootstrap-vue'
import axios from 'axios'
import router from './router'

Vue.config.productionTip = false
Vue.prototype.$http = axios
new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
