//
//  ViewModel.swift
//  AlamofireDemo
//
//  Created by Ivan on 13.05.21.
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
                print("errGetComments \(error)")
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { comments in
                self.comments = comments
                print("comments \(comments)")
            })
    }
    
    func deleteComment(at index: IndexSet) {
        comments.remove(atOffsets: index)
    }
}
