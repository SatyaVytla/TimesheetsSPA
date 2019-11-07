import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze-strict';


function forms(st0, action) {
    let reducer = combineReducers({
        jobs,
        login,
    });
    return reducer(st0, action);
}

function login(st0 = {user_name: "", password_hash: "", errors: null}, action) {
    switch(action.type) {
        case 'CHANGE_LOGIN':
            return Object.assign({}, st0, action.data);
        default:
            return st0;
    }
}

function users(st0 = new Map(), action) {
    return st0;
}

let session0 = localStorage.getItem('session');
if (session0) {
    session0 = JSON.parse(session0);
}

function session(st0 = session0, action) {
    switch (action.type) {
        case 'LOG_IN':
            return action.data;
        case 'LOG_OUT':
            return null;
        default:
            return st0;
    }
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