//
//  PostsView.swift
//  AlamofireDemo
//
//  Created by Artyom on 8.05.21.
//

import SwiftUI

struct CommentsView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack{
            List{
                ForEach(self.viewModel.comments, id: \.self.id){post in
                    VStack(alignment: .leading, spacing: 5){
                        Text(post.name)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .bold()
                        Text(post.email)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .bold()
                        Text(post.body)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }.onDelete(perform: { indexSet in
                    self.viewModel.deleteComment(at: indexSet);
                })
            }.onAppear(perform: {
                self.viewModel.getComments()
            })
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView().environmentObject(ViewModel())
    }
}
