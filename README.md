# Objective
Create an iPhone application that:
1. Shows a list of pictures
2. Plays a video preview.

# Before you start: 
1. Download this starter project.
1. You may use any open source library if needed. 
2. You may use dependency manager of your choice which you are familiar with.
3. Your code should be fully written in Swift 4.2, with exception of the open source library you are using.
4. You may use pure code, interface builder, or combination of both to create the necessary UI. 
5. Use of auto layout is strongly encouraged.
6. You only need to support portrait orientation for iPhone X.

# Requirements
## PictureFeedCollectionViewController
1. Create a simple feed view with:
 - Collection view:
    * 3 columns per row
    * Spacing between 2 cells = 3pt
    * Zero edge insets
 - Collection view cell:
    * Contains only single image view
    * Stretch the image and cropping off any parts that don't fit the frame
    * Maintain image original aspect ratio

2. Populate collection view with data from this endpoint: https://pixabay.com/api/?key=10961674-bf47eb00b05f514cdd08f6e11&q=flower
 - Show image thumbnail by using 'previewURL' in the returned json result.
 - Handle pagination for up to 3 pages. Refer to https://pixabay.com/api/docs/#api_search_images for API documentation.
 - Show loading indicator when thumbnail is downloading
 - Achieve smooth scrolling
 - Cache thumbnails

## VideoPreviewViewController
1. Create a simple UI with:
 - Video preview view:
    * Below navigation bar
    * Equal width as parent view
    * 16:9 aspect ratio
 - Video playback progress bar:
    * Bottom of video preview view
 - Video duration label:
    * Above progress bar
    * 10pt from parent view's leading
    * Format: 0.00s
 - Start button:
    * 15pt below video preview view
    * Stay horizontally center with parent view
    * 'Start' as its text
    * Rounded corner, corner radius = 8
    * Background color = red
 
2. Upon tapping 'Start' button, start audio file download from this url: https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview122/v4/8a/dd/1f/8add1f4d-142c-1317-250d-ff6370962fb8/mzaf_7601694821840779604.plus.aac.p.m4a
    * Show loading message
    * Show download progress

3. Merge the audio file you just downloaded with the video file included in the project by using AVFoundation
    * Video output should be in the correct orientation: landscape
    * Video output should have same duration as source video or audio, whichever is shorter
    * Update video duration label with output duration

4. Play preview immediately after the composition is finished
    * Update progress with 0.05s interval

# Version control requirement
1. Create a private repo at [Bitbucket](https://bitbucket.org/) or [Gitlab](https://gitlab.com/).
2. Make your commit often with short and meaningful commit message. 
3. Add me as your project member if you are using:
 - Gitlab: tsukisa
 - Bitbucket: casey_tsukisa