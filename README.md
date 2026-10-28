# garde_media

Copies photos and videos off an outdoor camera's SD card, to catch wild animals in the yard (e.g. an armadillo digging holes).

## Usage

Plug in the SD card (mounts at `/Volumes/GARDEPRO`), then run:

```bash
bash copy.sh
```

This copies everything in the card's `DCIM` folder into `copy/`, adding the card folder name to the front of each file (e.g. `101MEDIA_DSCF0001.JPG`) because the camera reuses names across folders. It then sorts videos into `mp4-test/` and photos into `jpg-test/`. All folders are created next to the script.

## Idea: filtering out empty clips and photos

**Problem:** trigger mode and time-lapse mode make lots of clips and photos with nothing in them. As of 2026-10-27, `copy/` held about 620 JPG + 620 MP4 (8.9 GB).

**Recommended tool: [MegaDetector](https://github.com/agentmorris/MegaDetector)**
- A free AI model trained on millions of trail-camera images.
- Finds animals, people and vehicles, and ignores wind, shadows and lighting changes.
- Runs locally; fine on an M-series Mac.

**No-code option:** the [AddaxAI](https://addaxdatascience.com/addaxai/) desktop app (formerly EcoAssist) wraps MegaDetector in a GUI. Point it at `copy/` and it can sort files into folders.

**Script option (`filter.py`, not written yet):**
- Python 3.11 environment via `uv` (system Python is 3.9), then `pip install megadetector`.
- JPG: run the detector once.
- MP4: sample about 1 frame per second with OpenCV; stop at the first hit.
- A file is a hit if any animal/person/vehicle detection has confidence ≥ 0.2 (make it adjustable).
- Move, never delete: hits go to `detected/`, the rest to `empty/`. Also write `results.csv` (file, verdict, label, confidence, video timestamp) for spot-checking.
- Judge each JPG and MP4 on its own, since an animal may only show up in the video.

**Test set:** the hand-picked files in `jpg/` and `mp4/` (e.g. `almadillo.MP4`). All of them should come out as hits; if not, lower the threshold.

**Why not simple motion detection:** comparing frames for pixel changes gets fooled by wind, moving shadows and day/night changes, which outdoors means lots of false hits.
