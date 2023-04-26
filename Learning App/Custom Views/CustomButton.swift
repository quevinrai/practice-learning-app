//
//  CustomButton.swift
//  Learning App
//
//  Created by Quevin Bambasi on 4/25/23.
//

import SwiftUI

struct CustomButton: View {
    @EnvironmentObject var model: ContentModel
    var executeButtonAction: () -> ()
    var customText: String
    var bgColor: Color
    var txtColor: Color
    
    var body: some View {
        Button {
            executeButtonAction()
        } label: {
            Text(customText)
        }
        .buttonStyle(CustomButtonStyle(bgColor: bgColor, txtColor: txtColor))
    }
}

struct CustomButtonStyle: ButtonStyle {
    let bgColor: Color
    let txtColor: Color
    
    init(bgColor: Color = .white, txtColor: Color = .black) {
        self.bgColor = bgColor
        self.txtColor = txtColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(bgColor)
            .foregroundColor(txtColor)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(executeButtonAction: {}, customText: "", bgColor: .white, txtColor: .black)
            .environmentObject(ContentModel())
    }
}
