<?php 
class CropableImage extends DataExtension
{
	public function CroppedFromPos($width, $height, $posX, $posY){
		return $this->owner->getFormattedImage('CroppedFromPos', $width, $height, $posX, $posY);
	}

	public function generateCroppedFromPos($gd, $width, $height, $posX, $posY){
		Debug::log("CAI: x: {$posX} y: {$posY} w: {$width} h: {$height}");
		//$temp = $gd->resizeByHeight($height);
		return $gd->crop($posY, $posX,$width,$height);
	}
}