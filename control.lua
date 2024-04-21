custom_events=custom_events or {}
global.whistled_trains=global.whistled_trains or {}

require "constants"

custom_events["whistle_train"]=function (event)
    selected_rail=game.get_player(1).selected
    if not selected_rail or not string.find(selected_rail.type,"rail") then
        return
    end
    --find train
    for _,train in pairs(game.get_surface(1).get_trains()) do
        if train.state==defines.train_state.wait_station and has_train_equipment(train,train_whistle_equipment) then
            schedule=train.schedule
            table.insert(schedule.records,{rail=selected_rail,wait_conditions={{type="time",ticks=60,compare_type="and"}}})
            train.schedule=schedule
            train.go_to_station(#schedule.records)
            if train.has_path then
                global.whistled_trains=global.whistled_trains or {}
                global.whistled_trains[train.id]=selected_rail.unit_number
                local time_before_arriving=train.max_forward_speed/2*train.path.size
                game.get_player(1).print({"",{"TIME_ARRIVING"},time_before_arriving})
                return
            else
                table.remove(schedule.records)
                train.schedule=schedule
            end
        end
    end
    game.get_player(1).print({"NO_TRAIN"})
end

require "__Hermios_Framework__.control-libs"

table.insert(list_events.on_train_changed_state,function (event)
    global.whistled_trains=global.whistled_trains or {}
    if global.whistled_trains[event.train.id] and event.train.state==defines.train_state.wait_station then
        event.train.manual_mode=true
        schedule=event.train.schedule
        table.remove(schedule.records)
        schedule.current=#schedule.records
        if schedule.current>0 then
            event.train.schedule=schedule
        end
        global.whistled_trains[event.train.id]=nil
    end
end)