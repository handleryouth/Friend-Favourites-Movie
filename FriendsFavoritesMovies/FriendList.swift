//
//  FriendList.swift
//  FriendsFavoritesMovies
//
//  Created by Tony Gultom on 13/08/24.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Friend.name) private var friends: [Friend]
    
    @State private var newFriend: Friend?
    
    var body: some View {
        NavigationSplitView{
            Group {
                if(!friends.isEmpty) {
                    List{
                        ForEach(friends) {
                            friend in NavigationLink {
                                /*
                                 text inside the detail, after the link has change to another screen
                                 */
                                
                                
//                                Text(friend.name)
//                                    .navigationTitle("Friend")
                                
                                FriendDetail(friend: friend, isNew: false)
                            } label: {
                                /*
                                 text to show
                                 */
                                Text(friend.name)
                                
                            }
                        }.onDelete(perform: deleteFriends)
                    }
                } else {
                    ContentUnavailableView{
                        Label("No Friends", systemImage: "person.and.person")
                    }
                }
            }.navigationTitle("Friends").toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("Add Item", systemImage: "plus") {
                        addFriend()
                    }
                }
                /*
                 When newFriend is set to a non-nil value, the sheet is presented.
                 */
            }.sheet(item: $newFriend) {friend in
                NavigationStack {
                    FriendDetail(friend: friend, isNew:true)
                }
                .interactiveDismissDisabled()
            }
        } detail: {
            Text("Select a friend").navigationTitle("Friend")
        }
        
    }
    
    
    
    private func addFriend() {
        withAnimation{
            let newItem = Friend(name: "")
            newFriend = newItem
            modelContext.insert(newItem)
        }
    }
    
    
    private func deleteFriends(offsets: IndexSet) {
        withAnimation{
            for index in offsets {
                modelContext.delete(friends[index])
            }
        }
    }
    
    
}

#Preview {
    FriendList().modelContainer(SampleData.shared.modelContainer)
}
