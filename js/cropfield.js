jQuery().ready(function($){

	var boxWidth = $('#Dropzone').data('boxwidth');
	var boxHeight = $('#Dropzone').data('boxheight');
	var width = $('#Dropzone').data('width');
	var height = $('#Dropzone').data('height');
	var minWidth = $('#Dropzone').data('minwidth');
	var minHeight = $('#Dropzone').data('minheight');
	var maxWidth = $('#Dropzone').data('maxwidth');
	var maxHeight = $('#Dropzone').data('maxheight');
	var aspect = $('#Dropzone').data('aspect');
	
	if(boxWidth == 0){
		boxWidth = $('#Dropzone').width();
		boxHeight = 0;
	}
	
	var jcrop_api;
	$('#Dropzone').data('dropzoneInterface').backend.on('addedfile',function(){
		if (this.files[1]!=null){
			this.removeFile(this.files[0]);
		}
	});
	console.log("boxwidth: "+boxWidth);
	$('#Dropzone').data('dropzoneInterface').backend.on('complete',function(){
		setTimeout(function(){
			var pic_real_width = document.querySelector('#cropArea').naturalWidth;
			var pic_real_height = document.querySelector('#cropArea').naturalHeight;
			//console.log("realW: "+pic_real_width+" realH: "+pic_real_height);
			if(pic_real_width < minWidth || pic_real_height < minHeight){
				$('#Dropzone').data('dropzoneInterface').clear();
				alert("Uploaded Image is too Small. must have at least "+minWidth+"x"+minHeight+"px");
			}
			//var boxHeight = boxWidth/pic_real_width*pic_real_height;
			boxHeight = boxWidth/pic_real_width*pic_real_height;
			var offsetX = (pic_real_width/2) - (boxHeight);
			$('#cropArea').css("width","auto");
			$('.jcrop-holder').css("width","100%");
			$('#cropArea').Jcrop({
				onChange:   setCoords,
				onSelect:   setCoords,
				onRelease:  clearCoords,
				setSelect:   [ offsetX, 0, pic_real_width, pic_real_height],
				minSize:  [minWidth, minHeight],
				maxSize: [maxWidth, maxHeight],
				boxWidth: boxWidth,
				boxHeight: boxHeight,
				aspectRatio: aspect
			},function(){
				jcrop_api = this;
			})
		},500);
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