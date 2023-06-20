//
//  OnBoardingItem.swift
//  CestaDaCica
//
//  Created by Grazi  Berti on 19/06/23.
//

import Foundation
import Lottie

// MARK: - OnBoarding Item Model
struct OnBoardingItem: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var lottieView: AnimationView = .init()
}
