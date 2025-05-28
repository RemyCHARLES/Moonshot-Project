// page_model.h

#pragma once
#include <string>
#include <vector>

// Définition du modèle Page
class Page {
public:
    int id;               // ID unique de la page
    std::string question; // Question ou contenu de la page
    std::vector<std::string> options;  // Options possibles pour une question de type choix multiple
    int correctIndex;     // Index de la réponse correcte
    std::string explanation; // Explication de la bonne réponse

    Page(int id, const std::string& question)
        : id(id), question(question) {}
};