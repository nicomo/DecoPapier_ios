README - how to manage pictures
=====================================

Photographs are exported from photoshop, uploaded to the app and inserted in the text.

Beware: images should always be exported with a *pair* number of pixels : 1024x768 is ok; 1025x768 is not, 1024x769 is not.

A/ export from photoshop 
- save for the web
- .jpg
- quality 25%
- select size according to destination of picture in text (in parenthesis the size at which it will be displayed): 
	-- standalone images in landscape: 1236x824 (618x412)
	-- standalone images in portrait: 618x926 (309x463)
	-- chapter title (h2) images - portrait only: 1536x1024 (768x512)
	-- popover images in landscape: 1024x730 (512x365)
	-- popover images in portrait: 618x926 (309x463)
	-- slideshow image in landscape: 1024x730 (512x365)
	-- slideshow image in portrait: 618x926 (309x463)
- save in appropriate directory (create if necessary) according to destination, using file name referenced in photoshop, e.g. 0580R1.jpg
	-- standalone images in assets/img/img_standalone/
        -- chapter title (h2) images in assets/img/img_headings/
	-- popover images in assets/img/img_popover/
	-- slideshow images in assets/img/img_slideshow/

3/ compress : put each exported img file in ImageOptim (see http://imageoptim.com/)

4/ sketches, logos, etc used in text and available as .svg. They should respect the same sizes as the pictures above, according to their destination in the text (slideshow, standalone, etc). Save in assets/img/img_svg/