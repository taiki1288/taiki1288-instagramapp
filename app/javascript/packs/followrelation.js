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
        const hasFollowed = response.data.hasFollowed
        const followerCount = response.data.followerCounts
        const followingCount = response.data.followingCounts
        $('#follower_count').text(followerCount)
        $('#following_count').text(followingCount)
        followDisplay(hasFollowed)
    })

    $('.follow-btn').on('click', () => {
        axios.post(`/accounts/${accountId}/follows`)
        .then((response) => {
        const followerCount = response.data.followerCounts
        const followingCount = response.data.followingCounts
            if (response.data.status === 'ok') {
                $('.unfollow-btn').removeClass('hidden')
                $('.follow-btn').addClass('hidden')
                $('#follower_count').text(followerCount)
                $('#following_count').text(followingCount)
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
        const followerCount = response.data.followerCounts
        const followingCount = response.data.followingCounts
            if (response.data.status === 'ok') {
                $('.unfollow-btn').addClass('hidden')
                $('.follow-btn').removeClass('hidden')
                $('#follower_count').text(followerCount)
                $('#following_count').text(followingCount)
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
})