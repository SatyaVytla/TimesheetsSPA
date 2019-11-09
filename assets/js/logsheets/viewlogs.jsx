import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';

import {get_logs, update_log} from '../ajax';
import {Table, Button} from "react-bootstrap";
import { Redirect } from 'react-router';


function state2props(state, props) {
        return {logs: state.logs, session: state.session};
}

class ShowLogs extends React.Component {
        constructor (props) {
                super(props);
                this.state = {
                redirect: null,

            }

                get_logs()
        }

        changed(id){

            update_log(id, this)

        }

    redirect(path) {
        this.setState({redirect: path});
    }

        render() {


                let logs = this.props.logs
                let manager = this.props.session.manager
                let renderCon = []

                for (var [key, value] of logs) {

                    if(manager){
                    renderCon.push(<tr><td>{value.user_id}</td><td>{value.date_logged}</td><td>{value.job_code}</td><td>{value.hours}</td>
                        <td>{value.approve ? "Yes" :   <Button id={value.id} variant="link" onClick={(e) => this.changed(e.target.id)}>Approve</Button>}</td></tr>)
                    }else{
                        renderCon.push(<tr><td>{value.user_id}</td><td>{value.date_logged}</td><td>{value.job_code}</td><td>{value.hours}</td>
                            <td>{value.approve ? "Yes" : "Not yet"}</td></tr>)
                    }
                }
            if (this.state.redirect) {
                return <Redirect to={this.state.redirect} />;
            }
                //https://react-bootstrap.github.io/components/table/
                return (
                    <div>
                            <h2>Showing Tasks Submitted</h2>
                        <Table striped bordered hover>
                                    <thead>
                                        <tr><th>Worker Id</th><th>Date Logged</th><th>Job Code</th><th>Hours</th><th>Approved</th></tr>
                                    </thead>
                                    <tbody>
                                    {renderCon}
                                    </tbody>
                        </Table>
                    </div>
                );

        }
}



export default connect(state2props)(ShowLogs);