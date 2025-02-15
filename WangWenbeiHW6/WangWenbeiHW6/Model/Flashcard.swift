//
//  Flashcard.swift
//  hw5
//
//  Created by 王文贝 on 2019/10/23.
//  Copyright © 2019 Wenbei Wang. All rights reserved.
//

import Foundation

struct Flashcard:Equatable {
    private var question : String
    private var answer : String
    public var isFavorite : Bool
    
    func getQuestion() -> String {
        return question
    }
    func getAnswer() -> String {
        return answer
    }
    init(question: String, answer: String, isFavorite: Bool=false){
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
    }
    
}


class FlashcardsModel: NSObject, FlashcardsDataModel {
    // singleton
    static let sharedInstance = FlashcardsModel()
    
    private var flashcards = [Flashcard]()
    private var currentIndex : Int?
    public var questionDisplayed : Bool
    override init() {
        self.currentIndex = 0
        //display question first
        self.questionDisplayed = true
        // need five flashcards
        let card1 = Flashcard(question: "Which chemical element is diamond made of?", answer: "Carbon")
        let card2 = Flashcard(question: "Which part of the body produces insulin?", answer: "Pancreas")
        let card3 = Flashcard(question: "Who wrote 'The Scarlet Letter'?", answer: "Nathaniel Hawthorne")
        let card4 = Flashcard(question: "What is the official language of Brazil?", answer: "Portuguese")
        let card5 = Flashcard(question: "How many books are there in the Harry Potter series?", answer: "Eight")
        
        self.flashcards = [card1, card2, card3, card4, card5]
    }
    func rearrageFlashcards(from: Int, to: Int) {
        let card = self.flashcard(at: from)
        if (card != nil) {
            self.removeFlashcard(at: from)
            self.insert(question: card?.getQuestion() ?? "", answer: card?.getQuestion() ?? "", favorite: card?.isFavorite ?? false, at: to)
        }
    }
    
    func checkAskedQuestion(potentialQuestion: String) -> Bool {
        for a in flashcards {
            if a.getQuestion().lowercased().contains(potentialQuestion.lowercased()){
                return true
            }
        }
        return false
    }
    
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    func randomFlashcard() -> Flashcard? {
        let num = flashcards.count
        
        if num > 0 {
            var index = Int.random(in: 0..<num)
            while index == currentIndex {
                index = Int.random(in: 0..<num)
            }
            currentIndex = index
            return flashcards[index]
        }
        return nil
    }
    
    func flashcard(at index: Int) -> Flashcard? {
        if index >= 0 && index < flashcards.count{
            return flashcards[index]
        }
        return nil
    }
    
    func nextFlashcard() -> Flashcard? {
        let current = currentIndex ?? -1
        if flashcards.count == 0 {
            return nil
        }
        if current >= 0 && current < flashcards.count - 1{
            currentIndex = current + 1
            return flashcards[current + 1]
        }
        else if current == flashcards.count - 1 {
            currentIndex = 0
            return flashcards[0]
        }
        return nil
    }
    
    func previousFlashcard() -> Flashcard? {
        let current = currentIndex ?? -1
        if flashcards.count == 0 {
            return nil
        }
        if current > 0 && current < flashcards.count {
            currentIndex = current - 1
            return flashcards[current - 1]
        }
        else if current == 0 {
            currentIndex = flashcards.count - 1
            return flashcards[flashcards.count - 1]
        }
        return nil
    }
    
    func insert(question: String, answer: String, favorite: Bool, at index: Int) {
        let fc = Flashcard(question:question, answer:answer, isFavorite: favorite)
        if index >= 0 && index <= flashcards.count {
            flashcards.insert(fc, at:index)
        }
        currentIndex = index
    }
    
    
    func currentFlashcard() -> Flashcard? {
        let current = currentIndex ?? -1
        if current >= 0 && current < flashcards.count {
            return flashcards[current]
        }
        return nil
    }
    
    func removeFlashcard(at index: Int) {
        if index >= 0 && index < flashcards.count {
            flashcards.remove(at:index)
        }
        else {
            flashcards.remove(at:flashcards.count - 1)
        }
        //set the current index to somewhere
        currentIndex = index - 1
    }
    
    func toggleFavorite() {
        let current = currentIndex ?? -1
        if current >= 0 && current < flashcards.count {
            flashcards[current].isFavorite = !flashcards[current].isFavorite
        }
    }
    
    func favoriteFlashcards() -> [Flashcard] {
        var fav = [Flashcard]()
        for card in flashcards {
            fav.insert(card,at:fav.count)
        }
        return fav
    }
    
     
}

