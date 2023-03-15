//
//  PlaceDescriptionViewController.swift
//  Diplom
//
//  Created by Махова Татьяна on 15.03.2023.
//

import UIKit

class PlaceDescriptionViewController: UIViewController {

    let placeId: String
    
    init(placeId: String) {
        self.placeId = placeId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
       
        print(placeId)
        
    }
    
    private func getAllPlacec() {
        
    }
    
    
    
}
