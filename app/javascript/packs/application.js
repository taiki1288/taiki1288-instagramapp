// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

const { default: axios } = require("axios");
var jQuery = require('jquery')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// import $ from 'jquery'
// import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()

$(function() {
    $('.slick').slick({
        dots: true,
    });
});

// const handleHeartDisplay = (hasLiked) => {
//   if (hasLiked) {
//     $('.active-heart').removeClass('hidden')
//   } else {
//     $('.inactive-heart').removeClass('hidden')
//   }
// }

const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class='comment-card'>
      <div class='comment-user-image'>
        <img src="${comment.user.comment_avatar_image}">
      </div>
      <div class="user-status">
        <div class="comment-user-name">
          <p>${comment.user.account}</p>
        </div>
        <div class="timeline_comment">
          <p>${comment.content}</p>
        </div>
      </div>
     </div>`      
  )
}

document.addEventListener('DOMContentLoaded', () => {
    $('.timeline-card').each(function(){
      console.log($(this).data('timeline-id'));
      const timelineId = $(this).data('timeline-id');
        const handleHeartDisplay = (hasLiked) => {
          if (hasLiked) {
            $(`#${timelineId}.active-heart`).removeClass('hidden')
          } else {
            $(`#${timelineId}.inactive-heart`).removeClass('hidden')
          }
        }

        axios.get(`/api/timelines/${timelineId}/like`)
        .then((response) => {
          const hasLiked = response.data.hasLiked
          handleHeartDisplay(hasLiked)
        })
    });

    const timelineId = $('.comments-container').attr('id')
    axios.get(`/api/timelines/${timelineId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        appendNewComment(comment)
      })
    })

    $('.create-comment-btn').on('click', () => {
      const content = $('#comment_content').val()
      if (!content) {
        window.alert('コメントを入力してください')
      } else {
        axios.post(`/api/timelines/${timelineId}/comments`, {
          comment: {content: content}
        })
          .then((res) => {
            const comment = res.data
            appendNewComment(comment)
            $('#comment_content').val('')
          })
      }
    })

    $('.inactive-heart').on('click', (e) => {
      e.preventDefault();
      const timelineId = $(e.currentTarget).attr('id');
      console.log(timelineId);
        axios.post(`/api/timelines/${timelineId}/like`)
          .then((response) => {
            if (response.data.status === 'ok') {
              $(`#${timelineId}.active-heart`).removeClass('hidden')
              $(`#${timelineId}.inactive-heart`).addClass('hidden')
            }
          })
          .catch((e) => {
              window.alert('error')
              console.log(e)
          })
    })

    $('.active-heart').on('click', (e) => {
      e.preventDefault();
      const timelineId = $(e.currentTarget).attr('id');
      console.log(timelineId);
        axios.delete(`/api/timelines/${timelineId}/like`)
        .then((response) => {
          if (response.data.status === 'ok') {
            $(`#${timelineId}.active-heart`).addClass('hidden')
            $(`#${timelineId}.inactive-heart`).removeClass('hidden')
          }    
        })
        .catch((e) => {
            window.alert('error')
            console.log(e)
        })
    })
})