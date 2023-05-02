//
//  AnnouncementRowView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 26/04/2023.
//

import SwiftUI

struct AnnouncementRowView: View {
    let announcement: Announcement
    
    var isExpanded: Bool = false
    
    @State private var animate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                ProfileImageView(announcement.author.imageURL)
                
                if isExpanded {
                    Group {
                        Text(announcement.author.name)
                            .font(.title3)
                        
                        Spacer()
                        
                        Text(announcement.createdDate.formatted(date:.long, time:.omitted))
                    }.opacity(0.8)

                } else {
                    contentView(announcement.content.replacingOccurrences(of: "\n", with: ""))
//                        .font(.title3)
                        .lineLimit(2)
                }
            }
                        
            if isExpanded {
                Divider()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Office party change")
                        .font(.title2)
                    
                        contentView(announcement.content)
                        .font(.title3)
                }
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .overlay(alignment: .top) {
            Color.accentColor.frame(height: isExpanded ? 10 : 0)
        }
        .overlay(alignment: .leading) {
            Color.accentColor.frame(width: isExpanded ? 0 : 5)
        }
        .cornerRadius(isExpanded ? 15 : 0)
        .shadow(radius: isExpanded ? 1 : 0)
        .redacted(reason: animate || !isExpanded ? .init() : .placeholder)
        .animation(.spring(), value: animate)
        .onAppear() {
            guard isExpanded else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                animate = true
            }
        }
    }
    
    private func contentView(_ content: String) -> some View {
        Text(AttributedString(content))
    }
}

#if DEBUG
struct AnnouncementRowView_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementRowView(announcement: .example, isExpanded: false)
    }
}
#endif
