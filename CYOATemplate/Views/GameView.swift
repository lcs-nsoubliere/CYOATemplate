//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI

struct GameView: View {
    
   
//    .contentShape(Rectangle())
    
    // how many nodes have been visited
    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) AS VisitedNodeCount FROM Node WHERE Node.visits > 0")
   })var notesVisitersStats
    
    @BlackbirdLiveQuery(tableName: "Node", { db in
        try await db.query("SELECT COUNT(*) AS TotalNodeCount FROM Node")
    })var totalNodeStats
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    
    // How the actual int value for now many nots have been visited
    var visitedNodes: Int {
        return notesVisitersStats.results.first?["VisitedNodeCount"]?.intValue ?? 0
    }
    
    var totalNodes: Int {
        return totalNodeStats.results.first?["TotalNodeCount"]?.intValue ?? 0
    }
    
    // MARK: Computed properties
    var body: some View {
        VStack(spacing: 10) {
           
            
//            Text("A total of \(visitedNodes) nodes have been in this story")
            
            Divider()
            HStack {
                Text("\(currentNodeId)")
                    .font(.largeTitle)
                Spacer()
            }
            
            NodeView(currentNodeId: currentNodeId)
            
            Divider()
            
            EdgesView(currentNodeId: $currentNodeId)
                        
            Spacer()
            
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
