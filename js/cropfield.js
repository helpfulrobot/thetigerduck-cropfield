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
		//boxHeight = 0;
	}
	
	var jcrop_api;
	$('#Dropzone').data('dropzoneInterface').backend.on('addedfile',function(){
		$('#oldImagePrev').remove();
		if (this.files[1]!=null){
			this.removeFile(this.files[0]);
		}
	});
	$('#Dropzone').data('dropzoneInterface').backend.on('error',function(errorMessage ){
		console.log("errorMessage : "+errorMessage);
	});
	$('#Dropzone').data('dropzoneInterface').backend.on('thumbnail',function(dataUrl){
		var pic_real_width = dataUrl.width;
		var pic_real_height = dataUrl.height;
		//console.log("realW: "+pic_real_width+" realH: "+pic_real_height);
		if(pic_real_width < minWidth || pic_real_height < minHeight){
			$('#Dropzone').data('dropzoneInterface').clear();
			alert("Uploaded Image is too Small. must have at least "+minWidth+"x"+minHeight+"px");
		}
		//var boxHeight = boxWidth/pic_real_width*pic_real_height;
		//boxHeight = boxWidth/pic_real_width*pic_real_height;
		if(pic_real_width > pic_real_height){
			var offsetX = (pic_real_width/2) - (pic_real_height/2);
			var offsetY = 0;
		} else{
			var offsetX = 0;
			var offsetY = (pic_real_height/2) - (pic_real_width/2);;
		}
		$('#cropArea').css("width","auto");
		$('.jcrop-holder').css("width","100%");
		$('#cropArea').Jcrop({
			onChange:   setCoords,
			onSelect:   setCoords,
			onRelease:  clearCoords,
			setSelect:   [ offsetX, offsetY, pic_real_width, pic_real_height],
			minSize:  [minWidth, minHeight],
			maxSize: [maxWidth, maxHeight],
			boxWidth: boxWidth,
			boxHeight: boxHeight,
			aspectRatio: aspect
		},function(){
			jcrop_api = this;
		})
		//console.log("bw: "+boxWidth+" bh: "+boxHeight);
	});
});

// Simple event handler, called from onChange and onSelect
// event handlers, as per the Jcrop invocation above
function setCoords(c) {
	
	var fieldname = $('#Dropzone').data('fieldname');
	var pic_real_width = document.querySelector('#cropArea').naturalWidth;
	var pic_real_height = document.querySelector('#cropArea').naturalHeight;
	
	var offsetX = Math.round(c.x * (pic_real_width / $('#cropArea').width()));
	var offsetY = Math.round(c.y * (pic_real_height / $('#cropArea').height()));
	var offsetW = Math.round(c.w * (pic_real_width / $('#cropArea').width()));
	var offsetH = Math.round(c.h * (pic_real_height / $('#cropArea').height()));
	
	$('#Form_'+fieldname+'From_posX').val(offsetX);
	$('#Form_'+fieldname+'From_posY').val(offsetY);
	$('#Form_'+fieldname+'From_width').val(offsetW);
	$('#Form_'+fieldname+'From_height').val(offsetH);
};

function clearCoords() {
	$('#cropArea input[type="hidden"]').val('');
};