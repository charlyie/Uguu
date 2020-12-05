<?php

$images = [];
// Array of image paths, feel free to add/remove to/from this list
if(is_dir('img/backgrounds')) {
    foreach (glob('img/backgrounds/*.jpg') as $f) {
        $images[] = $f;
    }
}

// Redirect to a random image from the above array using status code "303 See Other" 
if (headers_sent() === false) {
    header('Location: '.$images[array_rand($images)], true, 303);
}
