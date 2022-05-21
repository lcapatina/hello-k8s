import Vue from 'vue';
import VueRouter from 'vue-router';
import PingPong from '../components/PingPong.vue';
import AllBooks from '../components/AllBooks.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/ping',
    name: 'PingPong',
    component: PingPong,
  },
  {
    path: '/',
    name: 'Books',
    component: AllBooks,
  },
];

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes,
});

export default router;
