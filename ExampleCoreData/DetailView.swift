//
//  DetailView.swift
//  ExampleCoreData
//
//  Created by Yash Poojary on 22/11/21.
//

import SwiftUI

struct DetailView: View {
    
    var friend: Friend
    
    
    var body: some View {
        VStack {
            
            Text(friend.wrappedName)
                .font(.largeTitle)
                .padding()
            
            getPhotoFrom(uuid: friend.wrappedPhotoId)
                .resizable()
                .scaledToFit()
                .padding()
        }
    }
    
    func getPhotoFrom(uuid: UUID) -> Image {
        let uuid = uuid.uuidString
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(uuid)) else {
            return Image(systemName: "person.crop.circle.badge.questionmark")
        }
        
        guard let uiImage = UIImage(data: data) else {
            return Image(systemName: "person.crop.circle.badge.questionmark")
        }
        
        let image = Image(uiImage: uiImage)
        
        return image
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
