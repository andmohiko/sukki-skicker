import firebase from '~/plugins/firebase'
import axios from "@/plugins/axios"

export const state = () => ({
  user: {
    user_id: '',
    uid: '',
    username: '',
    profileIcon: '',
    login: false,
  },
  sukipis: [],
  sukipi: {
    name: '',
    suki: '',
    sukipi_id: ''
  }
})

export const getters = {
  user: state => {
    return state.user
  },
  sukipis: state => {
    return state.sukipis
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
        const user_data = await axios.get(`/users?uid=${user.uid}`)
        commit('setUser', {
          user_id: user_data.data.value.id,
          uid: user.uid,
          username: user.displayName,
          profileIcon: user.photoURL
        })
        commit('switchLogin')
        const sukipis_data = await axios.get(`/sukipis?uid=${user.uid}`)
        commit('setSukipis', sukipis_data.data.value)
      }
    })
  },
}

export const mutations = {
  setUser(state, payload) {
    state.user.user_id = payload.user_id
    state.user.uid = payload.uid
    state.user.username = payload.username
    state.user.profileIcon = payload.profileIcon
  },
  switchLogin(state) {
    state.user.login = true
  },
  setSukipis(state, payload) {
    state.sukipis = payload
  },
  setSukipi(state, payload) {
    state.sukipi.name = payload.name
    state.sukipi.suki = payload.suki
    state.sukipi.sukipi_id = payload.sukipi_id
  }
}
