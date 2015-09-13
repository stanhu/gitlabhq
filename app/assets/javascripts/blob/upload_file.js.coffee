Dropzone.options.blobFileDropzone = false;

$(document).on "page:load", ->
      $("#blobFileDropzone").dropzone()

Dropzone.options.blobFileDropzone = {
  autoProcessQueue: false,
  clickable: true,
  uploadMultiple: false,
  paramName: "file",
  parallelUploads: 1,
  maxFiles: 1,
  addRemoveLinks: true,
  previewsContainer: '.dropzone-previews',
  headers:
        "X-CSRF-Token": $("meta[name=\"csrf-token\"]").attr("content"),

  init: ->
    submitButton = document.querySelector('#submit-all')
    blobFileDropzone = this
    blobFileDropzone.options.maxFilesize = gon.max_file_size or 10
    submitButton.addEventListener 'click', (e)->
      e.preventDefault()
      e.stopPropagation()
      alert "Please select a file" if blobFileDropzone.getQueuedFiles().length == 0
      blobFileDropzone.processQueue()
      return
    @on 'success', (file, response)->
      window.location.href = response.filePath
      return
    @on 'maxfilesexceeded', (file) ->
      @removeFile file
      return
};
