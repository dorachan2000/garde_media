# garde_media

Copies photos and videos from an outdoor camera's SD card.

## copy.sh
- Source: `/Volumes/GARDEPRO/DCIM` (the SD card mount; stays an absolute path).
- Copies the files in every subfolder in `DCIM` (`100MEDIA`, `101MEDIA`, ...) flat into `copy/`. Don't hard-code folder names.
- The camera reuses file names across folders, so each file is prefixed with its folder name (`101MEDIA_DSCF0001.JPG`) to avoid overwriting.
- Then copies `*.MP4` from `copy/` to `mp4-test/` and `*.JPG` to `jpg-test/`.
- All local paths are relative to the script's own directory (`SCRIPT_DIR`), not `~` or the current directory.
- Creates `copy/`, `jpg-test/` and `mp4-test/` if missing.
- Exits with an error if the SD card isn't mounted.

## Folders
- `copy/` – everything copied off the card
- `jpg-test/`, `mp4-test/` – sorted output from the script
- `jpg/`, `mp4/` – older sorted media (not written by the script)

## Future work
Filtering out empty clips/photos with MegaDetector is planned but not built. See "Idea: filtering out empty clips and photos" in `README.md`.

## Testing
Don't run against the real card unless asked. To test, copy the script elsewhere, point `SRC` at a fake `DCIM` folder with `sed`, and run it there.
