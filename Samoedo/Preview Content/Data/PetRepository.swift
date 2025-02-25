//
//  PetRepository.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation

class PetRepository {
    private let PET_KEY = "PET_KEY"
    private var cachedPet: Pet?
    private let userDefaults = UserDefaults.standard

    init() {
        if let data = userDefaults.data(forKey: PET_KEY),
           let decoded = try? JSONDecoder().decode(Pet.self, from: data) {
            self.cachedPet = decoded
            print("✅ Pet data successfully retrieved from UserDefaults!")
        } else {
            self.cachedPet = Pet(name: "Samoyed", lastMeal: Date())
        }
        
        let storyRepo = StoryRepository()
        if storyRepo.hasSeenOpening(), cachedPet?.birthday == nil {
            cachedPet?.birthday = Date()
            saveData()
        }
    }

    func loadData() -> Pet {
        if let pet = cachedPet {
            return pet
        }
        
        if let data = userDefaults.data(forKey: PET_KEY),
           let decoded = try? JSONDecoder().decode(Pet.self, from: data) {
            cachedPet = decoded
            return decoded
        }

        let defaultPet = Pet(name: "Samoyed", lastMeal: Date())  // 默认宠物
        cachedPet = defaultPet
        return defaultPet
    }


    func saveData(pet: Pet? = nil) {
        let petToSave = pet ?? cachedPet
        guard let pet = petToSave else { return }

        if let encoded = try? JSONEncoder().encode(pet) {
            userDefaults.set(encoded, forKey: PET_KEY)
            cachedPet = pet 
            print("✅ Pet data saved at \(Date().formatted(date: .omitted, time: .standard))")
        }
    }
}
