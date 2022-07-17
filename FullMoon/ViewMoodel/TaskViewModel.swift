//
//  TaskViewModel.swift
//  FullMoon
//
//  Created by Batool Hussain on 09/07/2022.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var curretTab: String = "Today"
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadLine: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    @Published var isCompleted: Bool = false
    @Published var editTask: Task?
    
    func addTask(context: NSManagedObjectContext)-> Bool{
        let task = Task(context: context)
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadLine
        task.type = taskType
        task.isCompleted = false
        
        
        
        if let _ = try? context.save(){
            return true
        }
        return false
    }
    
    
    func resetTaskDAte() {
        taskType = "Basic"
        taskColor = "Gray"
        taskTitle = ""
        taskDeadLine = Date()
        
    }
    
    func setupTask(){
        if let editTask = editTask {
            taskType = editTask.type ?? "Basic"
            taskColor = editTask.color ?? "Gray"
            taskTitle = editTask.title ?? ""
            taskDeadLine = editTask.deadline ?? Date()
        }
    }
    
}





