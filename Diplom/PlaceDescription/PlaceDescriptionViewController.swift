//
//  PlaceDescriptionViewController.swift
//  Diplom
//
//  Created by Махова Татьяна on 15.03.2023.
//

import UIKit

class PlaceDescriptionViewController: UIViewController {
    
    @IBOutlet weak var placeImagesCollectionView: UICollectionView!
    @IBOutlet weak var namePlaceLabel: UILabel!
    
    @IBOutlet weak var adresPlaceLabel: UILabel!
    
    let placeId: String
    
    var currentPlace: Place?
    
    
    
    init(placeId: String) {
        self.placeId = placeId
        super.init(nibName: nil, bundle: nil)
    }
    
    private func getPlace(placecArray: [ Place ] ) {
        guard let place = placecArray.filter({$0.id == placeId}).first else { return }
        currentPlace = place
        
        setupControllerFields()
    }
    private func setupControllerFields() {
        namePlaceLabel.text = currentPlace?.name
        placeImagesCollectionView.reloadData()
        adresPlaceLabel.text = currentPlace?.adres
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getAllPlacec()
        setupCollectionView()
    }
    
    private func getAllPlacec() {
        APIManager.shared.getPlacec { [ weak self ] placeFromFirebase in
            self?.getPlace(placecArray: placeFromFirebase)
        }
    }
   
    private func setupCollectionView() {
        let nib = UINib(nibName: String(describing: PlaceImagesCollectionViewCell.self), bundle: nil)
        placeImagesCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: PlaceImagesCollectionViewCell.self))
        placeImagesCollectionView.dataSource = self
        placeImagesCollectionView.delegate = self
        
    }
    
    
}

extension PlaceDescriptionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = currentPlace?.imageURLString?.count else { return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlaceImagesCollectionViewCell.self) , for: indexPath)
        guard let imageCell = cell as? PlaceImagesCollectionViewCell else { return cell }
        guard let imageURL = currentPlace?.imageURLString?[indexPath.row] else { return imageCell }
        imageCell.setupCell(URLString: imageURL)
        return imageCell
    }
    
    
}
extension PlaceDescriptionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 200)
    }
    
}
