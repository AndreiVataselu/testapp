//
//  SimulatedTableView.swift
//  testapp
//
//  Created by Andrei Vătășelu on 01/04/2020.
//  Copyright © 2020 Andrei Vataselu. All rights reserved.
//

import SwiftUI

struct SimulatedTableView: View {
    @ObservedObject var model: SimulatedTableViewVM = SimulatedTableViewVM()
    
    var body: some View {
        GeometryReader { globalProxy in
            ScrollView {
                ZStack {
                    GeometryReader { innerProxy -> Color in
                        let currentOffset = globalProxy.frame(in: .global).minY - innerProxy.frame(in: .global).minY
                        
                        self.model.decideIfShouldTriggerLoad(currentOffset: currentOffset,
                                                             scrollViewHeight: globalProxy.frame(in: .global).size.height,
                                                             scrollViewMaxY: innerProxy.frame(in: .global).size.height)
                        print("Offset: \(globalProxy.frame(in: .global).minY - innerProxy.frame(in: .global).minY)")
                        return Color.clear
                    }
                    
                    VStack {
                        ForEach(self.model.datasource, id: \.self) { element in
                            Text(element)
                        }
                    }
                }
            }
        }
    }
}

struct SimulatedTableView_Previews: PreviewProvider {
    static var previews: some View {
        SimulatedTableView()
    }
}
