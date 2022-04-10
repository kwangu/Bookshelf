//
//  DetailRepository.swift
//  Bookshelf
//
//  Created by 강관구 on 2022/04/10.
//

import Foundation
import UIKit
import CoreData

class DetailRepository {
    private var container: NSPersistentContainer?

    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.container = appDelegate?.persistentContainer
    }

    func detailBookInfo(url: String, completionHandler: @escaping (DetailModel) -> Void) {
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            guard let output = try? JSONDecoder().decode(DetailModel.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }

            completionHandler(output)
        }.resume()
    }

    func fetchNote(isbn13: String, completionHandler: @escaping (String) -> Void) {
        guard let noteModel = self.getNote(isbn13: isbn13) else { return }

        completionHandler(noteModel.content ?? "")
    }

    func saveNote(isbn13: String, note: String, completionHandler: @escaping (Bool) -> Void) {
        guard let container = self.container else { return }

        if let noteModel = self.getNote(isbn13: isbn13) {

            noteModel.content = note

        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: container.viewContext) else { return }

            let noteModel = NSManagedObject(entity: entity, insertInto: container.viewContext)
            noteModel.setValue(note, forKey: "content")
            noteModel.setValue(isbn13, forKey: "isbn13")
        }

        do {
            try container.viewContext.save()
            completionHandler(true)
        } catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
    }

    func deleteNote(isbn13: String, completionHandler: @escaping (Bool) -> Void) {
        if let noteModel = getNote(isbn13: isbn13) {
            guard let container = self.container else { return }

            container.viewContext.delete(noteModel)

            do {
                try container.viewContext.save()
                completionHandler(true)
            } catch {
                print(error.localizedDescription)
                completionHandler(false)
            }

        }
    }

    private func getNote(isbn13: String) -> Note? {
        do {
            guard let container = self.container else { return nil }
            guard let note = try container.viewContext.fetch(Note.fetchRequest()) as? [Note] else { return nil}

            let bookNote = note.first { $0.isbn13 == isbn13}
            return bookNote

        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}
