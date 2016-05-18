# Cropfield for SilverStripe
#### PictureUpload with Jcrop.

## Introduction
The CropField module provides `CropField`, a Picture Upload in Frontend with integratet JCrop functionallity, based on Dropzone. 

## Features
* Upload Images on the frontend, and directly Crop the with JCrop 
* Drag-and-drop uploading

## Requirements
* silverstripe-dropzone (https://github.com/unclecheese/silverstripe-dropzone)
## Usage
```php
	function ImageFrom(){
		$fields = new FieldList(
			$cf = new CropField("Image", "Image")
		);
		$actions = new FieldList(
			new FormAction("submit", "submit")
		);
		return new Form($this, "ImageFrom", $fields, $actions);
	}
	
	function submit($data,$form){
		$original = Image::get()->byID($data['Image']['ID']);
		$cropped = $original->CroppedFromPos($data['Image']['width'], $data['Image']['height'], $data['Image']['posX'], $data['Image']['posY']);
		//overwrite the Original Image by the Cropped one
		copy(Director::baseFolder() . "/" . $cropped->Filename, Director::baseFolder() . "/" . $original->Filename);
		$this->data()->ImageID = $original->ID;
		$this->data()->write();
		$this->redirectBack();
	}
```

### More advanced options

```php
CropField::create('Image', 'Upload an image')
	->setBoxWidth(600) //set BoxWidth to 0 to use full Form width
	->setBoxHeight(600)
	->setMaxWidth(0)
	->setMaxHeight(0)
	->setMaxWidth(0)
	->setMaxHeight(0)
	->setAspectRatio(1)
  ));
```
