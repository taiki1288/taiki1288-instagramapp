const { default: axios } = require("axios");
var jQuery = require('jquery')
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()

const appendNewProfile = (profile) => {
    $('.profilePage_user_image').append(
        `<img class="avatar-image" src="${profile.user.comment_avatar_image}">
         <div id="profile-content">
           <div class="profilePage_user_image_box">
             <div class="profilePage_user_image_box_item">
               <form id="profile_form" enctype="multipart/form-data" action="/profile" accept-charset="UTF-8" data-remote="true" method="post">
                 <input type="hidden" name="_method" value="put">
                 <input type="hidden" name="authenticity_token" value="5FNHgE60Ii/aOQpjN6K0GRj5Mc+tmMDquFNucbsgyf0JiWuLst+d9+6uhhoVUaBISZAuq6aU49V491H8TnUXjg==">
                 <div>
                   <label class="form-title" for="profile_avatar">image</label>
                 </div>
                 <div>
                   <input class="form-avatar" type="file" name="profile[avatar]" id="profile_avatar">
                 </div>
                 <div id="profile_submit">
                   <input type="submit" name="commit" value="Submit" class="modal-btn-primary" data-disable-with="Submit">
                 </div>
               </form>
               <button id="profile-content-close">Cancel</button>
             </div>
           </div>
         </div>`
    )
}

document.addEventListener('DOMContentLoaded', () => {
    axios.get(`/api/profile`)
       .then((response) => {
           const profile = response.data
           appendNewProfile(profile)
           $(function(){
            $('.avatar-image').on('click', function(){
                $('#profile-content').fadeIn();
            });
            $('.modal-btn-primary').on('click', function(){
                $('#profile-content').fadeOut();
            });
            $('#profile-content-close').on('click', function(){
                $('#profile-content').fadeOut();
            });

          });
       })
});

window.addEventListener('load', () => {
    const uploader = document.querySelector('.form-avatar');
    $(uploader).on('change', (e) => {
        const file = uploader.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = () => {
            const image = reader.result;
            document.querySelector('.avatar-image').setAttribute('src', image);
        }
    });
});
