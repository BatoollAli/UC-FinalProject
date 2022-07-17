//
//  Home.swift
//  FullMoon
//
//  Created by Batool Hussain on 09/07/2022.
//

import SwiftUI

struct Home: View {
    
    
    @StateObject var taskModel: TaskViewModel = .init()
    @Namespace var animaion
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    @Environment( \.self) var env
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                VStack(alignment: .center, spacing: 7){
                    Text("You don’t have to be great to start")
                        .font(.callout.bold())
                    Text("but you have to start to be great .. ")
                        .font(.title2.bold())
                }
                .padding()
                CustomSegentedBar()
                    .padding([.leading, .bottom, .trailing], 20)
                    .padding(.top, 5)
                
            }
        }
        .overlay(alignment: .bottom){
            Button{
                taskModel.openEditTask.toggle()
            }label:{
                Label{
                    Text("ADD TASK")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                    
                }
                .foregroundColor(.white)
                .padding(.vertical,15)
                .padding(.horizontal, 20)
                //                .frame(maxWidth: .infinity)
                .background(.black, in: Capsule() )
            }
            .padding(.top,10)
            .frame(maxWidth: .infinity)
            .background{
                LinearGradient(colors: [
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                    .white
                    //                    .blue
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
        .fullScreenCover(isPresented: $taskModel.openEditTask ){
            
            taskModel.resetTaskDAte()
            
        }content:{
            AddNewTask()
                .environmentObject(taskModel)
        }
        .onAppear {
            
            print(taskModel.taskTitle)
            
            
        }
    }
    
    @ViewBuilder func TaskView() -> some View{
        LazyVStack(spacing: 20 ){
            DynamicFilteredView(currentTab: taskModel.curretTab){(task: Task) in
                TaskRowView(task: task)
                
            }
            
        }.padding(.top, 20 )
    }
    
    @ViewBuilder func TaskRowView(task : Task) -> some View{
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                Spacer()
                
                if !task.isCompleted && taskModel.curretTab != "Failed"{
                    Button{
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    }label:{
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                        
                    }
                }
            }
            
            Text(task.title ?? "" )
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical,10)
            
            HStack(alignment: .bottom){
                VStack(alignment: .leading, spacing: 10){
                    Label{
                        Text( (task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    }icon:{
                        Image(systemName: "calnder")
                    }
                    .font(.caption)
                    
                    Label{
                        Text( (task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    }icon:{
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isCompleted && taskModel.curretTab != "Failed"{
                    Button{
                        task.isCompleted.toggle()
                        try? env.managedObjectContext.save()
                    }label:{
                        Circle()
                            .strokeBorder(.black, lineWidth: 2)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    }
                }
            }
            
        }
    
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Gray"))
            
        }
}

    @ViewBuilder func CustomSegentedBar() ->some View{
    let tabs = ["Today", "Upcoming ", "Task Done", "Failed" ]
    HStack(spacing: 10){
        ForEach(tabs,id: \.self){tab in
            Text(tab)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .scaleEffect(0.9)
                .foregroundColor(taskModel.curretTab == tab ? .white : .black)
                .frame (maxWidth: .infinity)
                .background{
                    if taskModel.curretTab == tab{
                        Capsule()
                            .fill(.black)
                            .matchedGeometryEffect(id: "TAB", in: animaion)
                    }
                }.contentShape(Capsule())
                .onTapGesture{
                    withAnimation{taskModel.curretTab = tab }
                }
        }
        
    }
}
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
