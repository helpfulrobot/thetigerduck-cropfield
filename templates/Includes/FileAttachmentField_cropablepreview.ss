<div class="$CSSSize">
	<input type="hidden" id="Form_{$Name}From_posX" class="numeric text hidden" name="{$Name}[posX]" value="$posX">
	<input type="hidden" id="Form_{$Name}From_posY" class="numeric text hidden" name="{$Name}[posY]" value="$posY">
	<input type="hidden" id="Form_{$Name}From_width" class="numeric text hidden" name="{$Name}[width]" value="$width">
	<input type="hidden" id="Form_{$Name}From_height" class="numeric text hidden" name="{$Name}[height]" value="$height">
	<img id="cropArea" data-dz-thumbnail>
	<span class="file-progress-holder">
		<span class="file-progress-wrap">
			<span class="file-progress" data-dz-uploadprogress></span>
		</span>
	</span>
	<!-- 
	<span class="dropzone-actions">
		<span data-dz-remove data-detach class="dropzone-action detach">
			<img src="$DropzoneDir/images/remove.png" width="16">
		</span>
	</span>
	<span class="check-holder">
		<img src="$DropzoneDir/images/check.png" width="16" class="check">
	</span>
	<span class="overlay error-overlay">
		<span>
			<h5><%t Dropzone.ERROR 'Oh no!' %></h5>
			<small data-dz-errormessage></small>
			<span data-dz-remove class="revert"><img src="$DropzoneDir/images/undo_white.png" width="16"></span>
		</span>
	</span>
	 -->
</div>