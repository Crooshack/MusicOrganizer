#!/bin/bash

#           ********MP3 music tool********
# Author           : Bartlomiej Kruszynski ( s193058@student.pg.edu.pl )
# Created On       : 27.04.2023
# Last Modified By : Bartlomiej Kruszynski ( s193058@student.pg.edu.pl )
# Last Modified On : 10.05.2023
# Version          : 1.0
#
# Description      :
# Script changes id3v1 and id3v2 frames on MP3 files, can filter MP3 files by id3v2 frames and zip MP3 files in a directory.
#
# Licensed under GPL (see /usr/share/common-licenses/GPL for more details
# or contact # the Free Software Foundation for a copy)



#id3v2 names and keys used to change them
FRAME_KEYS=("AENC" "APIC" "COMM" "COMR" "ENCR" "EQUA" "ETCO" "GEOB" "GRID" "IPLS" "LINK" "MCDI" "MLLT" "OWNE" "PRIV" "PCNT" "POPM" "POSS" "RBUF" "RVAD" "RVRB" "SYLT" "SYTC" "TALB" "TBPM" "TCOM" "TCON" "TCOP" "TDAT" "TDLY" "TENC" "TEXT" "TFLT" "TIME" "TIT1" "TIT2" "TIT3" "TKEY" "TLAN" "TLEN" "TMED" "TOAL" "TOFN" "TOLY" "TOPE" "TORY" "TOWN" "TPE1" "TPE2" "TPE3" "TPE4" "TPOS" "TPUB" "TRCK" "TRDA" "TRSN" "TRSO" "TSIZ" "TSRC" "TSSE" "TXXX" "TYER" "UFID" "USER" "USLT" "WCOM" "WCOP" "WOAF" "WOAR" "WOAS" "WORS" "WPAY" "WPUB" "WXXX")
FRAME_NAMES=("Audio encryption" "Attached picture" "Comments" "Commercial frame" "Encryption method registration" "Equalization" "Event timing codes" "General encapsulated object" "Group identification registration" "Involved people list" "Linked information" "Music CD identifier" "MPEG location lookup table" "Ownership frame" "Private frame" "Play counter" "Popularimeter" "Position synchronisation frame" "Recommended buffer size" "Relative volume adjustment" "Reverb" "Synchronized lyric/text" "Synchronized tempo codes" "Album/Movie/Show title" "BPM (beats per minute)" "Composer" "Content type" "Copyright message" "Date" "Playlist delay" "Encoded by" "Lyricist/Text writer" "File type" "Time" "Content group description" "Title/songname/content description" "Subtitle/Description refinement" "Initial key" "Language(s)" "Length" "Media type" "Original album/movie/show title" "Original filename" "Original lyricist(s)/text writer(s)" "Original artist(s)/performer(s)" "Original release year" "File owner/licensee" "Lead performer(s)/Soloist(s)" "Band/orchestra/accompaniment" "Conductor/performer refinement" "Interpreted, remixed, or otherwise modified by" "Part of a set" "Publisher" "Track number/Position in set" "Recording dates" "Internet radio station name" "Internet radio station owner" "Size" "ISRC (international standard recording code)" "Software/Hardware and settings used for encoding" "User defined text information" "Year" "Unique file identifier" "Terms of use" "Unsynchronized lyric/text transcription" "Commercial information" "Copyright/Legal information" "Official audio file webpage" "Official artist/performer webpage" "Official audio source webpage" "Official internet radio station homepage" "Payment" "Official publisher webpage" "User defined URL link")

