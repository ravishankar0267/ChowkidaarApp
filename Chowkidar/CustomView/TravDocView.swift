//
//  TravDocView.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 26/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class TravDocView: UIView {

    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aCloseButtonAction: UIButton!
    @IBOutlet weak var aIssueDateLabel: UILabel!
    @IBOutlet weak var aCounrtyLabel: UILabel!
    @IBOutlet weak var aExpiryDateLabel: UILabel!
    @IBOutlet weak var aDocumentLabel: UILabel!
    @IBOutlet weak var aUpdalodDocumentButton: UIButton!
    
    var closeActionClouser: (() -> Void) = { }
    var uploadDocActionClouser: (() -> Void) = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        closeActionClouser()
    }

    @IBAction func uploadDocButtonAction(_ sender: UIButton) {
        uploadDocActionClouser()
    }
    
    func updateDocData(section: TravelDocSection, documentData: Any) {
        switch section {
        case .passport:
            if let passportData = documentData as? PassportDataModel {
                if let passportResult = passportData.results {
                    if passportResult.count > 0 {
                        let passportInfo = passportResult[0]
                        aIssueDateLabel.text = passportInfo.issueDate
                        aCounrtyLabel.text = passportInfo.country
                        aExpiryDateLabel.text = passportInfo.expiryDate
                        aDocumentLabel.text = passportInfo.documentNo
                    }
                }
            }
        case .voterIdCard:
            if let voterIdData = documentData as? VoterIDDataModel {
                if let voterIdResult = voterIdData.results {
                    if voterIdResult.count > 0 {
                        let voterIDInfo = voterIdResult[0]
                        aIssueDateLabel.text = voterIDInfo.issueDate
                        aCounrtyLabel.text = voterIDInfo.country
                        aExpiryDateLabel.text = voterIDInfo.expiryDate
                        aDocumentLabel.text = voterIDInfo.documentNo
                    }
                }
            }
        case .visa:
            break
        case .panCard:
            break
        case .frequentFilerNo:
            break
        case .aadhar:
            if let aadharData = documentData as? AadharDataModel {
                if let aadharResult = aadharData.results {
                    if aadharResult.count > 0 {
                        let aadharInfo = aadharResult[0]
                        aIssueDateLabel.text = aadharInfo.issueDate
                        aCounrtyLabel.text = aadharInfo.country
                        aExpiryDateLabel.text = aadharInfo.expiryDate
                        aDocumentLabel.text = aadharInfo.documentNo
                    }
                }
            }
        }
    }
}
