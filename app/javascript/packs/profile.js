import $ from 'jquery'
import axios from 'axios'

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