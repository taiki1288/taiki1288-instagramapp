const { default: axios } = require("axios");
var jQuery = require('jquery')
// global.$ = global.jQuery = jQuery;
// window.$ = window.jQuery = jQuery;
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()

const followDisplay = (hasFollowed) => {
  if (hasFollowed) {
    $('.unfollow-btn').removeClass('hidden')
  } else {
    $('.follow-btn').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#account-show').data()
    const accountId = dataset.accountId
    const followId = dataset.followingId

    axios.get(`/accounts/${accountId}/follows/${followId}`)
      .then((response) => {
        // debugger
        const hasFollowed = response.data.hasFollowed
        followDisplay(hasFollowed)
    })

    $('.follow-btn').on('click', () => {
        axios.post(`/accounts/${accountId}/follows`)
        .then((response) => {
            if (response.data.status === 'ok') {
                $('.unfollow-btn').removeClass('hidden')
                $('.follow-btn').addClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })

    $('.unfollow-btn').on('click', () => {
        axios.post(`/accounts/${accountId}/unfollows`)
        .then((response) => {
            if (response.data.status === 'ok') {
                $('.unfollow-btn').addClass('hidden')
                $('.follow-btn').removeClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
})