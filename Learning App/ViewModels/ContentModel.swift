//
//  ContentModel.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/20/23.
//

import Foundation
import SwiftUI

enum AppView {
    case contentView, contentViewDetail, testView, testViewResult
}

class ContentModel: ObservableObject {
    // MARK: - Properties
    @Published var modules = [Module]()
    @Published var path = [AppView]()
    
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // MARK: - Methods
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
    
    //MARK: - Init
    init() {
        getLocalData()
    }
}
