import firebase from '~/plugins/firebase'
import axios from "@/plugins/axios"

export const state = () => ({
  user: {
    uid: '',
    username: '',
    profileIcon: '',
    login: false,
  },
  skickers: [],
  sukkis: [],
  sukipi: {
    name: '',
    skicker_id: '',
    suki: '',
  }
})

export const getters = {
  user: state => {
    return state.user
  },
  skickers: state => {
    return state.skickers
  },
  sukkis: state => {
    return state.sukkis
  }
}

export const actions = {
  loginTwitter ({ dispatch }) {
    var provider = new firebase.auth.TwitterAuthProvider()
    firebase.auth().signInWithPopup(provider).then(result => {
      dispatch('checkLogin')
      console.log(result)
    }).catch(function (error) {
      console.log(error)
    })
  },
  checkLogin ({ commit }) {
    firebase.auth().onAuthStateChanged(async user => {
      if (user) {
        try {
          const user_data = await axios.get(`/users?uid=${user.uid}`)
          console.log('user', user_data.data)
          if (!user_data.data.value) {
            const new_user = {
              username: user.displayName,
              uid: user.uid
            }
            console.log('pls create new user', new_user.username)
            axios.post("/users", new_user)
            console.log('user created')
          }
        } catch (e) {
          console.log('error in check login')
          console.error(e)
        }
        commit('setUser', {
          uid: user.uid,
          username: user.displayName,
          profileIcon: user.photoURL
        })
        commit('switchLogin')
        const skickers_data = await axios.get(`/skickers?uid=${user.uid}`)
        commit('setSkickers', skickers_data.data.value)
        const sukkis_data = await axios.get(`/sukkis?uid=${user.uid}`)
        commit('setSukkis', sukkis_data.data.value)
      }
    })
  },
}

export const mutations = {
  setUser (state, payload) {
    state.user.uid = payload.uid
    state.user.username = payload.username
    state.user.profileIcon = payload.profileIcon
  },
  switchLogin (state) {
    state.user.login = true
  },
  setSkickers (state, payload) {
    state.skickers = payload
  },
  setSukkis (state, payload) {
    state.sukkis = payload
  },
  setSukipi (state, payload) {
    state.sukipi.name = payload.name
    state.sukipi.skicker_id = payload.skicker_id
    state.sukipi.suki = payload.suki
  }
}
