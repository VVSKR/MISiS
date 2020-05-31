//
//  UserDefaults.swift
//  MISiS
//
//  Created by Vova SKR on 31.05.2020.
//  Copyright © 2020 Vova Skripnickenko. All rights reserved.
//

import Foundation


extension UserDefaults {
    
    func setGroup(institute: String?, group: String?) {
        set(institute, forKey: "institute")
        set(group, forKey: "group")
        synchronize()
    }
    
    func setShedule(shedule: ScheduleModel?) {
        set(try? PropertyListEncoder().encode(shedule), forKey: "shedule")
    }
    
    func returnUnstitute() -> String {
        return string(forKey: "institute") ?? ""
    }
    
    func returmGroup() -> String {
        return string(forKey: "group") ?? ""
    }
    
    func returnSchedule() -> ScheduleModel? {
        if let data = UserDefaults.standard.value(forKey: "shedule") as? Data {
            if let shedule = try? PropertyListDecoder().decode(ScheduleModel.self, from: data), shedule.schedule.count != 0 {
                return shedule
            }
        }
        return nil
    }
    
    func deleteUserId() {
        setGroup(institute: "", group: "")
    }
    
    func deleteShedule() {
        setShedule(shedule: nil)
    }
}
