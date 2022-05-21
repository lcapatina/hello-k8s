<template>
  <div class="container">
    <button type="button" class="btn btn-primary">{{ msg }}</button>
  </div>
</template>

<script>

import axios from 'axios';
import config from '@/config';

export default {
  name: 'ping-pong',
  data() {
    return {
      msg: 'Hello!',
    };
  },
  methods: {
    getMessage() {
      const displayURL = config.VUE_APP_ENV_BACKEND;
      console.log(displayURL);
      const path = 'http://localhost:5000/ping';
      axios.get(path)
        .then((res) => {
          this.msg = res.data;
        })
        .catch((err) => {
          console.error(err);
        });
    },
  },
  created() {
    this.getMessage();
  },
};
</script>
