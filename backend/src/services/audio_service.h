#pragma once

#include <string>

class AudioService {
public:
    void importAudioFiles(const std::string& folderPath);
    
    std::string getAllAudioFiles();
};