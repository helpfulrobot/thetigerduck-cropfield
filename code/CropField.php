<?php
/**
 * CropField creates a ImageUploadField,
 * allowing to select a CropArea in Frontend using Jcrop
 * 
 * @package  TheTigerDuck/silverstripe-cropfield
 * @author TheTigerDuck <janosch@spleen.de>
 *
 * <b>Usage</b>
 * 
 * <code>
 * 	function ImageFrom(){
 * 		$fields = new FieldList(
 * 			$cf = new CropField("Image", "Image")
 * 		);
 * 		$cf->setBoxWidth(600);
 * 		$cf->setBoxHeight(6000);
 * 		$cf->setMaxWidth(0);
 * 		$cf->setMaxHeight(0);
 * 		$cf->setAspectRatio(1);
 * 		$actions = new FieldList(
 * 			new FormAction("submit", "submit")
 * 		);
 * 		return new Form($this, "ImageFrom", $fields, $actions);
 * 	}
 * 	
 * 	function submit($data,$form){
 * 		$original = Image::get()->byID($data['Image']);
 * 		$cropped = $original->CroppedFromPos($data['Image_width'], $data['Image_height'], $data['Image_posX'], $data['Image_posY']);
 * 		//overwrite the Original Image by the Cropped one
 * 		copy(Director::baseFolder() . "/" . $cropped->Filename, Director::baseFolder() . "/" . $original->Filename);
 * 		$this->data()->ImageID = $original->ID;
 * 		$this->data()->write();
 * 		$this->redirectBack();
 * 	}
 * </code>
 * 
 * @package SS_CropField
 * @subpackage Form
 */
class CropField extends FileAttachmentField {
	
	
	protected $previewTemplate = 'FileAttachmentField_cropablepreview';
	protected $imageID = 0;
	/**
	 * @var int The X-Value of the Upper left corner
	 */
	protected $posX = 0;
	/**
	 * @var int The Y-Value of the Upper left corner
	 */
	protected $posY = 0;
	
	protected $width = 150;
	protected $height = 150;
	
	protected $min_width = 150;
	protected $min_height = 150;
	protected $max_width = 500;
	protected $max_height = 500;
	protected $box_width = 500;
	protected $box_height = 500;
	protected $aspect = 0;
	
	public function __construct($name, $title = null, $value = null, $form = null) {
		parent::__construct($name, $title, $value, $form);
		$this->relationAutoSetting = false;
		$this->setTemplate("CropField_holder")
			->setMultiple(false)
			->setThumbnailHeight(10000)
			->setThumbnailWidth(10000)
			->imagesOnly();
		/*
			->setPermissions(array(
				'delete' => false,
				'detach' => false));*/
	}
	
	public function IsMultiple() {
		return false;
	}
	
	public function Type() {
		return parent::Type() . ($this->readonly ? ' readonly' : '');
	}
	
	public function setPosX($posX) {
		$this->posX = $posX;
		return $this;
	}
	public function setPosY($posY) {
		$this->posY = $posY;
		return $this;
	}
	public function setWidth($width) {
		$this->width = $width;
		return $this;
	}
	public function setHeight($height) {
		$this->height = $height;
		return $this;
	}
	public function setMinWidth($width) {
		$this->min_width = $width;
		return $this;
	}
	public function setMinHeight($height) {
		$this->min_height = $height;
		return $this;
	}
	public function setMaxWidth($width) {
		$this->max_width = $width;
		return $this;
	}
	public function setMaxHeight($height) {
		$this->max_height = $height;
		return $this;
	}
	
	public function setBoxWidth($width) {
		$this->box_width = $width;
		return $this;
	}
	public function setBoxHeight($height) {
		$this->box_height = $height;
		return $this;
	}
	public function setAspectRatio($aspect) {
		$this->aspect = $aspect;
		return $this;
	}
	
	public function Original(){
		$img = Image::get()->byID($this->imageID);
		return $img;
	}
	
	public function Cropped(){
		$img = Image::get()->byID($this->imageID);
		return $img->getFormattedImage('CroppedImage', $this->width, $this->height, $this->posX, $this->posY);
	}
	/*
	public function Value() {
		//return $img = Image::get()->byID($this->imageID);
		return array(
			"orig" => $img,
			"new" => $img->getFormattedImage('CroppedImage', $this->width, $this->height, $this->posX, $this->posY),
			"posX" => $this->posX,
			"posY" => $this->posY,
			"width" => $this->width,
			"height" => $this->height,
		);
	}*/
}
