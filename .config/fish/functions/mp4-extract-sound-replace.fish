function mp4-extract-sound-replace --description "Replace an mp4 file with mp3 with the sound extracted from it"
    if [ (count $argv) -ne 1 ]
       echo "ERR: requires a single argument, a filename"
       return 1
    else if [ ! -f $argv[1] ]
       echo "The argument '" argv[1] "' should be a file"
       return 1
    end
    set FILE $argv[1]
    set rootname (string match -r "(.*)\.[^\.]*\$" "$FILE")[2]
    set AUDIOFILE (echo "$rootname.mp3")
    ffmpeg -loglevel panic -i "$FILE" "$AUDIOFILE"; and rm "$FILE"; and echo "Done $FILE -> $AUDIOFILE"
end
