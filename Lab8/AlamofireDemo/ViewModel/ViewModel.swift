//
//  ViewModel.swift
//  AlamofireDemo
//
//  Created by Artyom on 8.05.21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    
    var cancellation: AnyCancellable?
    let service = ApiService()
    
    func getComments(){
        cancellation = service.getComments()
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { comments in
                self.comments = CommentDatabase.shared.comments

                if CommentDatabase.shared.comments.isEmpty {
                    print("populating database")
                    CommentDatabase.shared.populateDatabase(commentsToBeSaved: comments)
                    self.comments = comments
                }
            })
    }
    
    func deleteComment(at index: IndexSet) {
        CommentDatabase.shared.deleteComment(comment: comments[index.first!])
        comments.remove(atOffsets: index)
    }
}
