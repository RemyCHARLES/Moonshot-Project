// src/models/page_model.h
// -------------------------------------------
// Beatquest – Page Model for Lessons and Quizzes
// -------------------------------------------
// This header defines the Page class used to represent a single
// page in a lesson or a quiz question. It supports multiple-choice
// formats with a question, multiple options, a correct answer index,
// and an explanation.
//
// This model is used during session playback, lesson rendering,
// and user response analysis.
//
// Dependencies: <string>, <vector>
// -------------------------------------------

#pragma once

#include <string>   // For std::string
#include <vector>   // For std::vector

// -------------------------------------------
// Page
// Represents a lesson step or quiz question.
// -------------------------------------------
class Page {
public:
    int id;                         // Unique identifier for the page
    std::string question;           // Main question text or lesson content
    std::vector<std::string> options;  // List of answer options (for quizzes)
    int correctIndex;               // Index of the correct answer in `options`
    std::string explanation;       // Explanation of the correct answer

    // Constructor to initialize a Page with ID and question text
    Page(int id, const std::string& question)
        : id(id), question(question) {}
};