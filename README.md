# Elm MimeType

Models the most common mime types as a Union type in Elm and provides a method to 
parse mime types from a string.

The MimeType union type defines the main categories Image, Audio, Video, Text, App and OtherMimeType,
all but the last of which carry another union type defining some common formats but also giving
an Other* option with a String payload to represent arbitrary mime types.

The basic usage is to parse the mime type from a string identifier and then match against it, e.g.

```elm
let
    maybeMimeType = parseMimeType someMimeIdentifierString
  in
    case maybeMimeType of
      Nothing ->
        "Could not be parsed as a mime type at all"

      Just mimeType ->
        case mimeType of
          Image Jpeg ->
            "Successfully parsed as jpeg image"

          Image Png ->
            "Successfully parsed as png image"

          Image Gif ->
            "Successfully parsed as gif image"

          Image (OtherImage other)
            "Unrecognized image format: " ++ other

          _ ->
            "Non-image mime type"      
```

Initial version by Daniel Bachler
