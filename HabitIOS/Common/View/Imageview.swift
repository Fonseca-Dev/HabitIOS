//
//  Imageview.swift
//  HabitIOS
//
//  Created by Kaue Rocha da Fonseca on 11/06/26.
//

import SwiftUI
import Combine

struct Imageview: View {
    
    @State var image: UIImage = UIImage()
    let imageLoader = ImageLoader()
    let url: String
    
    init(url: String){
        self.url = url
    }
    
    var body: some View {
        Image(uiImage: UIImage(data: imageLoader.data) ?? image)
            .resizable()
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
            .onAppear {
                if image.cgImage == nil {
                    imageLoader.load(url: url)
                }
            }
    }
}

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data(){
        didSet {
            didChange.send(data)
        }
    }
    
    func load(url: String){
        // Se ele conseguir instanciar o objeto URL com a url passada ele segue o codigo
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

#Preview {
    Imageview(url: "")
}
