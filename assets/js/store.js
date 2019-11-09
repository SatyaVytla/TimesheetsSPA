import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze-strict';


function forms(st0, action) {
    let reducer = combineReducers({
        jobs,
        login,
        new_logsheet,
    });
    return reducer(st0, action);
}

function new_logsheet(st0 = {date_logged: null, hours1: 0, hours2: 0, hours3: 0, hours4: 0, hours5: 0, hours6: 0, hours7: 0,
    hours8: 0, user_id: null, job_code1: "", job_code2: "", job_code3: "", job_code4: "", job_code5: "",
    job_code6: "", job_code7: "", job_code8: "", errors: null}, action) {
    switch (action.type) {
        case 'NEW_LOG':
            return Object.assign({}, st0, action.data);
        default:
            return st0;
    }
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
            for (let job of action.data) {
                st1.set(job.job_code, job);
            }
            return st1;
        default:
            return st0;
    }
}

function logs(st0 = new Map(), action) {
    switch (action.type) {
        case 'SHOW_LOGS':
            let st1 = new Map(st0);

            for (let log of action.data) {
                st1.set(log.id, log);
            }
            return st1;
        default:
            return st0;
    }
}

function root_reducer(st0, action) {
    let reducer = combineReducers({
        forms,
        users,
        session,
        logs
    });
    return deepFreeze(reducer(st0, action));
}

let store = createStore(root_reducer);
export default store;