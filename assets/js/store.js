import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze-strict';


function forms(st0, action) {
    let reducer = combineReducers({
        jobs,
    });
    return reducer(st0, action);
}

function jobs(st0 = new Map(), action) {
    switch (action.type) {
        case 'SHOW_JOBS':
            let st1 = new Map(st0);
            console.log(st1)
            for (let job of action.data) {
                st1.set(job.id, job);
            }
            return st1;
        default:
            return st0;
    }
}

function root_reducer(st0, action) {
    console.log("root reducer", st0, action);
    let reducer = combineReducers({
        forms,
    });
    return deepFreeze(reducer(st0, action));
}

let store = createStore(root_reducer);
export default store;