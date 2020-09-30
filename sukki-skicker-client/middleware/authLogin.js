export default function({ store, redirect }) {
  try {
    const isLogin = store.state.user.login
    if (!isLogin) return redirect('/login')
  } catch (error) {
    redirect('/login')
  }
}