#id3v2 genre names used to allow user to see names and not numbers (in id3v2 function we use index numbers instead of names)
GENRES_NAMES=("Blues" "Classic Rock" "Country" "Dance" "Disco" "Funk" "Grunge" "Hip-Hop" "Jazz" "Metal" "New Age" "Oldies" "Other" "Pop" "R&B" "Rap" "Reggae" "Rock" "Techno" "Industrial" "Alternative" "Ska" "Death Metal" "Pranks" "Soundtrack" "Euro-Techno" "Ambient" "Trip-Hop" "Vocal" "Jazz+Funk" "Fusion" "Trance" "Classical" "Instrumental" "Acid" "House" "Game" "Sound Clip" "Gospel" "Noise" "AlternRock" "Bass" "Soul" "Punk" "Space" "Meditative" "Instrumental Pop" "Instrumental Rock" "Ethnic" "Gothic" "Darkwave" "Techno-Industrial" "Electronic" "Pop-Folk" "Eurodance" "Dream" "Southern Rock" "Comedy" "Cult" "Gangsta" "Top 40" "Christian Rap" "Pop/Funk" "Jungle" "Native American" "Cabaret" "New Wave" "Psychedelic" "Rave" "Showtunes" "Trailer" "Lo-Fi" "Tribal" "Acid Punk" "Acid Jazz" "Polka" "Retro" "Musical" "Rock & Roll" "Hard Rock" "Folk" "Folk-Rock" "National Folk" "Swing" "Fast Fusion" "Bebop" "Latin" "Revival" "Celtic" "Bluegrass" "Avantgarde" "Gothic Rock" "Progressive Rock" "Psychedelic Rock" "Symphonic Rock" "Slow Rock" "Big Band" "Chorus" "Easy Listening" "Acoustic" "Humour" "Speech" "Chanson" "Opera" "Chamber Music" "Sonata" "Symphony" "Booty Bass" "Primus" "Porn Groove" "Satire" "Slow Jam" "Club" "Tango" "Samba" "Folklore" "Ballad" "Power Ballad" "Rhythmic Soul" "Freestyle" "Duet" "Punk Rock" "Drum Solo" "A capella" "Euro-House" "Dance Hall" "Goa" "Drum & Bass" "Club-House" "Hardcore" "Terror" "Indie" "Britpop" "Negerpunk" "Polsk Punk" "Beat" "Christian Gangsta Rap" "Heavy Metal" "Black Metal" "Crossover" "Contemporary Christian" "Christian Rock" "Merengue" "Salsa" "Thrash Metal" "Anime" "JPop" "Synthpop")

#Titles and prompts for various windows
VALUE_WINDOW_TITLES=("File" "Title" "Album" "Artist" "Genre" "Production year" "Track number" "Confirmation" "Confirmation" "Frame value" "Frame value" "Zipfile name")
VALUE_WINDOW_PROMPTS=("Enter title: " "Enter album name: " "Enter artist: " "Select genre: " "Enter production year: " "Enter track number/(optional) total tracks: " "Are you sure you want to delete all tags?" "Are you sure you want to convert all tags to id3v2?" "Enter selected frame value: " "Enter selected frame value: " "Enter zipfile name: ")

#Options for id3v2 functions which have always the same option value
SIMPLE_OPTIONS=("--song" "--album" "--artist" "--genre" "--year" "--track" "--delete-all" "--convert")

#Content of the main menu
MENU=("Change the file" "Set title" "Set album" "Set artist" "Set genre" "Set production year" "Set track number" "Delete all tags" "Convert id3v1 tags to id3v2 tags" "Set detailed track information" "Filter tracks in a directory" "Zip tracks in a directory")

#-h option
#Displays help
function displayHelp() {
    echo "*******MP3 music tool - HELP*******"
    echo "Script changes id3v1 and id3v2 frames on MP3 files, can filter MP3 files by id3v2 frames and zip MP3 files in a directory."
    echo ""
    echo "Options:"
    echo "-h - displays this help"
    echo "-v - displays information about the program"
    echo ""
    echo "After launching the program you have to choose a file to access all functions. After choosing one you'll have choice to use one of the following functions: 
    - Set title
    - Set album
    - Set artist
    - Set genre
    - Set production year
    - Set track number
    - Delete all tags
    - Convert id3v1 tags to id3v2 tags
    - Set detailed track information
    - Filter tracks in a directory
    - Zip tracks in a directory"
}

#-v option function
#Display information about the program
function displayVersion() {
    echo "*******MP3 music tool - INFO*******"
    echo "Script changes id3v1 and id3v2 frames on MP3 files, can filter MP3 files by id3v2 frames and zip MP3 files in a directory."
    echo ""
    echo "Version 1.0"
    echo "Author: Bartlomiej Kruszynski 193058"
    echo "The program requires id3v2, zenity and zip"
}

#Displays completion information after an operation ended successfully
function displayCompletionInformation() {
	zenity --notification --text="Operation complete"
}

