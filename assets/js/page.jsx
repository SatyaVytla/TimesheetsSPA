import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Switch, Route, NavLink, Link } from 'react-router-dom';
import { Navbar, Nav, Col } from 'react-bootstrap';
import SheetNew from './logsheets/newsheet';
import ShowLogs from './logsheets/viewlogs';
import { Provider, connect } from 'react-redux';
import store from './store';
import Login from './login';

export default function init_page(root) {
    let tree = (
        <Provider store={store}>
            <Page />
        </Provider>
    );
    ReactDOM.render(tree, root);
}

function Page(props) {

    return (
        <Router>
            <Navbar bg="dark" variant="dark">
                <Nav>
                    <Nav.Item>
                        <NavLink to="/" exact activeClassName="active" className="nav-link">
                            Home
                        </NavLink>
                    </Nav.Item>
                </Nav>
                    <Session />
            </Navbar>

            <Switch>
                <Route exact path="/">
                    <h3>Timesheets Home. Please use actions from navigation</h3>
                </Route>

                <Route exact path="/create">
                    <SheetNew />
                </Route>
                <Route exact path="/login">
                    <Login />
                </Route>
                <Route exact path="/view_Logs">
                    <ShowLogs />
                </Route>
            </Switch>
        </Router>

    );
}

let Session = connect(({session}) => ({session}))(({session, dispatch}) => {
    function logout(ev) {
        ev.preventDefault();
        localStorage.removeItem('session');
        dispatch({
            type: 'LOG_OUT',
        });
    }

    if (session) {
        if(session.manager){
            return (
                <Nav>

                    <Nav.Item>
                        <NavLink to="/view_Logs" exact activeClassName="active" className="nav-link">
                            View Logs
                        </NavLink>
                    </Nav.Item>
                    <Nav.Item>
                        <p className="text-light py-2">User: {session.user_name}</p>
                    </Nav.Item>
                    <Nav.Item>
                        <a className="nav-link" href="#" onClick={logout}>Logout</a>
                    </Nav.Item>
                </Nav>
            );
        }
        else{
            return (
                <Nav>

                    <Nav.Item>
                        <NavLink to="/view_Logs" exact activeClassName="active" className="nav-link">
                            View Logs
                        </NavLink>
                    </Nav.Item>
                    <Nav.Item>
                        <NavLink to="/create" exact activeClassName="active" className="nav-link">
                            Create Timesheet
                        </NavLink>
                    </Nav.Item>
                    <Nav.Item>
                        <p className="text-light py-2">User: {session.user_name}</p>
                    </Nav.Item>
                    <Nav.Item>
                        <a className="nav-link" href="#" onClick={logout}>Logout</a>
                    </Nav.Item>
                </Nav>
            );
        }
    }
    else {
        return (
            <Nav>
                <Nav.Item>
                    <NavLink to="/login" exact activeClassName="active" className="nav-link">
                        Login
                    </NavLink>
                </Nav.Item>
            </Nav>
        );
    }
});