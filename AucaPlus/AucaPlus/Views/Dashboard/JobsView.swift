//
//  JobsView.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 02/04/2023.
//

import SwiftUI

struct JobsView: View {
    @StateObject private var jobsStore = JobsStore()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(jobsStore.jobs) { job in
                    JobRowView(job: job)
                        .padding()
                    Divider()
                }
            }
            .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: .all)
            .navigationTitle("Opportunities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
//                        showBookmarks = true
                    } label: {
                        Image(systemName: "bookmark.circle")
                    }

                }
            }
        }
    }
}

extension JobsView  {
    struct JobRowView: View {
        @State var job: Job
        @State private var bookmarked = false
    
        var body: some View {
            VStack(alignment: .leading) {
               
                HStackLayout(alignment: .top) {
                    Text(job.title)
                        .font(.callout)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: bookmarked ? "bookmark.fill" : "bookmark")
                        .onTapGesture {
                            bookmarked.toggle()
                        }
                }
                
                
                Text("By \(Text(job.company.name).underline())")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                
                Text("Posted: \(job.postedDate.formatted())")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if job.verified {
                    HStack(spacing: 2) {
                        Image("verify")
                        Text("Verified")
                    }
                    .font(.caption)
                    .foregroundColor(.green)
                }
            }
        }
    }
}

#if DEBUG
struct JobsView_Previews: PreviewProvider {
    static var previews: some View {
        JobsView()
            .preferredColorScheme(.dark)
    }
}
#endif
