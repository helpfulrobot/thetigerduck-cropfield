<div id="$Name" class="field<% if $extraClass %> $extraClass<% end_if %> supported">
	<% if $Title %><label class="left" for="$ID">$Title</label><% end_if %>
	<div id="Dropzone" class="dropzone-holder <% if $isCMS %>backend<% end_if %> <% if $CanUpload %>uploadable<% end_if %>" data-config='$ConfigJSON' data-width="$width" data-height="$height" data-boxwidth="$box_width" data-boxheight="$box_height" data-minwidth="$min_width" data-minheight="$min_height" data-maxwidth="$max_width" data-maxheight="$max_height" data-aspect="$aspect">
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