#Prompts user to confirm an action which is specified by an argument $1
function getConfirmation() {
    #Display yes or no window to get a confirmation on shown question
    VALUE=$(zenity --question --title="${VALUE_WINDOW_TITLES[$1]}" --text="${VALUE_WINDOW_PROMPTS[$1-1]}")
    
    #Get information if the user clicked Cancel, X or if timeout happened
    VALUE_EXIT=$?
}

#Prompts user to choose a file
function getFile() {
    #Display window and get a value
	TMP_FILE=$(zenity --file-selection --file-filter='*.mp3' --title="${VALUE_WINDOW_TITLES[0]}")

    #Get information if the user clicked Cancel, X or if timeout happened
    FILE_EXIT=$?
    #If not
    if [[ $FILE_EXIT != "1" && $FILE_EXIT != "5" ]]; then
        #Change the FILE to the new value
        FILE=$TMP_FILE
    fi

    #Unset because we use this variabled only here (local variable)
    unset TMP_FILE
}

#Prompts user to choose a directory
function getDirectory() {
    #Display window and get a value
	TMP_DIRECTORY=$(zenity --file-selection --directory --title="Choose a directory")

    #Get information if the user clicked Cancel, X or if timeout happened
    DIRECTORY_EXIT=$?
    #If not
    if [[ $DIRECTORY_EXIT != "1" && $DIRECTORY_EXIT != "5" ]]; then
        #Change the DIRECTORY to the new value
        DIRECTORY=$TMP_DIRECTORY
    fi

    #Unset because we use this variabled only here (local variable)
    unset TMP_DIRECTORY
}

