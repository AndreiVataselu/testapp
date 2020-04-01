//
//  SimulatedTableViewVM.swift
//  testapp
//
//  Created by Andrei Vătășelu on 01/04/2020.
//  Copyright © 2020 Andrei Vataselu. All rights reserved.
//

import Foundation
import UIKit

class SimulatedTableViewVM: ObservableObject {
    @Published var datasource: [String] = Array(repeating: "Hello World!", count: 100)
    private var mockedResponses = ["Some response", "Mexican popcorn", "Hernan Crespo", "Kevin De Bruyne", "taco bell"]
    private var loadingData = false
    
    private func triggerLoad() {
        guard !loadingData else {
            return
        }
        
        loadingData = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            print("Should load next page!!")
            guard let mockedResp = self?.mockedResponses else {
                return
            }
            
            self?.datasource.append(contentsOf: Array(repeating: mockedResp[Int(arc4random_uniform(UInt32(mockedResp.count)))], count: 30))
            self?.loadingData = false
        }
    }
    
    func decideIfShouldTriggerLoad(currentOffset: CGFloat, scrollViewHeight: CGFloat, scrollViewMaxY: CGFloat) {
        if currentOffset >= (scrollViewMaxY - scrollViewHeight) * 0.7 {
            triggerLoad()
        }
    }
}
