# License Plate Recognition System

A computer vision system for detecting vehicles and recognizing license plates under various lighting conditions.

## Features

- Vehicle detection using YOLOv8
- Adaptive image filtering based on lighting conditions (morning, evening, night)
- License plate extraction and OCR using Tesseract
- Region of Interest (ROI) extraction for detected vehicles

## Requirements

- Python 3.8+
- Tesseract OCR installed on your system
- Required Python packages listed in requirements.txt

## Installation

1. Install Tesseract OCR on your system:
   - Windows: Download and install from [Tesseract GitHub](https://github.com/UB-Mannheim/tesseract/wiki)
   - Linux: `sudo apt-get install tesseract-ocr`

2. Install Python dependencies:
```bash
pip install -r requirements.txt
```

## Usage

Run the detection on a sample image:

```python
python licenceplatelocalization.py
```

The script will:
- Detect vehicles in the image
- Apply appropriate filters based on lighting conditions
- Save ROIs for each detected vehicle
- Perform OCR on potential license plate regions

## Output Files

- `output_*.jpg`: Image with detected vehicles marked
- `vehicle_roi_*.jpg`: Extracted vehicle regions
- `filtered_*.jpg`: Images after lighting-specific filtering

## License

MIT
