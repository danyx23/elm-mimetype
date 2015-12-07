module MimeType
  ( MimeImage(..)
  , MimeAudio(..)
  , MimeVideo(..)
  , MimeText(..)
  , MimeType(Image, Audio, Video, Text, OtherMimeType)
  , parseMimeType) where
  
{-| This modules provides the union type MimeType to model some of the most common
mime types and a parsing function that tries to parse a MimeType. The possible values for
MimeType are all union types as well that specify the Sub-type. It was originally developed to
classify files dropped into the browser via the HTML5 Drag and Drop api.

This library ATM provides only an incomplete, somewhat arbitrary mapping of the most common 
browser mime types. 
See https://code.google.com/p/chromium/codesearch#chromium/src/net/base/mime_util.cc&l=201 
for a full list of Mime types as implemented in chromium.

# Mime type
@docs MimeType

# Parsing function
@docs parseMimeType

# Subtypes
@docs MimeText, MimeImage, MimeAudio, MimeVideo

-}


import String

{-| Models the most common image subtypes
-}
type MimeImage
  = Jpeg
  | Png
  | Gif
  | OtherImage

{-| Models the most common audio subtypes
-}
type MimeAudio
  = Mp3
  | Ogg
  | Wav
  | OtherAudio

{-| Models the most common video subtypes
-}
type MimeVideo
  = Mp4
  | Mpeg
  | Quicktime
  | Avi
  | Webm
  | OtherVideo

{-| Models the most common text subtypes
-}
type MimeText
  = PlainText
  | Html
  | Css
  | Xml
  | Json
  | OtherText

{-| Models the major types image, audio, video and text 
with a subtype or OtherMimeType
-}
type MimeType =
  Image MimeImage
  | Audio MimeAudio
  | Video MimeVideo
  | Text MimeText
  | OtherMimeType

{-| Tries to parse the Mime type from a string.

    -- normal use of a type/subtype that is modelled:
    parseMimeType "image/jpeg" == Just (Image Jpeg)
    
    -- use of a subtype that is not modelled ATM
    parseMimeType "image/tiff" == Just (Image OtherImage)
    
    -- use with an empty string
    parseMimeType "" == Nothing
    
    -- use with something else
    parseMimeType "bla" == Just OtherMimeType
 
-}
parseMimeType: String -> Maybe MimeType
parseMimeType mimeString =
  case (String.toLower mimeString) of
    "" -> Nothing
    "image/jpeg" -> Just <| Image Jpeg
    "image/png" -> Just <| Image Png
    "image/gif" -> Just <| Image Gif
    "audio/mp3" -> Just <| Audio Mp3
    "audio/wav" -> Just <| Audio Wav
    "audio/ogg" -> Just <| Audio Ogg
    "video/mp4" -> Just <| Video Mp4
    "video/mpeg" -> Just <| Video Mpeg
    "video/quicktime" -> Just <| Video Quicktime
    "video/avi" -> Just <| Video Avi
    "video/webm" -> Just <| Video Webm
    "text/plain" -> Just <| Text PlainText
    "text/html" -> Just <| Text Html
    "text/css" -> Just <| Text Css
    "text/xml" -> Just <| Text Xml
    "application/json" -> Just <| Text Json
    lowerCaseMimeString ->
      if (String.startsWith "image/" lowerCaseMimeString) then
        Just <| Image OtherImage
      else if (String.startsWith "audio/" lowerCaseMimeString) then
        Just <| Audio OtherAudio
      else if (String.startsWith "video/" lowerCaseMimeString) then
        Just <| Video OtherVideo
      else if (String.startsWith "text/" lowerCaseMimeString) then
        Just <| Text OtherText
      else
        Just OtherMimeType
