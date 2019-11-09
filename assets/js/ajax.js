import store from './store';

export function post(path, body) {
    let state = store.getState();
    let token="";
    if(state.session)
        token = state.session.token;

    return fetch('/ajax' + path, {
        method: 'post',
        credentials: 'same-origin',
        headers: new Headers({
            'x-csrf-token': window.csrf_token,
            'content-type': "application/json; charset=UTF-8",
            'accept': 'application/json',
            'x-auth': token || "",
        }),
        body: JSON.stringify(body),
    }).then((resp) => resp.json());
}

export function get(path) {
    let state = store.getState();
    let token="";
    let uid=""
    if(state.session)
        token = state.session.token;
        uid = state.session.user_id

    return fetch('/ajax' + path, {
        method: 'get',
        credentials: 'same-origin',
        headers: new Headers({
            'x-csrf-token': window.csrf_token,
            'content-type': "application/json; charset=UTF-8",
            'accept': 'application/json',
            'x-auth': token || "",
            'uid': uid || ""
        }),
    }).then((resp) => resp.json());
}


export function list_jobs() {
  //  console.log("list jobs");
    get('/jobs')
        .then((resp) => {
    //        console.log("list_jobs", resp);
            store.dispatch({
                type: 'SHOW_JOBS',
                data: resp.data,
            });
        });
}

export function get_logs() {
    get('/logsheets')
        .then((resp) => {
            console.log("resp",resp)
            store.dispatch({
                type: 'SHOW_LOGS',
                data: resp.data,
            });
        });
}

export function submit_login(form) {
    let state = store.getState();
    let data = state.forms.login;
    console.log("data")
    console.log(data)
    post('/session', data)
        .then((resp) => {
            console.log(resp);
            if (resp.token) {
                localStorage.setItem('session', JSON.stringify(resp));
                store.dispatch({
                    type: 'LOG_IN',
                    data: resp,
                });
                form.redirect('/');
            }
            else {
                store.dispatch({
                    type: 'CHANGE_LOGIN',
                    data: {errors: JSON.stringify(resp.errors)},
                });
            }
        });
}


export function submit_new_log(form) {
    let state = store.getState();
    console.log("state")
    console.log(state)
    let data = Object.assign({}, state.forms.new_logsheet, state.forms.new_logsheet);
    data["user_id"] = state.session.user_id

    post('/logsheets', data
    ).then((resp) => {
        console.log(resp);
        if (resp.data) {
            store.dispatch({
                type: 'NEW_LOG',
                data: [resp.data],
            });
            form.redirect('/view_Logs');
        } else {
            store.dispatch({
                type: 'NEW_LOG',
                data: {errors: JSON.stringify(resp.errors)},
            });
        }
    }
    )}

    export  function update_log(id,form) {
        let state = store.getState();
        post('/update_task', {sheet: id, user_id: state.session.user_id}
        ).then((resp) => {
                console.log("r",resp);
                if (resp.data) {
                    store.dispatch({
                        type: 'SHOW_LOGS',
                        data: resp.data,
                    });
                    // form.redirect('/view_Logs');
                } else {
                    store.dispatch({
                        type: 'CHANGE_NEW_PHOTO',
                        data: {errors: JSON.stringify(resp.errors)},
                    });
                }
            }
        )
    }