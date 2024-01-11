import cv2
import dlib
import numpy as np

# Load the video
cap = cv2.VideoCapture('your_video.mp4')

# Initialize the face detector and the facial landmarks predictor
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('shape_predictor_68_face_landmarks.dat')

while cap.isOpened():
    # Read a frame from the video
    ret, frame = cap.read()

    if not ret:
        break

    # Detect faces in the frame
    faces = detector(frame)

    for face in faces:
        # Predict facial landmarks
        landmarks = predictor(frame, face)

        # Get the coordinates of the eyes
        left_eye = landmarks.part(36).x, landmarks.part(36).y
        right_eye = landmarks.part(45).x, landmarks.part(45).y

        # Draw circles around the eyes
        cv2.circle(frame, left_eye, 3, (255, 0, 0), -1)
        cv2.circle(frame, right_eye, 3, (255, 0, 0), -1)

    # Display the frame
    cv2.imshow('Frame', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()