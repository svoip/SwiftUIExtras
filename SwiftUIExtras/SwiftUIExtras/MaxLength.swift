//
//  MaxLength.swift
//  SwiftUIExtras
//
//  Created by Sardorbek Ruzmatov on 04/02/26.
//


import SwiftUI

// 1. Define the view modifier
struct MaxLength: ViewModifier {
    let length: Int
    @Binding var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .onAppear(perform: onAppear)
        
            Text("\(text.count)/\(length)")
                // move the text below the Textfield view
                .offset(y: 16)
                .font(.caption)
                .onChange(of: text) { newText in
                   adaptText(to: newText)
                }
        }
    }
    private func onAppear(){
        adaptText(to: text)
    }
    
    private func adaptText(to input: String){
        if input.count > length {
            self.text = String(input.prefix(length))
        }
    }
}

// 2. & 3. Restrict the use of the modifier for certain types
extension View where Self == TextField<Text> {
    func maxLength(_ length: Int, text: Binding<String>) -> some View {
        self.modifier(MaxLength(length: length, text: text))
    }
}

// 4. Alternatively, use no such restriction
//extension View {
//    func maxLength(_ length: Int, text: Binding<String>) -> some View {
//        self.modifier(MaxLength(length: length, text: text))
//    }
//}

struct MaxLengthContentView: View {
    @State var text = ""
    let hint = "This is a hint"
    
    var body: some View {
        HStack {
            Spacer()
            
            TextField(hint, text: $text)
                .maxLength(10, text: $text)
            
            Spacer()
        }
    }
}

#Preview {
   MaxLengthContentView()
}
