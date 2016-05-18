<?php 
class CropableImage extends DataExtension{
	public function CroppedFromPos($width, $height, $posX, $posY){
		//Debug::log("CroppedFromPos: x: {$posX} y: {$posY} w: {$width} h: {$height}");
		return $this->owner->getFormattedImage('CroppedFromPos', $width, $height, $posX, $posY);
	}

	public function generateCroppedFromPos($gd, $width, $height, $posX, $posY){
		//Debug::log("CAI: x: {$posX} y: {$posY} w: {$width} h: {$height}");
		return $gd->crop($posY, $posX,$width,$height);
	}
}