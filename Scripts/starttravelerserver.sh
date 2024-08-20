#!/bin/bash

USERNAME="jaroshevskii"
REPOSITORY="traveller-server"
PROJECT="TravellerServer"
EXECUTABLE="travellerserver"
OS="Linux"
ARCHITECTURE="x86_64"

TAG=$(curl -s "https://api.github.com/repos/$USERNAME/$REPOSITORY/tags" | awk -F'"' '/"name":/ {print $4; exit}')
VERSION=$(echo "$TAG" | sed 's/^v//' || true)

ARCHIVE="$PROJECT-$VERSION-$OS-$ARCHITECTURE.zip"
EXTRACTION_DIR="$PROJECT-$VERSION-$OS-$ARCHITECTURE"

# Check if the archive already exists and remove it
if [ -f "$ARCHIVE" ]; then
  echo "Archive $ARCHIVE already exists. Re-downloading the archive..."
  rm -f "$ARCHIVE"
fi

# Download the latest release
curl -LO "https://github.com/$USERNAME/$REPOSITORY/releases/download/$TAG/$ARCHIVE"

# Check if the extraction directory already exists and remove it
if [ -d "$EXTRACTION_DIR" ]; then
  echo "Directory $EXTRACTION_DIR already exists. Removing the old directory..."
  rm -rf "$EXTRACTION_DIR"
fi

# Extract the downloaded archive
unzip "$ARCHIVE" -d "$EXTRACTION_DIR"

# Change to the extraction directory
cd "$EXTRACTION_DIR" || exit

LOG_FILE="$PROJECT.logs"

# Check if travellerserver is already running and kill it
if pgrep -x "$EXECUTABLE" > /dev/null; then
  echo "$EXECUTABLE is already running. Stopping it..."
  pkill -x "$EXECUTABLE"
fi

# Start the travellerserver in the background
if [ -f "./$EXECUTABLE" ]; then
  echo "Starting $EXECUTABLE in the background..."
  nohup "./$EXECUTABLE" > "$LOG_FILE" 2>&1 &
  echo "$EXECUTABLE is running in the background. Logs are being written to $LOG_FILE."
else
  echo "Error: Executable $EXECUTABLE not found."
  exit 1
fi

# Check if ngrok is already running and kill it
if pgrep -x "ngrok" > /dev/null; then
  echo "ngrok is already running. Stopping it..."
  pkill -x "ngrok"
fi

# Start ngrok in the background
echo "Starting ngrok in the background..."
nohup ngrok http --domain=evident-pug-abnormally.ngrok-free.app 8080 > ngrok.log 2>&1 &
echo "ngrok is running in the background. Logs are being written to ngrok.log."
