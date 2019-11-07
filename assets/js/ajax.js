import store from './store';

export function post(path, body) {
    let state = store.getState();
    let token = state.session.token;

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
    return fetch('/ajax' + path, {
        method: 'get',
        credentials: 'same-origin',
        headers: new Headers({
            'x-csrf-token': window.csrf_token,
            'content-type': "application/json; charset=UTF-8",
            'accept': 'application/json',
        }),
    }).then((resp) => resp.json());
}


export function list_jobs() {
    get('/jobs')
        .then((resp) => {
            console.log("list_jobs", resp);
            store.dispatch({
                type: 'SHOW_JOBS',
                data: resp.data,
            });
        });
}

