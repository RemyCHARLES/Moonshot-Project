// backend/src/services/audio_service.h
// ------------------------------------------------------------
// Beatquest – Audio Service Header
// ------------------------------------------------------------
// This header declares the AudioService class, which handles:
//   - Importing audio files into the PostgreSQL database
//   - Retrieving metadata about stored audio files
//
// This class is used by the API routes to populate the audio
// collection and deliver the list of files available for playback.
//
// See: audio_service.cpp for implementation.
// ------------------------------------------------------------

#pragma once

#include <string>  // For std::string

// Service class to handle audio import and metadata listing
class AudioService {
public:
    // Import all audio files from the given folder into the DB
    void importAudioFiles(const std::string& folderPath);

    // Return all stored audio files as a JSON-formatted string
    std::string getAllAudioFiles();
};