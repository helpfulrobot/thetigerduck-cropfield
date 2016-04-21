<?php
//define global path to Components' root folder
if(!defined('SS_CROPFIELD'))
{
	$folder = rtrim(basename(dirname(__FILE__)));
	define('SS_CROPFIELD', $folder);
}

Object::add_extension('Image', 'CropableImage');