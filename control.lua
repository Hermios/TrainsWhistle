require "__Hermios_Framework__.control-libs"
require "constants"

function on_train_whistled(event)
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
                global.custom_entities[train.id]=selected_rail
                return
            else
                table.remove(schedule.records)
                train.schedule=schedule
            end
        end
    end
    game.get_player(1).print({"NO_TRAIN"})
end

function on_train_changed_state(event)
    if global.custom_entities[event.train.id]==event.train.front_rail and event.train.state==defines.train_state.wait_station then
        event.train.manual_mode=true
        schedule=event.train.schedule
        table.remove(schedule.records)
        schedule.current=#schedule.records
        event.train.schedule=schedule
        global.custom_entities[event.train.id]=nil
    end
end

custom_events=custom_events or {}
custom_events["whistle_train"]=on_train_whistled