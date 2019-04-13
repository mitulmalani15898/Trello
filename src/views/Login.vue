<template>
  <v-app>
    <v-content>
      <v-container fluid>
        <v-layout justify-center>
          <v-flex xs12 sm6 md4 lg3 xl4 class="box">
            <p style="font-size:38px; font-weight:bold;">Log in to Trello</p>
            <span style="font-size:18px;">
              or
              <router-link to="signup" style="text-decoration: underline;">create an account</router-link>
            </span>
            <div style="margin-top:21px;">
              <center>
                <div
                  v-if="authError"
                  style="color:red; font-size:15px; margin-bottom:10px;"
                >{{authError}}</div>
              </center>
              <v-form ref="form" v-model="valid">
                <v-flex>
                  <v-text-field
                    label="Email (or username )"
                    v-model="email"
                    :rules="emailRules"
                    outline
                  ></v-text-field>
                </v-flex>
                <v-text-field
                  :append-icon="show ? 'visibility' : 'visibility_off'"
                  label="Password"
                  :type="show ? 'text' : 'password'"
                  v-model="password"
                  :rules="passwordRules"
                  @click:append="show = !show"
                  outline
                ></v-text-field>
              </v-form>
            </div>
            <input class="btn" type="submit" @click.prevent="logIn" value="Log In">
            <div class="btn1">
              <span>
                <img src="../../public/google.jpg">
              </span>&nbsp;&nbsp;
              <label>Log in with Google</label>
            </div>
            <div style="margin-top:40px; font-size:18px;">
              <router-link to style="text-decoration: underline;">Forgot your Password?</router-link>
            </div>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      show: false,
      valid: false,
      email: "",
      password: "",
      passwordRules: [
        v => !!v || "Password is required",
        v =>
          /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$/.test(v) ||
          "Password Must Contain at least 1 number and 1 special Character"
      ],
      emailRules: [
        v => !!v || "E-mail is required",
        v =>
          /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
          "E-mail must be valid"
      ]
    };
  },

  computed: {
    authError() {
      return this.$store.state.authError;
    }
  },

  methods: {
    logIn() {
      if (this.$refs.form.validate()) {
        let loginData = {
          email: this.email,
          password: this.password
        };
        // console.log(loginData)
        this.$store.dispatch("login", loginData);
        this.$refs.form.reset();
      }
    }
  }
};
</script>


<style>
.box {
  margin-top: 50px;
}
.btn {
  height: 50px;
  width: 100%;
  color: white;
  background: #61bd4f;
  border: 2px solid #61bd4f;
  border-radius: 5px;
  padding: 5px;
  font-size: 18px;
  cursor: pointer;
}
.btn1 {
  height: 50px;
  width: 100%;
  text-align: center;
  color: #696969;
  background: white;
  border: 2px solid #696969;
  border-radius: 5px;
  padding: 5px;
  font-size: 18px;
  margin-top: 15px;
  cursor: pointer;
}
</style>
