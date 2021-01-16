//
//  DatePickerTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct DatePickerTestView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @State private var birthDate = Date()
    
    var body: some View {
        VStack {
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }
//            .datePickerStyle(GraphicalDatePickerStyle())
            
            Text("Date is \(birthDate, formatter: dateFormatter)") // format dates inside text views
        }.navigationTitle("DatePicker")
    }
}

struct DatePickerTestView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerTestView()
    }
}
