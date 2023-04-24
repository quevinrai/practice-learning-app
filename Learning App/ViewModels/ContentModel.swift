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
    
    @Published var moduleType: String?
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
    
    // Function: Begin Lesson
    func beginLesson() {
        
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