#Rewrites names of all MP3 files in the given directory
function rewriteMP3Files() {
    #Reseting the array to empty to have no old files inside it
    MP3FILES=()

    #For every .mp3 file in the given directory 
    for file in "$1"/*.mp3; do
        #If the file exists 
        if [[ -f "$file" ]]; then
            #Add the file to the array
            MP3FILES+=("$file")
        fi
    done

    #Unset because we use this variabled only here (local variable)
    unset file
}

#Function allows user to enter a value for provided id3v2 function mode
function getValue() {
    #Display window and get a value
	VALUE=$(zenity --entry --title="${VALUE_WINDOW_TITLES[$1]}" --text="${VALUE_WINDOW_PROMPTS[$1-1]}")
    #Get information if the user clicked Cancel, X or if timeout happened
    VALUE_EXIT=$?
}

#Function allows user to select one value from the list. You can choose from genres or frames.
function getValueFromOptions() {
    #Mode selection
    case $1 in 
        #Choosing genres
        "GENRES") 
            #Let the user choose a value from the list
            VALUE=$(zenity --list --title="${VALUE_WINDOW_TITLES[$2]}" --text="${VALUE_WINDOW_PROMPTS[$2-1]}" --column="Genres" "${GENRES_NAMES[@]}" --height 500 --width 400)
            #Get information if the user clicked Cancel, X or if timeout happened
            VALUE_EXIT=$?;;
        
        #Choosing id3v2 frames
        "FRAMES") 
            #Let the user choose a value from the list
            VALUE=$(zenity --list --title="Frames" --text="Choose a frame" --column="Frames" "${FRAME_NAMES[@]}" --height 500 --width 400)
            #Get information if the user clicked Cancel, X or if timeout happened
            VALUE_EXIT=$?;;
    esac
    
}

#Function finds index number in the array of the given value. You can search in genres or frames.
function findIndexNumber() {
    #Mode selection
    case $1 in 
        #Search in genres
        "GENRES")
            #Reset the GENRE_NUMBER to first index number
            GENRE_NUMBER=0

            for GENRE_NAME in "${GENRES_NAMES[@]}"; do
                #If GENRE_NAME equals the given value
                if [[ $GENRE_NAME == $2 ]]; then
                    #Exit the function
                    return
                fi
                #Increment the index number
                GENRE_NUMBER=$(($GENRE_NUMBER+1))
            done;;

        #Search in frames
        "FRAMES")
            #Reset the FRAME_NUMBER to first index number
            FRAME_NUMBER=0
            
            for FRAME_NAME in "${FRAME_NAMES[@]}"; do
                #If FRAME_NAME equals the given value
                if [[ $FRAME_NAME == $2 ]]; then
                    #Exit the function
                    return
                fi
                #Increment the index number
                FRAME_NUMBER=$(($FRAME_NUMBER+1))
            done;; 
    esac
}

#Function used for id3v2 functions "Set title" "Set album" "Set artist" "Set genre" "Set production year" "Set track number"
function useSimpleFunction() {
    getValue $1
    #If the user didn't click Cancel, X and if timeout did not happen
    if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
        #Call id3v2 function with right arguments
        id3v2 ${SIMPLE_OPTIONS[$1-1]} "$VALUE" "$FILE"

        displayCompletionInformation
    fi
}

#Function used for id3v2 functions "Delete all tags" "Convert id3v1 tags to id3v2 tags"
function useYesNoFunction() {
    getConfirmation $1
    #If user confirmed then:
    if [[ $VALUE_EXIT == "0" ]]; then
        #Call id3v2 function with right arguments
        id3v2 ${SIMPLE_OPTIONS[$1-1]} "$FILE"

        displayCompletionInformation
    fi
}

#Function used for id3v2 functions "Set genres" and "Set detailed frames"
function useComplexFunction() {
    #Mode selection
    case $2 in 
        #Set genres
        "GENRES")
            getValueFromOptions $2 $1
            #If the user didn't click Cancel, X and if timeout did not happen
            if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
                #Find the index number in the array of the chosen genre
                findIndexNumber $2 $VALUE
                #Call id3v2 function with right arguments
                id3v2 ${SIMPLE_OPTIONS[$1-1]} "$GENRE_NUMBER" "$FILE"

                displayCompletionInformation
            fi;;

        #Set detailed information
        "FRAMES")
            getValueFromOptions $2 $1
            #If the user didn't click Cancel, X and if timeout did not happen
            if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
                #Find the index number in the array of the chosen frame to get a frame key
                findIndexNumber $2 $VALUE
                getValue $1
                #If the user didn't click Cancel, X and if timeout did not happen
                if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
                    #Call id3v2 function with right arguments
                    id3v2 --${FRAME_KEYS[$FRAME_NUMBER]} "$VALUE" "$FILE"
                    
                    displayCompletionInformation
                fi
            fi;;
    esac
}

#Creates zip file with all the .mp3 files in the given directory
function createZip() {
    #For every .mp3 file in the given directory 
    for file in "$DIRECTORY"/*.mp3; do
        #If the file exists 
        if [[ -f "$file" ]]; then
            #Add that file to the zip archive
            zip -j "$ZIPFILE_NAME" "$file"
        
        #If the file doesn't exist
        else
            #Display an error
            zenity --error --title="Error" --text="No mp3 files in the directory"
            #Unset because we use this variabled only here (local variable)
            unset file
            #Exit the function
            return
        fi
    done
    displayCompletionInformation
    #Unset because we use this variabled only here (local variable)
    unset file
}








#*******************
#*****MAIN CODE*****
#*******************

#OPTIONS HANDLING
#While there are arguments h or v:
while getopts "hv" OPT; do
    case $OPT in
        #When h is an argument display help
        h) displayHelp;;
        #When v is an argument display version/program/author information
        v) displayVersion;;
    esac
    
    #Shift command is used to remove the options that have already been processed, so that new argument is at index 1 (counting from 1)
    shift $((OPTIND-1))

    
    #If there were no more arguments for getopts, it didn't change OPTIND to another value so after shift operation it would equal 0
    if [ $# -eq 0 ]; then
        #Exit if there are none
        exit
    fi
    echo ""
done



#SCRIPT LOGIC

#0 for EXIT ensures that we can get into the loop
EXIT="0"
#0 for FILE ensures that we will get into the restricted mode first
FILE="0"

#Execute until user clicks Cancel or X
while [[ $EXIT != "1" && $EXIT != "5" ]]; do
    #RESTRICTED MODE
    #After first boot you have to choose a file to access other functions
    #If FILE equals "0" then enter mode with the only option "Select a file"
    if [[ $FILE == "0" ]]; then
        #Display menu with the only option "Select a file"
        OPTION=$(zenity --list --title="MP3 music tool" --text="Choose a file to access all functions" "Select a file" --column="Functions")

        #Get the information if the user clicked Cancel, X or if timeout happened
        EXIT=$?

        #***FUNCTIONS***
        #Select a file
        if [[ $OPTION == "Select a file" ]]; then
	        getFile

            #If the user clicked Cancel, X or if timeout happened, reset FILE value to "0"
            if [[ $FILE_EXIT == "1" || $FILE_EXIT == "5" ]]; then
                FILE="0"
            fi
        fi
    
    #NORMAL MODE
    #If file is chosen enter normal mode
    else
        #Display the main menu and get the chosen option
        OPTION=$(zenity --list --title="MP3 music tool" --text="Currently chosen file: $FILE" "${MENU[@]}" --column="Functions" --height 500 --width 600)

        #Get the information if the user clicked Cancel, X or if timeout happened
        EXIT=$?

        #***FUNCTION CHOICE***
        #Change the file
        if [[ $OPTION == ${MENU[0]} ]]; then
            getFile

        #Set title
        elif [[ $OPTION == ${MENU[1]} ]]; then
            useSimpleFunction 1

        #Set album
        elif [[ $OPTION == ${MENU[2]} ]]; then
            useSimpleFunction 2

        #Set artist
        elif [[ $OPTION == ${MENU[3]} ]]; then
            useSimpleFunction 3

        #Set genre
        elif [[ $OPTION == ${MENU[4]} ]]; then
            useComplexFunction 4 GENRES

        #Set production year
        elif [[ $OPTION == ${MENU[5]} ]]; then
            useSimpleFunction 5

        #Set track number
        elif [[ $OPTION == ${MENU[6]} ]]; then
            useSimpleFunction 6

        #Delete all tags
        elif [[ $OPTION == ${MENU[7]} ]]; then
            useYesNoFunction 7

        #Convert id3v1 tags to id3v2 tags
        elif [[ $OPTION == ${MENU[8]} ]]; then
            useYesNoFunction 8

        #Set detailed information
        elif [[ $OPTION == ${MENU[9]} ]]; then
            useComplexFunction 9 FRAMES

        #Filter tracks in a directory
        elif [[ $OPTION == ${MENU[10]} ]]; then
            getDirectory
            if [[ $DIRECTORY_EXIT != "1" && $DIRECTORY_EXIT != "5" ]]; then
                #Get number of files in a directory
                NUMBER_OF_FILES=$(ls "$DIRECTORY"/*.mp3 | wc -l)

                #If the folder contains .mp3 files then proceed
                if [[ $NUMBER_OF_FILES != "0" ]]; then
                    #Rewrite MP3 files names to an array
                    rewriteMP3Files $DIRECTORY

                    #Choose filtering criteria
                    getValueFromOptions FRAMES 10
                    if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
                        FRAME_FILTER=$VALUE

                        #Enter the value to filter by
                        getValue 10
                        if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
                            VALUE_FILTER=$VALUE

                            #Variable which holds information how many result files we have
                            COUNTER=0

                            #Reseting the array to empty to have no old files inside it
                            RESULT_FILES=()

                            #Finding matching files and counting them
                            for ((i=0; i<$NUMBER_OF_FILES; i++)); do
                                VALUE=$(id3v2 -l ${MP3FILES[$i]} | grep "$FRAME_FILTER" | cut -d : -f 2- | sed 's/^[ \t]*//')
                                if [[ "$VALUE" == "$VALUE_FILTER" ]]; then
                                    #If the VALUE matches VALUE_FILTER, then add matching file to the array
                                    RESULT_FILES+=$(basename ${MP3FILES[$i]})
                                    #and count that file
                                    COUNTER=$(($COUNTER + 1))
                                fi
                            done
                            
                            #Display result files and COUNTER value
                            zenity --list --title="Result files" --text="Files with value $VALUE_FILTER on the frame $FRAME_FILTER" --column="Found files: $COUNTER" ${RESULT_FILES[@]} --height 500 --width 600
                        fi
                    fi
                
                #If folder doesn't contain .mp3 files, show an error
                else
                    zenity --error --title="Error" --text="No mp3 files in the directory"
                fi
            fi
        
        #Zip tracks in a directory
        elif [[ $OPTION == ${MENU[11]} ]]; then
            getDirectory
            if [[ $DIRECTORY_EXIT != "1" && $DIRECTORY_EXIT != "5" ]]; then
                #User enters zipfile name
                getValue 11
                if [[ $VALUE_EXIT != "1" && $VALUE_EXIT != "5" ]]; then
                    ZIPFILE_NAME=$VALUE
                    #Zip archive creation
                    createZip
                fi
            fi
        fi

    fi
done 