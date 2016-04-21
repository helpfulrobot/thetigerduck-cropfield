<div id="$Name" class="field<% if $extraClass %> $extraClass<% end_if %> supported">
	<% if $Title %><label class="left" for="$ID">$Title</label><% end_if %>
	<div id="{$Name}Dropzone" class="dropzone-holder <% if $isCMS %>backend<% end_if %> <% if $CanUpload %>uploadable<% end_if %>" data-config='$ConfigJSON'>
		<p>
			<%t Dropzone.ATTACHFILEHERE_OR "Attach a file by dropping it in here." %>

			<% if $CanUpload && $CanAttach %><br><% end_if %>
			<% if $CanUpload || $CanAttach %>
				<% if $CanUpload %><%t Dropzone.YOUCANALSO "You can also" %> <% end_if %>
				<% if $CanUpload %>[<a class="dropzone-select"><%t Dropzone.BROWSEYOURCOMPUTER "browse your computer" %></a>]<% end_if %>
			<% end_if %>

		</p>
		<!-- 
		<ul data-container data-attachments class="file-attachment-field-previews $View">
			<% if $AttachedFiles %>
				<% loop $AttachedFiles %>
					<% include FileAttachmentField_attachments File=$Me, Scope=$Up %>
				<% end_loop %>
			<% end_if %>
		</ul>
 		-->


		<template>
			$PreviewTemplate
		</template>
		<div class="attached-file-inputs" data-input-name="$InputName">
			<% if $AttachedFiles %>
				<% loop $AttachedFiles %>
				<input class="input-attached-file" type="hidden" name="$Up.InputName" value="$ID">
				<% end_loop %>
			<% end_if %>
		</div>
		<!-- _<div class="attached-file-deletions" data-input-name="$InputName"></div> -->
		<div style="clear:both;"></div>

		<% if not $AutoProcess %>
			<button class="process" data-auto-process><%t Dropzone.UPLOADFILES "Upload file(s)" %></button>
		<% end_if %>

	</div>

	<div class="unsupported">
		<p><strong><%t Dropzone.NOTSUPPORTED "Your browser does not support HTML5 uploads. Please update to a newer version." %></strong></p>
	</div>

</div>

<script src="cropfield/js/jquery.min.js"></script>
<script src="cropfield/js/jquery.Jcrop.js"></script>

<script type="text/javascript">

jQuery(function($){

	var boxWidth = $box_width;
	var boxHeight = $box_height;
	if(boxWidth == 0){
		boxWidth = $('#{$Name}Dropzone').width();
		boxHeight = 0;
	}
	
	var jcrop_api;
	$('#{$Name}Dropzone').data('dropzoneInterface').backend.on('addedfile',function(){
		if (this.files[1]!=null){
			this.removeFile(this.files[0]);
		}
	});
	$('#{$Name}Dropzone').data('dropzoneInterface').backend.on('complete',function(){
		
		
		var pic_real_width = document.querySelector('#cropArea').naturalWidth;
		var pic_real_height = document.querySelector('#cropArea').naturalHeight;
		if(pic_real_width < $min_width || pic_real_height < $min_height){
			$('#{$Name}Dropzone').data('dropzoneInterface').clear();
			alert("Uploaded Image is too Small. must have at least {$min_width}x{$min_height}px");
		}
		/*
		$('.dropzone-select').click(function(){
			$('#{$Name}Dropzone').data('dropzoneInterface').clear();
		});
		/*
		$('#{$Name}Dropzone').data('dropzoneInterface').backend.on('drop',function(){
			$('#{$Name}Dropzone').data('dropzoneInterface').clear();
		});*/
		
		$('#cropArea').css("width","auto");
		$('.jcrop-holder').css("width","100%");
		$('#cropArea').Jcrop({
			onChange:   setCoords,
			onSelect:   setCoords,
			onRelease:  clearCoords,
			setSelect:   [ 0, 0, $width, $height ],
			minSize:  [$min_width, $min_height],
			maxSize: [$max_width, $max_height],
			boxWidth: boxWidth,
			boxHeight: boxHeight,
			<% if aspect %>aspectRatio: $aspect<% end_if %>
		},function(){
			jcrop_api = this;
		})
	});
});

// Simple event handler, called from onChange and onSelect
// event handlers, as per the Jcrop invocation above
function setCoords(c) {
	
	var pic_real_width = document.querySelector('#cropArea').naturalWidth;
	var pic_real_height = document.querySelector('#cropArea').naturalHeight;
	
	var offsetX = Math.round(c.x * (pic_real_width / $('#cropArea').width()));
	var offsetY = Math.round(c.y * (pic_real_height / $('#cropArea').height()));
	var offsetW = Math.round(c.w * (pic_real_width / $('#cropArea').width()));
	var offsetH = Math.round(c.h * (pic_real_height / $('#cropArea').height()));
	
	$('#Form_ImageFrom_posX').val(offsetX);
	$('#Form_ImageFrom_posY').val(offsetY);
	$('#Form_ImageFrom_width').val(offsetW);
	$('#Form_ImageFrom_height').val(offsetH);
};

function clearCoords() {
	$('#cropArea input[type="hidden"]').val('');
};
</script>
<link rel="stylesheet" href="cropfield/css/jquery.Jcrop.css" type="text/css" />
<link rel="stylesheet" href="cropfield/css/jquery.Jcrop.css" type="text/css" />
<link rel="stylesheet" href="cropfield/css/dropzone_alter.css" type="text/css" />