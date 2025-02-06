//
//  JournalViewModel.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation
import SwiftUI

extension MainView{
    class ViewModel: ObservableObject {
        @Published var pet: Pet
        private var repository = PetRepository()
        
        init() {
            pet = repository.loadData()
        }
        
        func saveData() {
            objectWillChange.send()
            repository.saveData(pet: pet)
        }
        
        func feed() {
            pet.lastMeal = Date()
            saveData()
        }
        
        func didTapSamoyed() {
            // 这里填写点击萨摩耶后的逻辑
            print("萨摩耶被点击了！")
        }
    }
}


