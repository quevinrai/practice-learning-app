//
//  TextViewCode.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/22/23.
//

import SwiftUI

struct TextViewCode: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = model.codeText
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

struct TextViewCode_Previews: PreviewProvider {
    static var previews: some View {
        TextViewCode()
            .environmentObject(ContentModel())
    }
}
