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
  currentSukipi: {
    name: '',
    suki: '',
    sukipi_id: ''
  },
  user_skickers: [],
  currentSkicker: {
    name: '',
    power: ''
  }
})

export const getters = {
  user: state => {
    return state.user
  },
  sukipis: state => {
    return state.sukipis
  },
  user_skickers: state => {
    return state.user_skickers
  },
  currentSkicker: state => {
    return state.currentSkicker
  },
  currentSukipi: state => {
    return state.currentSukipi
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
        const users_skickers_data = await axios.get(`skicker_users?uid=${user.uid}`)
        commit('setUserSkickers', users_skickers_data.data.value)
        commit('setCurrentSkicker', {
          name: users_skickers_data.data.value[0].name,
          power: users_skickers_data.data.value[0].power
        })
        const currentSukipi = sukipis_data.data.value[0]
        console.log('currentSukipi', currentSukipi)
        commit('setCurrentSukipi', {
          name: currentSukipi.name,
          suki: currentSukipi.suki,
          sukipi_id: currentSukipi.id
        })
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
  setCurrentSukipi(state, payload) {
    state.currentSukipi.name = payload.name
    state.currentSukipi.suki = payload.suki
    state.currentSukipi.sukipi_id = payload.sukipi_id
  },
  setUserSkickers(state, payload) {
    state.user_skickers = payload
  },
  setCurrentSkicker(state, payload) {
    state.currentSkicker.name = payload.name
    state.currentSkicker.power = payload.power
  }
}
