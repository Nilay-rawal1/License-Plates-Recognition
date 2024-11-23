import cv2
import numpy as np
from ultralytics import YOLO

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
    
    # Detect vehicles
    detections = detector.detect_vehicles(image)
    
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
    
    return vehicle_roi

if __name__ == "__main__":
    test_vehicle_detection()


