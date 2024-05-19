//
//  SwiftUIView.swift
//  
//
//  Created by Phyo on 18/5/24

import SwiftUI
import WebKit

public struct HTMLView: UIViewRepresentable {
    private var htmlContent: String
    private var cssFiles: [String]
    private var jsFiles: [String]
    private var baseURL: URL?
    public var disableScroll: Bool
    public var backgroundColor: UIColor
    
    public init(_ htmlContent: String, cssFiles: [String] = [], jsFiles: [String] = [], disableScroll: Bool = true, backgroundColor: UIColor = .white) {
        self.htmlContent = htmlContent
        self.cssFiles = cssFiles
        self.jsFiles = jsFiles
        self.baseURL = Bundle.main.bundleURL
        self.disableScroll = disableScroll
        self.backgroundColor = backgroundColor
    }
    
    public static func fromFile(_ filename: String, cssFiles: [String] = [], jsFiles: [String] = [], bundle: Bundle = .main) -> HTMLView {
        let filepath = bundle.path(forResource: filename, ofType: "html")
        let htmlContent = (try? String(contentsOfFile: filepath ?? "")) ?? "Failed to load content"
        return HTMLView(htmlContent, cssFiles: cssFiles, jsFiles: jsFiles)
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = !disableScroll
        webView.backgroundColor = backgroundColor
        webView.isOpaque = false
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        let fullHTML = buildFullHTML(content: htmlContent, cssFiles: cssFiles, jsFiles: jsFiles)
        webView.loadHTMLString(fullHTML, baseURL: baseURL)
    }
    
    public func buildFullHTML(content: String, cssFiles: [String], jsFiles: [String]) -> String {
        var fullHTML = "<html><head>"
        for cssFile in cssFiles {
            fullHTML += "<link rel=\"stylesheet\" type=\"text/css\" href=\"\(cssFile)\">"
        }
        for jsFile in jsFiles {
            fullHTML += "<script src=\"\(jsFile)\"></script>"
        }
        fullHTML += "</head><body>\(content)</body></html>"
        return fullHTML
    }
    
    // post instantiation config
    public func scrollDisabled(_ disabled: Bool) -> HTMLView {
        var view = self
        view.disableScroll = disabled
        return view
    }
    
    public func backgroundColor(_ color: UIColor) -> HTMLView {
        var view = self
        view.backgroundColor = color
        return view
    }
}
