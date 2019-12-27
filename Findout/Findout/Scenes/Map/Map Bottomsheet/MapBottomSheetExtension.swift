//
//  MapBottomSheetExtension.swift
//  Findout
//
//  Created by Ramzy Kermad on 26/12/2019.
//  Copyright © 2019 Ramzy Kermad. All rights reserved.
//

import Foundation
import UIKit


extension PlacesScreenViewController{
    
    func setBottomSheetViewsConstraints(){
        setCloseButtonConstraint()
        setPlaceImageConstraints()
        setPlaceNameAndAdressConstraints()
        setRatingConstraints()
        setDisponibilitiesConstraints()
    }
    
    private func setCloseButtonConstraint(){
        self.bottomSheetView.addSubview(self.closeBottomSheet)
        NSLayoutConstraint.activate([
            self.closeBottomSheet.rightAnchor.constraint(equalTo: bottomSheetView.rightAnchor, constant: -15),
            self.closeBottomSheet.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 15),
        ])
    }
    
    private func setPlaceImageConstraints(){
        placeImageViewCtn.frame = CGRect(x: 10, y: 30, width: 100, height: 100)
        placeImageViewCtn.addSubview(self.placeImage)
        placeImageViewCtn.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        self.bottomSheetView.addSubview(placeImageViewCtn)
        
        NSLayoutConstraint.activate([
            self.placeImage.leftAnchor.constraint(equalTo: placeImageViewCtn.leftAnchor, constant: 0),
            self.placeImage.topAnchor.constraint(equalTo: placeImageViewCtn.topAnchor, constant: 0),
        ])
    }
    
    private func setPlaceNameAndAdressConstraints(){
        let width = self.view.frame.width - placeImageViewCtn.frame.width - 30
        
        self.bottomSheetView.addSubview(placeName)
        self.bottomSheetView.addSubview(placeAdress)
        
        NSLayoutConstraint.activate([
            placeName.leftAnchor.constraint(equalTo: placeImageViewCtn.rightAnchor, constant: 10),
            placeName.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 30),
            
            placeAdress.leftAnchor.constraint(equalTo: placeImageViewCtn.rightAnchor, constant: 10),
            placeAdress.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 15),
            
            placeName.heightAnchor.constraint(equalToConstant: 30),
            placeName.widthAnchor.constraint(equalToConstant: width),
            
            placeAdress.heightAnchor.constraint(equalToConstant: 30),
            placeAdress.widthAnchor.constraint(equalToConstant: width),
        ])
    }
    
    private func setRatingConstraints(){
        self.bottomSheetView.addSubview(placeRating)
        NSLayoutConstraint.activate([
            placeRating.leftAnchor.constraint(equalTo: placeImageViewCtn.rightAnchor, constant: 10),
            placeRating.topAnchor.constraint(equalTo: placeAdress.bottomAnchor, constant: 10),
            
            placeRating.heightAnchor.constraint(equalToConstant: 30),
            placeRating.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setDisponibilitiesConstraints(){
        let width = self.view.frame.width - placeImageViewCtn.frame.width - 30
        
        self.bottomSheetView.addSubview(placeDisponitbilitiesTitle)
        self.bottomSheetView.addSubview(placeDisponobolitiesStartTime)
        self.bottomSheetView.addSubview(placeDisponobolitiesEndTime)
        
        NSLayoutConstraint.activate([
            placeDisponitbilitiesTitle.leftAnchor.constraint(equalTo: placeImageViewCtn.rightAnchor, constant: 10),
            placeDisponitbilitiesTitle.topAnchor.constraint(equalTo: placeRating.bottomAnchor, constant: 25),
            
            placeDisponobolitiesStartTime.leftAnchor.constraint(equalTo: placeImageViewCtn.rightAnchor, constant: 10),
            placeDisponobolitiesStartTime.topAnchor.constraint(equalTo: placeDisponitbilitiesTitle.bottomAnchor, constant: 10),
            
            placeDisponobolitiesEndTime.leftAnchor.constraint(equalTo: placeImageViewCtn.rightAnchor, constant: 10),
            placeDisponobolitiesEndTime.topAnchor.constraint(equalTo: placeDisponobolitiesStartTime.bottomAnchor, constant: 10),
            
            placeDisponitbilitiesTitle.heightAnchor.constraint(equalToConstant: 30),
            placeDisponitbilitiesTitle.widthAnchor.constraint(equalToConstant: width),
            
            placeDisponobolitiesStartTime.heightAnchor.constraint(equalToConstant: 30),
            placeDisponobolitiesStartTime.widthAnchor.constraint(equalToConstant: width),
            
            placeDisponobolitiesEndTime.heightAnchor.constraint(equalToConstant: 30),
            placeDisponobolitiesEndTime.widthAnchor.constraint(equalToConstant: width),
        ])
    }
}
