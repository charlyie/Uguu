<form id="upload-form" enctype="multipart/form-data" method="post" action="upload.php?output=html">
	<button id="upload-btn" class="btn" type="button">Select or drop your files in this zone</button>
	<input type="file" id="upload-input" name="files[]" multiple data-max-size="{{max_upload_size}}MiB">
	<input type="submit" value="Submit">
</form> 
<ul id="upload-filelist"></ul>
