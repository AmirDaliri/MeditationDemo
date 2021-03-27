//
//  String+Extension.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation

extension String {
    
    func timeStampToDate(with format: String = "yyyy-MM-dd' 'HH:mm") -> String? {
        guard let timeResult = Double(self) else {
            return nil
        }
        let date = Date(timeIntervalSince1970: timeResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
