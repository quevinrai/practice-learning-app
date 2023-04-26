//
//  ContentModel.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/20/23.
//

import Foundation
import SwiftUI

enum AppView: Hashable {
    case contentView(Int), contentViewDetail(Int), testView(Int), testViewResult(Int)
}

class ContentModel: ObservableObject {
    // MARK: - Properties
    @Published var modules = [Module]()
    @Published var path = NavigationPath()
    
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    //MARK: - Init
    init() {
        getLocalData()
        getRemoteData()
    }
    
    // MARK: - Methods
    
    // Function: Get Local JSON Data
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        if let url = jsonUrl {
            do {
                let data = try Data(contentsOf: url)
                
                do {
                    let decoder = JSONDecoder()
                    let moduleData = try decoder.decode([Module].self, from: data)
                    
                    self.modules = moduleData
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        if let url = styleUrl {
            do {
                let data = try Data(contentsOf: url)
                
                self.styleData = data
            } catch {
                print(error)
            }
        }
    }
    
    // Function: Get Remote JSON Data
    func getRemoteData() {
        let urlString = "https://quevinrai.github.io/learningapp-data/data2.json"
        
        let url = URL(string: urlString)
        
        if let url = url {
            let request = URLRequest(url: url)
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    let modules = try decoder.decode([Module].self, from: data!)
                    
                    DispatchQueue.main.async {
                        self.modules += modules
                    }
                } catch {
                    print(error)
                }
            }
            
            dataTask.resume()
        }
    }
    
    // Function: Begin Module
    func beginModule(_ moduleId: Int) {
        currentModuleIndex = modules.firstIndex(where: { $0.id == moduleId }) ?? 0
        
        currentModule = modules[currentModuleIndex]
    }
    
    // Function: Begin Lesson
    func beginLesson(_ lessonId: Int) {
        currentLessonIndex = currentModule?.content.lessons.firstIndex(where: { $0.id == lessonId }) ?? 0
        currentLesson = currentModule?.content.lessons[currentLessonIndex]
        
        codeText = addStyling(currentLesson?.explanation ?? "")
    }
    
    // Function: Check if there's a next lesson
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    // Function: Advance to the next lesson
    func nextLesson() {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    // Function: Begin Test
    func beginTest(_ questionId: Int) {
        currentQuestionIndex = currentModule?.test.questions.firstIndex(where: { $0.id == questionId}) ?? 0
        currentQuestion = currentModule?.test.questions[currentQuestionIndex]
        
        codeText = addStyling(currentQuestion?.content ?? "")
    }
    
    // Function: Advance to the next question
    func nextQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion?.content ?? "")
        }
        else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // Function: Add HTML & CSS Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        if let styleData = self.styleData {
            data.append(styleData)
            data.append(Data(htmlString.utf8))
            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                resultString = attributedString
            }
        }
        
        return resultString
    }
}
