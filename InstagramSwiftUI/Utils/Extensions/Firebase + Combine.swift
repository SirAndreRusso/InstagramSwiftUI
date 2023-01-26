//
//  Firebase + Combine.swift
//  InstagramSwiftUI
//
//  Created by Андрей Русин on 23.01.2023.
//

import SwiftUI
import Combine
import Firebase

extension DocumentReference {
    func toAnyPublisher<T: Decodable>() -> AnyPublisher<T?, Error> {
        let subject = CurrentValueSubject<T?, Error>(nil)
        
        let listener = addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                subject.send(completion: .failure(error!))
                return
            }
            
            guard let data = try? document.data(as: T.self) else {
                subject.send(nil)
                return
            }
            subject.send(data)
        }
        
        return subject.handleEvents(receiveCancel: {
            listener.remove()
        }).eraseToAnyPublisher()
    }
}
