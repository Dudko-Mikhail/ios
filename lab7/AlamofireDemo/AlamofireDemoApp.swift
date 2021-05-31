//
//  AlamofireDemoApp.swift
//  AlamofireDemo
//
//  Created by Ivan on 13.05.21.
//

import SwiftUI

@main
struct AlamofireDemoApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            CommentsView()
                .environmentObject(viewModel)
        }
    }
}
