#!/bin/bash

USERNAME="jaroshevskii"
REPOSITORY="traveller-server"
PROJECT="TravellerServer"
EXECUTABLE="travellerserver"
OS="Linux"
ARCHITECTURE="x86_64"
LOG_FILE="$PROJECT.logs"
NGROK_DOMAIN="evident-pug-abnormally.ngrok-free.app"
PORT="8080"

fetch_latest_version() {
    echo "Fetching the latest release information..."
    TAG=$(curl -s "https://api.github.com/repos/$USERNAME/$REPOSITORY/tags" | awk -F'"' '/"name":/ {print $4; exit}')
    VERSION=$(echo "$TAG" | sed 's/^v//' || true)
}

prepare_names() {
    ARCHIVE="$PROJECT-$VERSION-$OS-$ARCHITECTURE.zip"
    EXTRACTION_DIR="$PROJECT-$VERSION-$OS-$ARCHITECTURE"
}

remove_existing_archive() {
    if [ -f "$ARCHIVE" ]; then
        echo "Archive $ARCHIVE already exists. Re-downloading the archive..."
        rm -f "$ARCHIVE"
    fi
}

download_latest_release() {
    echo "Downloading the latest release: $ARCHIVE..."
    curl -LO "https://github.com/$USERNAME/$REPOSITORY/releases/download/$TAG/$ARCHIVE"
}

remove_existing_directory() {
    if [ -d "$EXTRACTION_DIR" ]; then
        echo "Directory $EXTRACTION_DIR already exists. Removing the old directory..."
        rm -rf "$EXTRACTION_DIR"
    fi
}

extract_archive() {
    echo "Extracting $ARCHIVE to $EXTRACTION_DIR..."
    unzip "$ARCHIVE" -d "$EXTRACTION_DIR"
}

stop_existing_executable() {
    if pgrep -x "$EXECUTABLE" > /dev/null; then
        echo "$EXECUTABLE is already running. Stopping it..."
        pkill -x "$EXECUTABLE"
    fi
}

start_executable() {
    if [ -f "./$EXECUTABLE" ]; then
        echo "Starting $EXECUTABLE in the background..."
        nohup "./$EXECUTABLE" > "$LOG_FILE" 2>&1 &
        echo "$EXECUTABLE is running in the background. Logs are being written to $LOG_FILE."
    else
        echo "Error: Executable $EXECUTABLE not found."
        exit 1
    fi
}

stop_existing_ngrok() {
    if pgrep -x "ngrok" > /dev/null; then
        echo "ngrok is already running. Stopping it..."
        pkill -x "ngrok"
    fi
}

start_ngrok() {
    echo "Starting ngrok in the background..."
    nohup ngrok http --domain=$NGROK_DOMAIN $PORT > ngrok.log 2>&1 &
    echo "ngrok is running in the background. Logs are being written to ngrok.log."
}

fetch_latest_version
prepare_names
remove_existing_archive
download_latest_release
remove_existing_directory
extract_archive

cd "$EXTRACTION_DIR" || { echo "Failed to change to extraction directory."; exit 1; }

stop_existing_executable
start_executable

stop_existing_ngrok
start_ngrok
