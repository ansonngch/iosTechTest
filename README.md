# Objective
Create a two views iPhone application that:
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
    * Edge insets = 0
    * Line spacing = 3
    * Item spacing = 3
 - Collection view cell:
    * Contains only single image view
    * Content mode = aspect fit

2. Populate collection view with data from this endpoint: https://pixabay.com/api/?key=10961674-bf47eb00b05f514cdd08f6e11
 - Achieve smooth scrolling as much as possible
 - Show image thumbnail by using 'previewURL' in the returned json result.
 - Show loading indicator when thumbnail is downloading
 - Cache thumbnails for good user experience

## VideoPreviewViewController
1. Create a simple UI with:
 - Video preview view:
    * Below navigation bar
    * Equal width as parent view
    * 16:9 aspect ratio
 - Start button:
    * 15pt below 'Video preview view'
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
    * Play preview immediately after the composition is finished.

# Version control requirement
1. Create a private repo at [Bitbucket](https://bitbucket.org/) or [Gitlab](https://gitlab.com/).
2. Make your commit often with short and meaningful commit message. 