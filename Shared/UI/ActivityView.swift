//
//  ActivityView.swift
//  BmPhotoEffects
//
//  Created by Aung Ko Min on 14/3/22.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    private var activities: [AnyObject]
    
    init(_ activities: [AnyObject]) {
        self.activities = activities
    }
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let shareViewController = UIActivityViewController(
            activityItems: activities,
            applicationActivities: nil
        )
        shareViewController.modalPresentationStyle = .fullScreen
        return shareViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
