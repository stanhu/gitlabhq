class @BlobFileDropzone
  constructor: (form_dropzone) ->
    Dropzone.autoDiscover = false
    dropzone = form_dropzone.dropzone(
      autoDiscover: false
      autoProcessQueue: false
      clickable: true
      uploadMultiple: false
      paramName: "file"
      maxFilesize: gon.max_file_size or 10
      parallelUploads: 1
      maxFiles: 1
      addRemoveLinks: true
      previewsContainer: '.dropzone-previews'
      headers:
        "X-CSRF-Token": $("meta[name=\"csrf-token\"]").attr("content")

      success: (header, response) ->
        window.location.href = response.filePath
        return

      error: (temp, errorMessage) ->
        stripped = $("<div/>").html(errorMessage).text();
        $('.dropzone-alerts').html('Error uploading file: \"' + stripped + '\"').show()
        return

      maxfilesexceeded: (file) ->
        @removeFile file
        return

      removedfile: (file) ->
        $('.dropzone-previews')[0].removeChild(file.previewTemplate)
        $('.dropzone-alerts').html('').hide()
        return true

      sending: (file, xhr, formData) ->
        formData.append('commit_message', document.querySelector('#commit_message_replace').value)
        return
    )

    submitButton = document.querySelector('#submit-all')
    submitButton.addEventListener 'click', (e) ->
      e.preventDefault()
      e.stopPropagation()
      alert "Please select a file" if dropzone[0].dropzone.getQueuedFiles().length == 0
      dropzone[0].dropzone.processQueue()
      return false
