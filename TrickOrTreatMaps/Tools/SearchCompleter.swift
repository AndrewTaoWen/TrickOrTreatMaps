//
//  SearchCompleter.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import Foundation
import MapKit
import SwiftUI

public class LocalSearchCompleterDelegate: NSObject, MKLocalSearchCompleterDelegate {
    static let shared = LocalSearchCompleterDelegate()
    var completionHandler: (([String]) -> Void)?
    
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.map { $0.title }
        completionHandler?(results)
    }
}
