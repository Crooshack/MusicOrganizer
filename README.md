# Music Organizer (MP3 Music Tool)

A Bash-based graphical utility for managing MP3 metadata using Zenity.

## Overview

MP3 Music Tool is a shell script that allows you to edit ID3v1 and ID3v2 tags of MP3 files using a graphical interface. It enables users to edit metadata, filter files based on specific tags, and archive selected MP3s into a ZIP file.

## Features

- Edit ID3v1 and ID3v2 tags:
  - Title
  - Album
  - Artist
  - Genre
  - Year
  - Track number

- Convert ID3v1 tags to ID3v2

- Remove all tags from a file

- Set detailed ID3v2 frames

- Filter MP3 files in a selected directory based on tag values

- Create ZIP archives from MP3 files in a directory

## Technologies Used

- Bash
- Zenity
- id3v2
- zip

## Requirements

Before running the script, install the following packages:

```
sudo apt update
```
```
sudo apt install zenity id3v2 zip
```

## Usage

Make the script executable:

```
chmod +x mp3_music_tool.sh
```

Then run it:
```
./mp3_music_tool.sh
```

### Optional command-line arguments

- `-h` to show help
- `-v` to show version and author information

## Menu Options

When the program is launched, you will be prompted to select an MP3 file. After that, the following actions are available from the graphical menu:

- Change the currently selected MP3 file
- Set the title of the track
- Set the album name
- Set the artist name
- Choose the genre from a list
- Set the production year
- Set the track number (and optionally the total number of tracks)
- Delete all tags from the selected MP3 file
- Convert all ID3v1 tags to ID3v2 format
- Set a specific ID3v2 frame manually
- Filter tracks in a selected directory by specific frame value
- Zip all MP3 files in a selected directory into a single ZIP archive

## License

This project is licensed under the GNU General Public License v3.0.  
See https://www.gnu.org/licenses/gpl-3.0.html for more information.
