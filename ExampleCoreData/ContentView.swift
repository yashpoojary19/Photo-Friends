//
//  ContentView.swift
//  ExampleCoreData
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(entity: Friend.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Friend.name, ascending: true)])
    
    var friends: FetchedResults<Friend>
    
    @State private var showImagePicker = false
    @State private var showImageNamePicker = false
    @State private var name = ""
    @State private var seletedImage: UIImage?

    var body: some View {
        NavigationView {
            List {
                ForEach(friends) { friend in
                    NavigationLink(destination: DetailView(friend: friend)) {
                            HStack {
                                getPhotoFrom(uuid: friend.wrappedPhotoId)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                
                                Text(friend.wrappedName)
                                    .font(.headline)
                            }
                        }
                    }
                  
            }
            .navigationTitle("Photo Friends")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        HStack(spacing: 3) {
                            Image(systemName: "plus.app")
                            Text("Add Friend")
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $showImagePicker, onDismiss: showImageNamePickerfunc) {
                ImagePicker(image: $seletedImage)
            }
            .sheet(isPresented: $showImageNamePicker, onDismiss: saveImage) {
                ImageNameView(name: $name)
            }
        
        }
    }
    
    func showImageNamePickerfunc() {
        showImageNamePicker = true
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    
    func getPhotoFrom(uuid: UUID) -> Image {
        let uuidString = uuid.uuidString
        
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent(uuidString)) else {
            return Image(systemName: "person.crop.circle.badge.questionmark")
        }
        
        guard let uiImage = UIImage(data: data) else {
            return Image(systemName: "person.crop.circle.badge.questionmark")
        }
        
        return Image(uiImage: uiImage)
    }
    
    func saveImage() {
        let newFriend = Friend(context: moc)
        let uuid = UUID()
        
        newFriend.name = name
        newFriend.details = ""
        newFriend.photoid = uuid
        
        
        do {
            if let jpegData = seletedImage?.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: getDocumentsDirectory().appendingPathComponent(uuid.uuidString), options: [.atomicWrite, .completeFileProtection])
            }

            try moc.save()
        } catch {
            print("There was an error")
        }
    }
    
    

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
