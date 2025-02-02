//
//  AddNewTask.swift
//  FullMoon
//
//  Created by Batool Hussain on 13/07/2022.
//

import SwiftUI

struct AddNewTask: View {
    
    @EnvironmentObject var taskModel: TaskViewModel
    @Environment(\.self) var env
    
    @Namespace var animation
    var body: some View {
        VStack(spacing: 12){
            HStack{
                Button{
                    env.dismiss()
                }label: {
                    Image(systemName: ("arrow.left"))
                        .font(.title3)
                        .foregroundColor(.black)
                }
                Text("Edit Task")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
                //                    .overlay(alignment: .leading)
            }
            .overlay(alignment: .trailing){
                Button{
                    if editTask = taskModel.editTask{
                        env.managedObjectContext.delete(editTask)
                        try? env.managedObjectContext.save()
                        env.dismiss()
                    }
                  
                }label: {
                    Image(systemName: ("trash"))
                        .font(.title3)
                        .foregroundColor(.red)
                }
                .opacity(taskModel.editTask == nill ? 0 : 1)
            }
                Text("Edit Task")
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity)
            }
            VStack(alignment: .leading, spacing: 12){
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                let colors :[String] =
                ["Yellow", "Green", "Blue", "Purple", "Red", "Orange"]
                
                HStack(spacing: 12){
                    ForEach(colors,id: \.self){
                        color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
                            .background{
                                if taskModel.taskColor == color{
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-3)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture{
                                taskModel.taskColor = color
                            }
                        
                    }
                }
                .padding(.top, 10)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30 )
            
            Divider()
                .padding(.vertical, 10)
            VStack(alignment: .leading, spacing: 10){
                
                Text("Task Deadline")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                
                //            .overlay(alignment: .bottomLeading)
                HStack{
                    Text(taskModel.taskDeadLine.formatted(date: .abbreviated, time: .omitted) + "," + taskModel.taskDeadLine.formatted(date: .omitted, time: .shortened))
                        .frame( maxWidth: .infinity)
                        .font(.callout.bold())
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                    
                    
                    
                    Button{
                        taskModel.showDatePicker.toggle()
                    }label:{
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                            .font(.system(size: 20))
                    }
                    
                    
                    
                }
            }
            Divider()
            VStack(alignment: .leading, spacing: 12){
                
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                
                //            .overlay(alignment: .bottomLeading)
                
                TextField(" ",text: $taskModel.taskTitle)
                    .frame( maxWidth: .infinity)
                    .padding(.top, 10)
                    .font(.system(size: 20))
                
                
                
                
                
                
            }
            Divider()
            
            let taskType: [String] = ["Basic", "Urgent", "Important"]
            VStack(alignment: .leading, spacing: 12){
                
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                
                
                //            .overlay(alignment: .bottomLeading)
                HStack(spacing: 12){
                    ForEach(taskType,id: \.self){
                        type in Text(type)
                            .font(.callout.bold())
                            .padding(.vertical,8)
                            .frame( maxWidth: .infinity)
                            .foregroundColor(taskModel.taskType == type ? .white : .black)
                            .background{
                                if taskModel.taskType == type{
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                }else{
                                    Capsule()
                                        .strokeBorder(.black)
                                    
                                }
                            }.contentShape(Capsule())
                            .onTapGesture{
                                withAnimation{taskModel.taskType = type}
                            }
                    }
                }
                .padding(.top , 8)
            }
            .padding(.vertical, 10)
            Divider()
            
            
            
            Button{
                
            }label:{
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame( maxWidth: .infinity)
                    .padding(.vertical,12)
                    .foregroundColor(.white)
                    .background{
                        Capsule()
                            .fill(.black)
                    }
            }
            .frame( maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(taskModel.taskTitle == "" )
            .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
        }
        
        
//        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay{
            ZStack{
                if taskModel.showDatePicker{
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture{
                            taskModel.showDatePicker = false
                        }
                    
                    DatePicker.init("", selection: $taskModel.taskDeadLine,in:
                                        Date.now...Date.distantFuture)
//                    .datePickerStyle(.gras)
                    .labelsHidden()
                    .padding()
                    .background(.white , in: RoundedRectangle(cornerRadius: 12,style: .continuous))
                    .padding()
                }
                
            }
            .animation(.easeInOut, value: taskModel.showDatePicker)
            
            
        }
        
    }



struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}
