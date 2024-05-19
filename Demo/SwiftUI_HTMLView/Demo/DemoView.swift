//
//  ContentView.swift
//  SwiftUI_HTMLView
//
//  Created by Phyo on 18/5/24.
//

import SwiftUI

struct DemoView: View {
    var body: some View {
        
        // Inline
        HTMLView("<h1 style='color:white; text-align: center;  position: relative; top: 30%;'>HTML-VIEW</h1>")
            .scrollDisabled(false)
            .backgroundColor(.brown)
            .frame(height: 60)
        
        
        // Inline with external CSS
        HTMLView("<h2>Hello World! with external-CSS</h2>",
                 cssFiles: ["style.css"])
        .frame(height: 100)
        
        
        // Load from bundle
        HTMLView.fromFile("html_test",
                          cssFiles: ["style.css"],
                          jsFiles: ["script.js"])
        .frame(height: 140)
        
        Spacer()
    }
}

#Preview {
    DemoView()
}
