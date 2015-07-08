// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.pjax
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap-select
//= require jquery.Jcrop
//= require dropzone
//= require main

// for close button in the notification message
//= require bootstrap

$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#new_picture").dropzone({
    // restrict image size to a maximum 1MB
    maxFilesize: 1,
    // changed the passed param to one accepted by
    // our rails app
    paramName: "picture[image]",
    // show remove links on each image upload
    addRemoveLinks: true,
    // if the upload was successful
    success: function(file, response){
      // find the remove button link of the uploaded file and give it an id
      // based of the fileID response from the server
      $(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
      // add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success");
    },
    //when the remove button is clicked
    removedfile: function(file){
      // grap the id of the uploaded file we set earlier
      var id = $(file.previewTemplate).find('.dz-remove').attr('id'); 

      // make a DELETE ajax request to delete the file
      $.ajax({
        type: 'DELETE',
        url: '/pictures/' + id,
        success: function(data){
          console.log(data.message);
        }
      });
    }
  }); 
});
