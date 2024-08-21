#!/bin/bash

USERNAME="jaroshevskii"
REPOSITORY="traveller-server"
PROJECT="TravellerServer"
EXECUTABLE="travellerserver"
OS="Linux"
ARCHITECTURE="x86_64"

build_project() {
    echo "Building the project with Swift PM..."
    swift build --configuration release --static-swift-stdlib
    if [ $? -ne 0 ]; then
        echo "❌ Build failed. Please check for errors."
        exit 1
    fi
    echo "✅ Build completed successfully."
}

update_version_tag() {
    echo "Fetching the latest tag..."
    LATEST_TAG=$(gh release list --repo $USERNAME/$REPOSITORY --limit 1 | awk '{print $1}')
    VERSION=$(echo "$LATEST_TAG" | awk -F. '{$NF+=1; print $0}' OFS='.')
    NEW_TAG="v$VERSION"
    echo "Updating tag to $NEW_TAG"
    git tag $NEW_TAG
    git push origin $NEW_TAG
}

create_archive() {
    ARCHIVE="$PROJECT-$VERSION-$OS-$ARCHITECTURE.zip"
    echo "Creating zip archive: $ARCHIVE"
    zip -j "$ARCHIVE" ".build/release/$EXECUTABLE"
    if [ $? -ne 0 ]; then
        echo "❌ Failed to create zip archive."
        exit 1
    fi
    echo "✅ Archive created successfully."
}

publish_release() {
    echo "Publishing a new release on GitHub..."
    gh release create "$NEW_TAG" "$ARCHIVE" --repo "$USERNAME/$REPOSITORY" --title "Release $NEW_TAG" --notes "Automated release for $PROJECT version $VERSION"
    if [ $? -ne 0 ]; then
        echo "❌ Failed to publish the release on GitHub."
        exit 1
    fi
    echo "✅ Release published successfully."
}

build_project
update_version_tag
create_archive
publish_release
