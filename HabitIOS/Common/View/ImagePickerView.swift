//
//  ImagePicker.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 19/06/26.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var image: Image?
    @Binding var imageData: Data?
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isPresented: $isPresented, image: $image, imageData: $imageData)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        
        // Qualquer tipo que eu passar se nao estiver disponivel eu abro a galeria
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerController.sourceType = .photoLibrary
        } else {
            pickerController.sourceType = sourceType
        }
        
        pickerController.delegate = context.coordinator
        
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No update needed for now
    }
}

// A Imagem que retornar sera renderizada e administrada por essa classe
class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // Adicione callbacks, manipulação de imagem etc aqui se necessário
    
    @Binding var isPresented: Bool
    @Binding var image: Image?
    @Binding var imageData: Data?
    
    init(isPresented: Binding<Bool>, image: Binding<Image?>, imageData: Binding<Data?>) {
        self._isPresented = isPresented
        self._image = image
        self._imageData = imageData
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            let width: CGFloat = 420.0
            let canvas = CGSize(width: width, height: CGFloat(ceil(width / image.size.width * image.size.height)))
            
            let imgResized = UIGraphicsImageRenderer(size: canvas, format: image.imageRendererFormat).image{ _ in
                image.draw(in: CGRect(origin: .zero, size: canvas))
            }
            
            self.image = Image(uiImage: imgResized)
            self.imageData = imgResized.jpegData(compressionQuality: 0.2)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}

