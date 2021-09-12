//
//  HeaderView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 12/9/21.
//

import SwiftUI

struct HeaderView: View {
    let saveKey = "DateOfLastVisit"
    let dateFormatter: DateFormatter = DateFormatter()
    
    /// Private properties that causes view refresh
    @State var dateOfLastVisit: Date = UserRepository().getDateOfLastVisit() ?? Date()
    
    init() {
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
    }
    
    var body: some View {
        Text("Last Visit: " + dateFormatter.string(from: dateOfLastVisit))
            .font(.footnote)
            .onAppear {
                UserRepository().saveDateOfLastVisit(date: Date())
            }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
