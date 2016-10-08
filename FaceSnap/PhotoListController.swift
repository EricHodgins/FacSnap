//
//  ViewController.swift
//  FaceSnap
//
//  Created by Eric Hodgins on 2016-09-24.
//  Copyright © 2016 Eric Hodgins. All rights reserved.
//

import UIKit

class PhotoListController: UIViewController {
    
    lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Camera", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(red: 254/255.0, green: 123/255.0, blue: 135/255.0, alpha: 1.0)
        
        button.addTarget(self, action: #selector(PhotoListController.presentImagePickerController), for: .touchUpInside)
        return button
    }()
    
    lazy var mediaPickerManager: MediaPickerManager = {
        let manager = MediaPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    lazy var dataSource: PhotoDataSource = {
        return PhotoDataSource(fetchRequest: Photo.allPhotosRequest, collectionView: self.collectionView)
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        let screenWidth = UIScreen.main.bounds.size.width
        let paddingDistance: CGFloat = 16.0
        let itemSize = (screenWidth - paddingDistance)/2.0
        
        collectionViewLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        collectionView.dataSource = dataSource
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        view.addSubview(collectionView) // Adding subviews matters!
        view.addSubview(cameraButton)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Layout Code
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cameraButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cameraButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            cameraButton.heightAnchor.constraint(equalToConstant: 56.0)
        ])
    }
    
    //MARK: - Image Picker Controller

    func presentImagePickerController() {
        mediaPickerManager.presentImagePickerController(animated: true)
    }
    
}

//MARK: - MediaPickerManagerDelegate

extension PhotoListController: MediaPickerManagerDelegate {
    func mediaPickerManager(_ manager: MediaPickerManager, didFinishPickingImage image: UIImage) {
        
        let eaglContext = EAGLContext(api: .openGLES2)!
        let ciContext = CIContext(eaglContext: eaglContext)
        let photoFilterController = PhotoFilterController(image: image, context: ciContext, eaglContext: eaglContext)
        let navigationController = UINavigationController(rootViewController: photoFilterController)
        
        manager.dismissImageController(animated: true) { 
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}

// MARK: - Navigation 

extension PhotoListController {
    
    func setupNavigationBar() {
        let sortTagsButton = UIBarButtonItem(title: "Tags", style: .plain, target: self, action: #selector(PhotoListController.presentSortController))
        navigationItem.setRightBarButtonItems([sortTagsButton], animated: true)
    }
    
    func presentSortController() {
        let tagDataSource = SortableDataSource<Tag>(fetchRequest: Tag.allTagsRequest, managedObjectContex: CoreDataController.sharedInstance.managedObjectContext)
        let sortItemSelector = SortItemSelector(sortItems: tagDataSource.results)
        let sortController = PhotoSortListController(dataSource: tagDataSource, sortItemSelector: sortItemSelector)
        let navigtationController = UINavigationController(rootViewController: sortController)
        present(navigtationController, animated: true, completion: nil)
    }
}




















