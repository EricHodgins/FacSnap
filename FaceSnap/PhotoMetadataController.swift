//
//  PhotoMetadataController.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-10-03.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class PhotoMetadataController: UITableViewController {
    
    private let photo: UIImage
    
    init(photo: UIImage) {
        self.photo = photo
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Metadata Fields
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(image: self.photo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageViewHeight: CGFloat = {
        let imgFactor = self.photoImageView.frame.size.height / self.photoImageView.frame.size.width // aspect ratio
        let screenWidth = UIScreen.main.bounds.size.width
        
        return screenWidth * imgFactor
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

extension PhotoMetadataController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell.contentView.addSubview(photoImageView)
            
            NSLayoutConstraint.activate([
                photoImageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                photoImageView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor),
                photoImageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                photoImageView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor)
            ])
            
        default:
            break
        }
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate 

extension PhotoMetadataController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return imageViewHeight
        default:
            return tableView.rowHeight
        }
    }
}


































