import cv2
import numpy as np
from ultralytics import YOLO
from datetime import datetime
import pytesseract
# Set Tesseract CMD path - update this path to match your installation
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

class ImageFilter:
    @staticmethod
    def determine_lighting_condition(image):
        """
        Determine lighting condition based on image brightness
        Returns: 'morning', 'evening', or 'night'
        """
        # Convert to HSV for better brightness analysis
        hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
        brightness = np.mean(hsv[:, :, 2])
        
        if brightness > 150:
            return 'morning'
        elif brightness > 100:
            return 'evening'
        else:
            return 'night'
    
    @staticmethod
    def apply_filter(image, lighting):
        """
        Apply appropriate filter based on lighting condition
        """
        if lighting == 'morning':
            # For well-lit conditions: minor contrast enhancement
            return cv2.convertScaleAbs(image, alpha=1.1, beta=0)
        
        elif lighting == 'evening':
            # For evening: increase brightness and contrast
            return cv2.convertScaleAbs(image, alpha=1.3, beta=30)
        
        else:  # night
            # For night: aggressive contrast enhancement and denoise
            gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
            denoised = cv2.fastNlMeansDenoising(gray)
            return cv2.equalizeHist(denoised)

class VehicleDetector:
    def __init__(self):
        # Initialize YOLO model for vehicle detection
        self.model = YOLO('yolov8n.pt')  # Using the nano model for speed, can be upgraded to larger models
        
        # Classes we're interested in (from COCO dataset)
        self.vehicle_classes = [2, 3, 5, 7]  # car, motorcycle, bus, truck
        
    def detect_vehicles(self, image):
        """
        Detect vehicles in the given image
        Args:
            image: numpy array of the image (BGR format)
        Returns:
            list of detected vehicle bounding boxes in format [x1, y1, x2, y2, confidence]
        """
        # Run inference
        results = self.model(image)
        
        # Extract vehicle detections
        vehicles = []
        for result in results:
            boxes = result.boxes
            for box in boxes:
                cls = int(box.cls[0])
                if cls in self.vehicle_classes:
                    x1, y1, x2, y2 = box.xyxy[0].cpu().numpy()
                    confidence = float(box.conf[0])
                    vehicles.append([int(x1), int(y1), int(x2), int(y2), confidence])
        
        return vehicles

    def draw_detections(self, image, detections):
        """
        Draw bounding boxes around detected vehicles
        Args:
            image: numpy array of the image
            detections: list of detections [x1, y1, x2, y2, confidence]
        Returns:
            image with drawn bounding boxes
        """
        img_copy = image.copy()
        for x1, y1, x2, y2, conf in detections:
            cv2.rectangle(img_copy, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.putText(img_copy, f'Vehicle {conf:.2f}', 
                       (x1, y1-10), cv2.FONT_HERSHEY_SIMPLEX, 
                       0.5, (0, 255, 0), 2)
        return img_copy

def detect_from_image(image_path):
    """Process a single image for vehicle detection
    Args:
        image_path: Path to the input image
    """
    # Initialize detector
    detector = VehicleDetector()
    
    # Read image
    image = cv2.imread(image_path)
    if image is None:
        print(f"Error: Could not read image at {image_path}")
        return
    
    # Apply appropriate filter based on lighting
    img_filter = ImageFilter()
    lighting = img_filter.determine_lighting_condition(image)
    filtered_image = img_filter.apply_filter(image, lighting)
    
    print(f"Detected lighting condition: {lighting}")
    
    # Save filtered image for debugging
    cv2.imwrite(f'filtered_{lighting}_{image_path.split("/")[-1]}', 
                filtered_image if lighting != 'night' else cv2.cvtColor(filtered_image, cv2.COLOR_GRAY2BGR))
    
    # Detect vehicles on filtered image
    if lighting == 'night':
        # Convert back to BGR for YOLO if it's grayscale
        filtered_image = cv2.cvtColor(filtered_image, cv2.COLOR_GRAY2BGR)
    detections = detector.detect_vehicles(filtered_image)
    
    # Draw detections
    output_image = detector.draw_detections(image, detections)
    
    # Extract and save ROIs for each detected vehicle
    for i, detection in enumerate(detections):
        vehicle_roi = extract_vehicle_roi(image, detection)
        roi_path = f'vehicle_roi_{i}_{image_path.split("/")[-1]}'
        cv2.imwrite(roi_path, vehicle_roi)
        print(f"Saved vehicle ROI as {roi_path}")
    
    # Save result with all detections marked
    output_path = 'output_' + image_path.split('/')[-1]
    cv2.imwrite(output_path, output_image)
    print(f"Processed image saved as {output_path}")

def test_vehicle_detection():
    
    image_path = 'sample.jpg'
    detect_from_image(image_path)


def perform_ocr(image):
    """
    Perform OCR using Tesseract
    Returns: recognized text
    """
    try:
        text = pytesseract.image_to_string(image, config='--psm 7')
        return text.strip()
    except Exception as e:
        print(f"OCR error: {e}")
        return ""

def extract_vehicle_roi(image, detection):
    """Extract Region of Interest (ROI) for a detected vehicle
    Args:
        image: numpy array of the original image
        detection: list containing [x1, y1, x2, y2, confidence]
    Returns:
        cropped_image: numpy array containing just the vehicle region
    """
    x1, y1, x2, y2, _ = detection
    
    # Add a small padding around the detection (5% of width/height)
    height, width = image.shape[:2]
    pad_x = int(0.05 * (x2 - x1))
    pad_y = int(0.05 * (y2 - y1))
    
    # Ensure coordinates stay within image bounds
    roi_x1 = max(0, x1 - pad_x)
    roi_y1 = max(0, y1 - pad_y)
    roi_x2 = min(width, x2 + pad_x)
    roi_y2 = min(height, y2 + pad_y)
    
    # Crop the image to the ROI
    vehicle_roi = image[roi_y1:roi_y2, roi_x1:roi_x2]
    
    # Attempt OCR
    text = perform_ocr(vehicle_roi)
    if text:
        print(f"OCR result: {text}")
    
    return vehicle_roi

if __name__ == "__main__":
    test_vehicle_detection()


