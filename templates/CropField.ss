<h2>JCrop</h2>

<img id="cropArea" src="$Original.URL" />

<script src="cropfield/js/jquery.min.js"></script>
<script src="cropfield/js/jquery.Jcrop.js"></script>
<script type="text/javascript">

jQuery(function($){

	var jcrop_api;

	$('#cropArea').Jcrop({
		onChange:   setCoords,
		onSelect:   setCoords,
		onRelease:  clearCoords
	},function(){
		jcrop_api = this;
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
	
	$('#UserRegistration_RegistrationForm_posX').val(offsetX);
	$('#UserRegistration_RegistrationForm_posY').val(offsetY);
	$('#UserRegistration_RegistrationForm_width').val(offsetW);
	$('#UserRegistration_RegistrationForm_height').val(offsetH);
};

function clearCoords() {
	$('#cropArea input[type="hidden"]').val('');
};
</script>
<link rel="stylesheet" href="cropfield/css/jquery.Jcrop.css" type="text/css" />