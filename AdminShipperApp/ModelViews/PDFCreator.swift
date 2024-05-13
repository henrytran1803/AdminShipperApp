//
//  PDFCreator.swift
//  AdminShipperApp
//
//  Created by Tran Viet Anh on 30/04/2024.
//

import Foundation
import SwiftUI
import PDFKit
class PDFCreator: ObservableObject {
    @Published var documentData: Data?
    @Published var showShareSheet = false
    @Published var isLoading = false

    func createAndSavePDF(with data: [Oder]) {
        guard !data.isEmpty else {
            print("No data to export")
            return
        }

        DispatchQueue.global().async {
            let pdfMetaData = [
                kCGPDFContextCreator: "AppOrderFood",
                kCGPDFContextAuthor: "author name"
            ]
            let format = UIGraphicsPDFRendererFormat()
            format.documentInfo = pdfMetaData as [String: Any]

            let pageSize = CGSize(width: 595, height: 842)
            let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize), format: format)

            let data = renderer.pdfData { context in
                for order in data {
                    context.beginPage()
                    let orderInfo = order.orderDescription()
                    orderInfo.draw(in: CGRect(x: 20, y: 20, width: pageSize.width - 40, height: pageSize.height - 40))
                }
            }

            guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let pdfPath = documentsPath.appendingPathComponent("output.pdf")
            try? data.write(to: pdfPath)

            DispatchQueue.main.async {
                self.documentData = data
                self.showShareSheet = true
            }
        }
    }
}
extension Oder {
    func orderDescription() -> NSAttributedString {
        let boldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]
        
        let description = NSMutableAttributedString()
        
        description.append(NSAttributedString(string: "Order ID: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.hashValue)\n"))
        
        description.append(NSAttributedString(string: "Customer: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.name)\n"))
        
        description.append(NSAttributedString(string: "Total: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.total)\n"))
        
        description.append(NSAttributedString(string: "Address: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.adress)\n"))
        
        description.append(NSAttributedString(string: "Discount: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.discount)\n"))
        
        description.append(NSAttributedString(string: "Date: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.date)\n"))
        
        description.append(NSAttributedString(string: "Status: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.status.rawValue)\n"))
        
        description.append(NSAttributedString(string: "Payment: ", attributes: boldAttributes))
        description.append(NSAttributedString(string: "\(self.payment)\n"))
        
        return description
    }
}
