//
//  AlamofireDemoApp.swift
//  AlamofireDemo
//
//  Created by Artyom on 8.05.21.
//

import SwiftUI

@main
struct AlamofireDemoApp: App {
    @StateObject var viewModel = ViewModel()
    let db = CommentDatabase.shared
    
    var body: some Scene {
        WindowGroup {
            CommentsView()
                .environmentObject(viewModel)
        }
    }
}
