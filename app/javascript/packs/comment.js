const { default: axios } = require("axios");
var jQuery = require('jquery')
// global.$ = global.jQuery = jQuery;
// window.$ = window.jQuery = jQuery;
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()

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
})