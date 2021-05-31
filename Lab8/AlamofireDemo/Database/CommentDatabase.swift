//
//  Comments.swift
//  AlamofireDemo
//
//  Created by Artyom on 13.05.21.
//

import SQLite

class CommentDatabase {
    static let shared = CommentDatabase()
    public let connection: Connection?
    var comments: [Comment] = []
    
    let commentsQuery = Table("comments")
    
    private init() {
        do {
            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("comments3.sqlite")
            
            connection = try Connection(fileURL.path)
            initDatabase()
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database. Error is: \(nserror), \(nserror.userInfo)")
        } 
    }
    
    private func initDatabase() {
        let id = Expression<Int64>("id")
        let postId = Expression<Int64>("postId")
        let email = Expression<String>("email")
        let name = Expression<String>("name")
        let body = Expression<String>("body")
        
        do {
            try connection!.run(commentsQuery.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(postId)
                t.column(email)
                t.column(name)
                t.column(body)
            })

            for comment in try connection!.prepare(commentsQuery) {
                comments.append(
                    Comment(
                        postId: Int(comment[postId]),
                        id: Int(comment[id]),
                        name: comment[name],
                        email: comment[email],
                        body: comment[body]
                    )
                )
            }
        } catch {
            print(error)
        }
    }
    
    func populateDatabase(commentsToBeSaved: [Comment]) {
        do {
            for comment in commentsToBeSaved {
                try connection!.run(
                    commentsQuery.insert(comment)
                )
            }
        } catch {
            print(error)
        }
    }
    
    func deleteComment(comment: Comment) {
        do {
            let id = Expression<Int>("id")
            let commentDeleteQuery = commentsQuery.filter(id == comment.id)
            let rows = try connection!.run(commentDeleteQuery.delete())
            print(rows)
        } catch {
            print(error)
        }
    }
}
