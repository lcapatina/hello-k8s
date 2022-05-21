<template>
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <h1>Books</h1>
        <hr><br><br>
        <b-button @click="showModal" class="bton btn-success">Add Book</b-button>
        <br><br>
        <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">Title</th>
              <th scope="col">Author</th>
              <th scope="col">Read?</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="book in books" :key="book.id">
              <td>{{book.title}}</td>
              <td>{{book.author}}</td>
              <td>
                <span v-if="book.read">Yes</span>
                <span v-else>No</span>
              </td>
              <td>
                <div class="btn-group" role="group">
                  <button type="button" class="btn btn-warning btn-sm">Update</button>
                  <button type="button" class="btn btn-danger btn-sm">Delete</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <b-modal ref="addBookModal" title="Add A New Book" hide-footer>
      <b-form @submit="onSubmit" @reset="onReset">
        <b-form-group id="input-group-title" label="Book title:" label-for="input-title">
          <b-form-input
            id="input-title"
            v-model="form.title"
            placeholder="Enter title"
            required
          >
          </b-form-input>
        </b-form-group>
        <b-form-group id="input-group-author" label="Book author:" label-for="input-author">
          <b-form-input
            id="input-auhtor"
            v-model="form.author"
            placeholder="Enter author"
            required
          >
          </b-form-input>
        </b-form-group>
        <b-form-group id="input-group-read" label="Book read ?" label-for="input-read">
          <b-form-checkbox
            id="input-read"
            v-model="form.read"
          >
            I confirm that I read the book
          </b-form-checkbox>
        </b-form-group>
        <b-button-group>
          <b-button type="submit" variant="primary">Submit</b-button>
          <b-button type="reset" variant="danger">Cancel</b-button>
        </b-button-group>
      </b-form>
  </b-modal>
  </div>
</template>

<script>

import axios from 'axios';

export default {
  name: 'ping-pong',
  data() {
    return {
      books: [],
      form: {
        title: '',
        author: '',
        read: false,
      },
    };
  },
  methods: {
    getBooks() {
      const displayURL = this.appConfig.VUE_APP_ENV_BACKEND;
      console.log(displayURL);
      const path = 'api/books';
      axios.get(path)
        .then((res) => {
          for (let i = 0; i < res.data.books.length; i += 1) {
            this.books.push(res.data.books[i]);
          }
        })
        .catch((err) => {
          console.error(err);
        });
    },
    initForm() {
      this.form.title = '';
      this.form.author = '';
    },
    showModal() {
      const displayURL = this.appConfig.VUE_APP_ENV_BACKEND;
      console.log(displayURL);
      this.$refs.addBookModal.show();
    },
    onSubmit(event) {
      event.preventDefault();
      console.log(this.form);
      const path = 'api/book';
      const payload = this.form;
      axios.post(path, payload)
        .then((res) => {
          if (res.data.status === 'success') {
            console.log('Book added');
            this.$refs.addBookModal.hide();
          } else {
            // handle the cases of existing title
            console.log('Server had a problem');
          }
        })
        .catch((err) => {
          console.log('An error occured');
          console.log(err);
        });
    },
    onReset() {
      this.$refs.addBookModal.hide();
      this.initForm();
    },
  },
  created() {
    this.getBooks();
  },
};
</script>
