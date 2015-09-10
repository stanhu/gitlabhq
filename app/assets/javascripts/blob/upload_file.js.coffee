Dropzone.options.blobFileDropzone = false;

$(document).on "page:load", ->
      $("#blobFileDropzone").dropzone()

Dropzone.options.blobFileDropzone = {
  autoProcessQueue: false,
  clickable: true,
  uploadMultiple: false,
  paramName: "file",
  maxFilesize: 10,
  parallelUploads: 1,
  maxFiles: 1,
  addRemoveLinks: true,
  previewsContainer: '.dropzone-previews',
  headers:
        "X-CSRF-Token": $("meta[name=\"csrf-token\"]").attr("content"),
  
  init: -> 
    submitButton = document.querySelector('#submit-all')
    blobFileDropzone = this
    submitButton.addEventListener 'click', (e)->
      e.preventDefault()
      e.stopPropagation()
      blobFileDropzone.processQueue()
      return
    @on 'success', (file, response)->
      window.location.href = response.filePath
      return
};