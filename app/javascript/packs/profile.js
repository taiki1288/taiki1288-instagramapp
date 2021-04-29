const { default: axios } = require("axios");
var jQuery = require('jquery')
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()

document.addEventListener('DOMContentLoaded', () => {
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
