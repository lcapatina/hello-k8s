import BootstrapVue from 'bootstrap-vue';
import Vue from 'vue';
import config from './config';
import App from './App.vue';
import router from './router';
import 'bootstrap/dist/css/bootstrap.css';

Vue.use(BootstrapVue);

Vue.config.productionTip = false;

Vue.prototype.appConfig = config;

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');
